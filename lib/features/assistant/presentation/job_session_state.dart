import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/features/jobs/domain/job.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_session_state.freezed.dart';

@freezed
sealed class TimelineItem with _$TimelineItem {
  const factory TimelineItem.user({required String text, String? imagePath}) =
      UserTimelineItem;

  const factory TimelineItem.model({
    required String text,
    required List<String> surfaceIds,
  }) = ModelTimelineItem;
}

@freezed
abstract class JobSessionState with _$JobSessionState {
  const factory JobSessionState({
    Job? job,
    @Default(<TimelineItem>[]) List<TimelineItem> timeline,
    @Default(true) bool isLoading,
    @Default(false) bool isGenerating,
    AppFailure? failure,
  }) = _JobSessionState;

  const JobSessionState._();

  bool get isDraft => job == null;
}
