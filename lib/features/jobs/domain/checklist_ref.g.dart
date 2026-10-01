// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_ref.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChecklistRef _$ChecklistRefFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ChecklistRef', json, ($checkedConvert) {
      final val = _ChecklistRef(
        surfaceId: $checkedConvert('surfaceId', (v) => v as String),
        componentId: $checkedConvert('componentId', (v) => v as String),
        stepIds: $checkedConvert(
          'stepIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ChecklistRefToJson(_ChecklistRef instance) =>
    <String, dynamic>{
      'surfaceId': instance.surfaceId,
      'componentId': instance.componentId,
      'stepIds': instance.stepIds,
    };
