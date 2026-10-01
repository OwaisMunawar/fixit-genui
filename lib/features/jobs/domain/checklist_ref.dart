import 'package:freezed_annotation/freezed_annotation.dart';

part 'checklist_ref.freezed.dart';
part 'checklist_ref.g.dart';

typedef ChecklistKey = ({String surfaceId, String componentId});

/// Points at a generated checklist and lists its step ids, which is all the
/// domain needs to compute progress without knowing about generated UI.
@freezed
abstract class ChecklistRef with _$ChecklistRef {
  const factory ChecklistRef({
    required String surfaceId,
    required String componentId,
    required List<String> stepIds,
  }) = _ChecklistRef;

  const ChecklistRef._();

  factory ChecklistRef.fromJson(Map<String, Object?> json) =>
      _$ChecklistRefFromJson(json);

  ChecklistKey get key => (surfaceId: surfaceId, componentId: componentId);
}
