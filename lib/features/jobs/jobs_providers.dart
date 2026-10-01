import 'package:fixit/features/jobs/data/database/app_database.dart';
import 'package:fixit/features/jobs/data/drift_job_repository.dart';
import 'package:fixit/features/jobs/domain/job.dart';
import 'package:fixit/features/jobs/domain/job_repository.dart';
import 'package:fixit/features/jobs/domain/photo_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.onDevice();
  ref.onDispose(db.close);
  return db;
});

/// Needs the documents directory, which is only known after an async
/// lookup, so `bootstrap` supplies it.
final photoStoreProvider = Provider<PhotoStore>(
  (ref) => throw UnimplementedError('photoStoreProvider is set in bootstrap'),
);

final jobRepositoryProvider = Provider<JobRepository>(
  (ref) => DriftJobRepository(ref.watch(appDatabaseProvider)),
);

final jobsProvider = StreamProvider<List<Job>>(
  (ref) => ref.watch(jobRepositoryProvider).watchJobs(),
);

/// The job open in the detail pane on wide layouts.
final selectedJobIdProvider = NotifierProvider<SelectedJobId, String?>(
  SelectedJobId.new,
);

class SelectedJobId extends Notifier<String?> {
  @override
  String? build() => null;

  // A method rather than a setter so call sites read as an action:
  // `ref.read(selectedJobIdProvider.notifier).select(id)`.
  // ignore: use_setters_to_change_properties
  void select(String? id) => state = id;
}

final jobsActionsProvider = Provider<JobsActions>(
  (ref) => JobsActions(
    repository: ref.watch(jobRepositoryProvider),
    photos: ref.watch(photoStoreProvider),
  ),
);

final class JobsActions {
  const JobsActions({required this.repository, required this.photos});

  final JobRepository repository;
  final PhotoStore photos;

  Future<void> delete(String jobId) async {
    await repository.deleteJob(jobId);
    await photos.deleteJob(jobId);
  }
}
