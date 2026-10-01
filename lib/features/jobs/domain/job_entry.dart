import 'package:fixit/features/jobs/domain/checklist_ref.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_entry.freezed.dart';
part 'job_entry.g.dart';

/// One item in a job's history. Stored as JSON so new fields never need a
/// table migration.
@Freezed(unionKey: 'kind')
sealed class JobEntry with _$JobEntry {
  const factory JobEntry.user({
    required String text,
    required DateTime createdAt,
    String? imagePath,
  }) = UserEntry;

  const factory JobEntry.answers({
    required String surfaceId,
    required String componentId,
    required String formTitle,
    required Map<String, Object?> answers,
    required List<String> summary,
    required DateTime createdAt,
  }) = AnswersEntry;

  const factory JobEntry.model({
    required String rawResponse,
    required String text,
    required List<String> surfaceIds,
    required List<Map<String, Object?>> messages,
    required DateTime createdAt,
    @Default(<ChecklistRef>[]) List<ChecklistRef> checklists,
    @Default(<String>[]) List<String> categories,
  }) = ModelEntry;

  factory JobEntry.fromJson(Map<String, Object?> json) =>
      _$JobEntryFromJson(json);
}
