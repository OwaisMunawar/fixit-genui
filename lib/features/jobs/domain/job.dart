import 'package:fixit/features/jobs/domain/job_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job.freezed.dart';

/// A saved repair conversation, as listed on the jobs screen.
///
/// Progress is denormalised onto the job so the list never has to replay
/// generated UI to show "3/7 steps".
@freezed
abstract class Job with _$Job {
  const factory Job({
    required String id,
    required String title,
    required JobStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int completedSteps,
    @Default(0) int totalSteps,
    String? thumbnailPath,
  }) = _Job;
}
