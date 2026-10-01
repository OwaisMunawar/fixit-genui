import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/features/jobs/data/database/app_database.dart';
import 'package:fixit/features/jobs/domain/checklist_ref.dart';
import 'package:fixit/features/jobs/domain/job.dart';
import 'package:fixit/features/jobs/domain/job_entry.dart';
import 'package:fixit/features/jobs/domain/job_progress.dart';
import 'package:fixit/features/jobs/domain/job_repository.dart';

final class DriftJobRepository implements JobRepository {
  DriftJobRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Job>> watchJobs() {
    final query = _db.select(_db.jobs)
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);
    return query.watch().map((rows) => rows.map(_toJob).toList());
  }

  @override
  Future<Job?> findJob(String id) => _guard(() async {
    final row = await (_db.select(
      _db.jobs,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toJob(row);
  });

  @override
  Future<void> createJob(Job job) => _guard(
    () => _db
        .into(_db.jobs)
        .insert(
          JobsCompanion.insert(
            id: job.id,
            title: job.title,
            status: job.status,
            createdAt: job.createdAt,
            updatedAt: job.updatedAt,
            completedSteps: Value(job.completedSteps),
            totalSteps: Value(job.totalSteps),
            thumbnailPath: Value(job.thumbnailPath),
          ),
        ),
  );

  @override
  Future<void> deleteJob(String id) =>
      _guard(() => (_db.delete(_db.jobs)..where((t) => t.id.equals(id))).go());

  @override
  Future<List<JobEntry>> entries(String jobId) => _guard(() async {
    final rows =
        await (_db.select(_db.jobEntries)
              ..where((t) => t.jobId.equals(jobId))
              ..orderBy([(t) => OrderingTerm.asc(t.seq)]))
            .get();
    return [
      for (final row in rows)
        JobEntry.fromJson(jsonDecode(row.payload) as Map<String, Object?>),
    ];
  });

  @override
  Future<void> appendEntry(String jobId, JobEntry entry) => _guard(
    () => _db.transaction(() async {
      final maxSeq = _db.jobEntries.seq.max();
      final current =
          await (_db.selectOnly(_db.jobEntries)
                ..addColumns([maxSeq])
                ..where(_db.jobEntries.jobId.equals(jobId)))
              .map((row) => row.read(maxSeq))
              .getSingleOrNull();
      await _db
          .into(_db.jobEntries)
          .insert(
            JobEntriesCompanion.insert(
              jobId: jobId,
              seq: (current ?? -1) + 1,
              payload: jsonEncode(entry.toJson()),
            ),
          );
    }),
  );

  @override
  Future<Map<ChecklistKey, Set<String>>> checklistProgress(String jobId) =>
      _guard(() async {
        final rows = await (_db.select(
          _db.checklistProgress,
        )..where((t) => t.jobId.equals(jobId))).get();
        return {
          for (final row in rows)
            (surfaceId: row.surfaceId, componentId: row.componentId): {
              ...(jsonDecode(row.completedStepIds) as List).cast<String>(),
            },
        };
      });

  @override
  Future<void> saveChecklistProgress(
    String jobId,
    ChecklistKey key,
    Set<String> completedStepIds,
  ) => _guard(
    () => _db
        .into(_db.checklistProgress)
        .insertOnConflictUpdate(
          ChecklistProgressCompanion.insert(
            jobId: jobId,
            surfaceId: key.surfaceId,
            componentId: key.componentId,
            completedStepIds: jsonEncode(completedStepIds.toList()..sort()),
          ),
        ),
  );

  @override
  Future<void> updateProgress(
    String jobId,
    JobProgress progress, {
    required DateTime at,
  }) => _guard(
    () => (_db.update(_db.jobs)..where((t) => t.id.equals(jobId))).write(
      JobsCompanion(
        status: Value(progress.status),
        completedSteps: Value(progress.completedSteps),
        totalSteps: Value(progress.totalSteps),
        updatedAt: Value(at),
      ),
    ),
  );

  @override
  Future<void> setThumbnail(String jobId, String path) => _guard(
    () => (_db.update(_db.jobs)..where((t) => t.id.equals(jobId))).write(
      JobsCompanion(thumbnailPath: Value(path)),
    ),
  );

  static Job _toJob(JobRow row) => Job(
    id: row.id,
    title: row.title,
    status: row.status,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    completedSteps: row.completedSteps,
    totalSteps: row.totalSteps,
    thumbnailPath: row.thumbnailPath,
  );

  /// Converts anything drift or sqlite throws into the one failure type the
  /// UI knows how to explain.
  static Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on AppFailure {
      rethrow;
    } on Object catch (error) {
      throw StorageFailure(error);
    }
  }
}
