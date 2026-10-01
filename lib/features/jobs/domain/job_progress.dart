import 'package:fixit/features/jobs/domain/checklist_ref.dart';
import 'package:fixit/features/jobs/domain/job_status.dart';
import 'package:flutter/foundation.dart';

@immutable
final class JobProgress {
  const JobProgress({
    required this.status,
    required this.completedSteps,
    required this.totalSteps,
  });

  /// Status follows the most recent checklist, because a later answer
  /// supersedes an earlier plan: if the model replaced "reset the breaker"
  /// with "make it safe", the job is done when the new list is done.
  factory JobProgress.derive({
    required List<ChecklistRef> checklists,
    required Map<ChecklistKey, Set<String>> completed,
  }) {
    if (checklists.isEmpty) return diagnosing;
    final latest = checklists.last;
    final ticked = completed[latest.key] ?? const <String>{};
    final done = latest.stepIds.where(ticked.contains).length;
    final total = latest.stepIds.length;
    return JobProgress(
      status: total > 0 && done == total
          ? JobStatus.done
          : JobStatus.inProgress,
      completedSteps: done,
      totalSteps: total,
    );
  }

  static const diagnosing = JobProgress(
    status: JobStatus.diagnosing,
    completedSteps: 0,
    totalSteps: 0,
  );

  final JobStatus status;
  final int completedSteps;
  final int totalSteps;

  @override
  bool operator ==(Object other) =>
      other is JobProgress &&
      other.status == status &&
      other.completedSteps == completedSteps &&
      other.totalSteps == totalSteps;

  @override
  int get hashCode => Object.hash(status, completedSteps, totalSteps);
}
