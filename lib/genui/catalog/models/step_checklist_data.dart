import 'package:freezed_annotation/freezed_annotation.dart';

part 'step_checklist_data.freezed.dart';
part 'step_checklist_data.g.dart';

@freezed
abstract class StepChecklistData with _$StepChecklistData {
  const factory StepChecklistData({
    required String title,
    required List<ChecklistStep> steps,
    int? estimatedMinutes,
  }) = _StepChecklistData;

  const StepChecklistData._();

  factory StepChecklistData.fromJson(Map<String, Object?> json) =>
      _$StepChecklistDataFromJson(json);

  /// The model's own total wins; otherwise the per-step estimates are summed
  /// so the header never shows a blank.
  int? get totalMinutes {
    if (estimatedMinutes != null) return estimatedMinutes;
    final known = steps.map((s) => s.minutes).nonNulls.toList();
    if (known.isEmpty) return null;
    return known.fold<int>(0, (sum, m) => sum + m);
  }
}

@freezed
abstract class ChecklistStep with _$ChecklistStep {
  const factory ChecklistStep({
    required String id,
    required String title,
    String? detail,
    int? minutes,
    String? safety,
  }) = _ChecklistStep;

  factory ChecklistStep.fromJson(Map<String, Object?> json) =>
      _$ChecklistStepFromJson(json);
}
