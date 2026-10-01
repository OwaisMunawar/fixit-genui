// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_checklist_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StepChecklistData _$StepChecklistDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StepChecklistData', json, ($checkedConvert) {
      final val = _StepChecklistData(
        title: $checkedConvert('title', (v) => v as String),
        steps: $checkedConvert(
          'steps',
          (v) => (v as List<dynamic>)
              .map((e) => ChecklistStep.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        estimatedMinutes: $checkedConvert(
          'estimatedMinutes',
          (v) => (v as num?)?.toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StepChecklistDataToJson(_StepChecklistData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'steps': instance.steps.map((e) => e.toJson()).toList(),
      'estimatedMinutes': instance.estimatedMinutes,
    };

_ChecklistStep _$ChecklistStepFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ChecklistStep', json, ($checkedConvert) {
      final val = _ChecklistStep(
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        detail: $checkedConvert('detail', (v) => v as String?),
        minutes: $checkedConvert('minutes', (v) => (v as num?)?.toInt()),
        safety: $checkedConvert('safety', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ChecklistStepToJson(_ChecklistStep instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'detail': instance.detail,
      'minutes': instance.minutes,
      'safety': instance.safety,
    };
