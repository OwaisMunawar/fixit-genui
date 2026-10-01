import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:fixit/features/jobs/domain/checklist_ref.dart';
import 'package:fixit/features/jobs/domain/job.dart';
import 'package:fixit/features/jobs/domain/job_entry.dart';
import 'package:fixit/features/jobs/domain/job_progress.dart';
import 'package:fixit/features/jobs/domain/job_repository.dart';
import 'package:fixit/features/jobs/domain/photo_store.dart';
import 'package:fixit/genui/generator/repair_generator.dart';
import 'package:fixit/genui/generator/repair_request.dart';

/// Returns queued responses in order and records every request.
final class QueuedGenerator implements RepairGenerator {
  QueuedGenerator([Iterable<Object> responses = const []])
    : _responses = Queue.of(responses);

  final Queue<Object> _responses;
  final requests = <RepairRequest>[];

  void enqueue(Object response) => _responses.add(response);

  @override
  Future<String> generate(RepairRequest request) async {
    requests.add(request);
    final next = _responses.removeFirst();
    if (next is Exception) throw next;
    return next as String;
  }
}

final class MemoryPhotoStore implements PhotoStore {
  final files = <String, Uint8List>{};
  final deletedJobs = <String>[];
  var _counter = 0;

  @override
  Future<String> save(String jobId, Uint8List jpegBytes) async {
    final path = 'jobs/$jobId/${_counter++}.jpg';
    files[path] = jpegBytes;
    return path;
  }

  @override
  Future<Uint8List?> read(String relativePath) async => files[relativePath];

  @override
  String absolutePath(String relativePath) => '/memory/$relativePath';

  @override
  Future<void> deleteJob(String jobId) async {
    deletedJobs.add(jobId);
    files.removeWhere((path, _) => path.startsWith('jobs/$jobId/'));
  }
}

/// A repository that lives entirely in fake-async time, for widget tests.
/// The drift implementation has its own tests against an in-memory database.
final class InMemoryJobRepository implements JobRepository {
  final _jobs = <String, Job>{};
  final _entries = <String, List<JobEntry>>{};
  final _progress = <String, Map<ChecklistKey, Set<String>>>{};
  final _changes = StreamController<void>.broadcast();

  List<Job> get _sorted =>
      _jobs.values.toList()..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

  @override
  Stream<List<Job>> watchJobs() async* {
    yield _sorted;
    await for (final _ in _changes.stream) {
      yield _sorted;
    }
  }

  void _changed() => _changes.add(null);

  @override
  Future<Job?> findJob(String id) async => _jobs[id];

  @override
  Future<void> createJob(Job job) async {
    _jobs[job.id] = job;
    _changed();
  }

  @override
  Future<void> deleteJob(String id) async {
    _jobs.remove(id);
    _entries.remove(id);
    _progress.remove(id);
    _changed();
  }

  @override
  Future<List<JobEntry>> entries(String jobId) async => [
    ...?_entries[jobId],
  ];

  @override
  Future<void> appendEntry(String jobId, JobEntry entry) async =>
      _entries.putIfAbsent(jobId, () => []).add(entry);

  @override
  Future<Map<ChecklistKey, Set<String>>> checklistProgress(
    String jobId,
  ) async => {...?_progress[jobId]};

  @override
  Future<void> saveChecklistProgress(
    String jobId,
    ChecklistKey key,
    Set<String> completedStepIds,
  ) async => _progress.putIfAbsent(jobId, () => {})[key] = completedStepIds;

  @override
  Future<void> updateProgress(
    String jobId,
    JobProgress progress, {
    required DateTime at,
  }) async {
    final job = _jobs[jobId];
    if (job == null) return;
    _jobs[jobId] = job.copyWith(
      status: progress.status,
      completedSteps: progress.completedSteps,
      totalSteps: progress.totalSteps,
      updatedAt: at,
    );
    _changed();
  }

  @override
  Future<void> setThumbnail(String jobId, String path) async {
    final job = _jobs[jobId];
    if (job != null) _jobs[jobId] = job.copyWith(thumbnailPath: path);
    _changed();
  }
}
