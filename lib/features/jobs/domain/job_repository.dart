import 'package:fixit/features/jobs/domain/checklist_ref.dart';
import 'package:fixit/features/jobs/domain/job.dart';
import 'package:fixit/features/jobs/domain/job_entry.dart';
import 'package:fixit/features/jobs/domain/job_progress.dart';

/// Persistence for jobs. Implementations throw `StorageFailure`.
abstract interface class JobRepository {
  Stream<List<Job>> watchJobs();

  Future<Job?> findJob(String id);

  Future<void> createJob(Job job);

  Future<void> deleteJob(String id);

  Future<List<JobEntry>> entries(String jobId);

  Future<void> appendEntry(String jobId, JobEntry entry);

  Future<Map<ChecklistKey, Set<String>>> checklistProgress(String jobId);

  Future<void> saveChecklistProgress(
    String jobId,
    ChecklistKey key,
    Set<String> completedStepIds,
  );

  Future<void> updateProgress(
    String jobId,
    JobProgress progress, {
    required DateTime at,
  });

  Future<void> setThumbnail(String jobId, String path);
}
