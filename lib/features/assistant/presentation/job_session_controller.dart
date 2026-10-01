import 'dart:async';

import 'package:fixit/core/di/core_providers.dart';
import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/features/assistant/data/job_entry_mapper.dart';
import 'package:fixit/features/assistant/domain/picked_photo.dart';
import 'package:fixit/features/assistant/presentation/job_session_state.dart';
import 'package:fixit/features/jobs/domain/checklist_ref.dart';
import 'package:fixit/features/jobs/domain/job.dart';
import 'package:fixit/features/jobs/domain/job_entry.dart';
import 'package:fixit/features/jobs/domain/job_progress.dart';
import 'package:fixit/features/jobs/domain/job_repository.dart';
import 'package:fixit/features/jobs/domain/job_status.dart';
import 'package:fixit/features/jobs/domain/job_title.dart';
import 'package:fixit/features/jobs/domain/photo_store.dart';
import 'package:fixit/features/jobs/jobs_providers.dart';
import 'package:fixit/genui/generator/repair_request.dart';
import 'package:fixit/genui/genui_providers.dart';
import 'package:fixit/genui/session/completed_turn.dart';
import 'package:fixit/genui/session/genui_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:genui/genui.dart';

final NotifierProviderFamily<JobSessionController, JobSessionState, String>
jobSessionControllerProvider = NotifierProvider.autoDispose
    .family<JobSessionController, JobSessionState, String>(
      JobSessionController.new,
    );

/// Runs one job: owns its genui session, persists every turn and every
/// ticked step, and keeps the job's status in step with its checklist.
class JobSessionController extends Notifier<JobSessionState> {
  JobSessionController(this.jobId);

  final String jobId;

  late JobRepository _repository;
  late PhotoStore _photos;
  late JobEntryMapper _mapper;
  late DateTime Function() _now;
  late GenUiSession _session;
  StreamSubscription<ConversationEvent>? _events;

  final _checklists = <ChecklistRef>[];
  final _progress = <ChecklistKey, Set<String>>{};

  @override
  JobSessionState build() {
    _repository = ref.watch(jobRepositoryProvider);
    _photos = ref.watch(photoStoreProvider);
    _mapper = JobEntryMapper(_photos);
    _now = ref.watch(clockProvider);
    _session = GenUiSession(
      generator: ref.watch(repairGeneratorProvider),
      onCommit: _commit,
    );
    _session.state.addListener(_onConversationState);
    _events = _session.events.listen(_onEvent);
    ref.onDispose(() {
      _session.state.removeListener(_onConversationState);
      unawaited(_events?.cancel());
      _session.dispose();
    });
    unawaited(Future.microtask(_load));
    return const JobSessionState();
  }

  SurfaceContext surfaceContext(String surfaceId) =>
      _session.surfaceContext(surfaceId);

  Future<void> send(String text, {PickedPhoto? photo}) async {
    final trimmed = text.trim();
    if (state.isGenerating || state.isLoading) return;
    if (trimmed.isEmpty && photo == null) return;

    String? imagePath;
    try {
      final job = state.job ?? await _createJob(trimmed);
      if (photo != null) {
        imagePath = await _photos.save(jobId, photo.bytes);
        if (job.thumbnailPath == null) {
          await _repository.setThumbnail(jobId, imagePath);
        }
      }
      await _repository.appendEntry(
        jobId,
        JobEntry.user(text: trimmed, imagePath: imagePath, createdAt: _now()),
      );
      if (!ref.mounted) return;
      state = state.copyWith(
        job: imagePath != null && job.thumbnailPath == null
            ? job.copyWith(thumbnailPath: imagePath)
            : job,
        failure: null,
        timeline: [
          ...state.timeline,
          TimelineItem.user(text: trimmed, imagePath: imagePath),
        ],
      );
    } on AppFailure catch (failure) {
      if (ref.mounted) state = state.copyWith(failure: failure);
      return;
    }

    await _session.send(
      TextInput(
        text: trimmed,
        image: photo == null
            ? null
            : ImageAttachment(
                bytes: photo.bytes,
                mimeType: photo.mimeType,
                path: imagePath,
              ),
      ),
    );
  }

  Future<void> retry() async {
    state = state.copyWith(failure: null);
    await _session.retry();
  }

  void dismissFailure() => state = state.copyWith(failure: null);

  /// Called by generated checklists through `FixitSurfaceScope`.
  Future<void> onChecklistChanged(
    String surfaceId,
    String componentId,
    Set<String> completed,
  ) async {
    final key = (surfaceId: surfaceId, componentId: componentId);
    _progress[key] = completed;
    try {
      await _repository.saveChecklistProgress(jobId, key, completed);
      await _updateProgress();
    } on AppFailure catch (failure) {
      if (ref.mounted) state = state.copyWith(failure: failure);
    }
  }

  Future<Job> _createJob(String prompt) async {
    final now = _now();
    final job = Job(
      id: jobId,
      title: JobTitle.fromPrompt(prompt, fallback: ''),
      status: JobStatus.diagnosing,
      createdAt: now,
      updatedAt: now,
    );
    await _repository.createJob(job);
    return job;
  }

  Future<void> _load() async {
    try {
      final job = await _repository.findJob(jobId);
      if (!ref.mounted) return;
      if (job == null) {
        state = state.copyWith(isLoading: false);
        return;
      }
      final entries = await _repository.entries(jobId);
      final progress = await _repository.checklistProgress(jobId);
      final snapshot = await _mapper.snapshotFor(entries, progress);
      if (!ref.mounted) return;

      _session.restore(snapshot);
      _progress.addAll(progress);
      _checklists.addAll(
        entries.whereType<ModelEntry>().expand((e) => e.checklists),
      );
      state = state.copyWith(
        job: job,
        isLoading: false,
        timeline: [
          for (final entry in entries)
            switch (entry) {
              UserEntry(:final text, :final imagePath) => TimelineItem.user(
                text: text,
                imagePath: imagePath,
              ),
              ModelEntry(:final text, :final surfaceIds) => TimelineItem.model(
                text: text,
                surfaceIds: surfaceIds,
              ),
              AnswersEntry() => null,
            },
        ].nonNulls.toList(),
      );
    } on AppFailure catch (failure) {
      if (ref.mounted) {
        state = state.copyWith(isLoading: false, failure: failure);
      }
    }
  }

  Future<void> _commit(CompletedTurn turn) async {
    for (final entry in _mapper.entriesFor(turn, at: _now())) {
      await _repository.appendEntry(jobId, entry);
    }
    _checklists.addAll(JobEntryMapper.checklistsFor(turn));
    await _updateProgress();
    if (!ref.mounted) return;
    state = state.copyWith(
      timeline: [
        ...state.timeline,
        TimelineItem.model(
          text: turn.processed.text,
          surfaceIds: turn.processed.surfaceIds,
        ),
      ],
    );
  }

  Future<void> _updateProgress() async {
    final progress = JobProgress.derive(
      checklists: _checklists,
      completed: _progress,
    );
    final now = _now();
    await _repository.updateProgress(jobId, progress, at: now);
    if (!ref.mounted) return;
    state = state.copyWith(
      job: state.job?.copyWith(
        status: progress.status,
        completedSteps: progress.completedSteps,
        totalSteps: progress.totalSteps,
        updatedAt: now,
      ),
    );
  }

  void _onConversationState() {
    if (!ref.mounted) return;
    final waiting = _session.state.value.isWaiting;
    if (waiting != state.isGenerating) {
      state = state.copyWith(isGenerating: waiting);
    }
  }

  void _onEvent(ConversationEvent event) {
    if (event is! ConversationError || !ref.mounted) return;
    final error = event.error;
    genUiLogger.warning('Turn failed', error, event.stackTrace);
    state = state.copyWith(
      failure: error is AppFailure ? error : UnexpectedFailure(error),
    );
  }
}
