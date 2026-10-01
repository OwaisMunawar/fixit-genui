import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/features/jobs/data/database/app_database.dart';
import 'package:fixit/features/jobs/data/drift_job_repository.dart';
import 'package:fixit/features/jobs/domain/job.dart';
import 'package:fixit/features/jobs/domain/job_entry.dart';
import 'package:fixit/features/jobs/domain/job_progress.dart';
import 'package:fixit/features/jobs/domain/job_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftJobRepository repository;

  setUp(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftJobRepository(db);
  });

  tearDown(() => db.close());

  Job job(String id, DateTime updated) => Job(
    id: id,
    title: 'Job $id',
    status: JobStatus.diagnosing,
    createdAt: DateTime(2026),
    updatedAt: updated,
  );

  test('creates, finds and lists jobs newest first', () async {
    await repository.createJob(job('old', DateTime(2026)));
    await repository.createJob(job('new', DateTime(2026, 2)));

    expect((await repository.findJob('old'))!.title, 'Job old');
    expect(await repository.findJob('missing'), isNull);
    expect(
      (await repository.watchJobs().first).map((j) => j.id),
      ['new', 'old'],
    );
  });

  test('appends entries in order and reads them back typed', () async {
    await repository.createJob(job('a', DateTime(2026)));
    await repository.appendEntry(
      'a',
      JobEntry.user(text: 'first', createdAt: DateTime(2026)),
    );
    await repository.appendEntry(
      'a',
      JobEntry.model(
        rawResponse: 'raw',
        text: '',
        surfaceIds: const ['t0-0'],
        messages: const [],
        createdAt: DateTime(2026),
      ),
    );

    final entries = await repository.entries('a');
    expect(entries.first, isA<UserEntry>());
    expect(entries.last, isA<ModelEntry>());
  });

  test('stores checklist progress per surface and updates the job', () async {
    await repository.createJob(job('a', DateTime(2026)));
    const key = (surfaceId: 't1-0', componentId: 'checklist');

    await repository.saveChecklistProgress('a', key, {'b', 'a'});
    await repository.saveChecklistProgress('a', key, {'a'});
    await repository.updateProgress(
      'a',
      const JobProgress(
        status: JobStatus.inProgress,
        completedSteps: 1,
        totalSteps: 3,
      ),
      at: DateTime(2026, 3),
    );
    await repository.setThumbnail('a', 'jobs/a/1.jpg');

    expect(await repository.checklistProgress('a'), {
      key: {'a'},
    });
    final updated = (await repository.findJob('a'))!;
    expect(updated.status, JobStatus.inProgress);
    expect((updated.completedSteps, updated.totalSteps), (1, 3));
    expect(updated.updatedAt, DateTime(2026, 3));
    expect(updated.thumbnailPath, 'jobs/a/1.jpg');
  });

  test('deleting a job cascades to its history and progress', () async {
    await repository.createJob(job('a', DateTime(2026)));
    await repository.appendEntry(
      'a',
      JobEntry.user(text: 'x', createdAt: DateTime(2026)),
    );
    await repository.saveChecklistProgress(
      'a',
      (
        surfaceId: 's',
        componentId: 'c',
      ),
      {'a'},
    );

    await repository.deleteJob('a');

    expect(await repository.entries('a'), isEmpty);
    expect(await repository.checklistProgress('a'), isEmpty);
  });

  test('wraps database errors in a StorageFailure', () async {
    await repository.createJob(job('a', DateTime(2026)));

    await expectLater(
      repository.createJob(job('a', DateTime(2026))),
      throwsA(isA<StorageFailure>()),
    );
    await expectLater(
      repository.appendEntry(
        'no-such-job',
        JobEntry.user(text: 'x', createdAt: DateTime(2026)),
      ),
      throwsA(isA<StorageFailure>()),
    );
  });
}
