// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoteCardData _$NoteCardDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_NoteCardData', json, ($checkedConvert) {
      final val = _NoteCardData(
        body: $checkedConvert('body', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String?),
        tone: $checkedConvert(
          'tone',
          (v) => $enumDecodeNullable(_$NoteToneEnumMap, v) ?? NoteTone.info,
        ),
        origin: $checkedConvert(
          'origin',
          (v) =>
              $enumDecodeNullable(_$ContentOriginEnumMap, v) ??
              ContentOrigin.model,
        ),
      );
      return val;
    });

Map<String, dynamic> _$NoteCardDataToJson(_NoteCardData instance) =>
    <String, dynamic>{
      'body': instance.body,
      'title': instance.title,
      'tone': _$NoteToneEnumMap[instance.tone]!,
      'origin': _$ContentOriginEnumMap[instance.origin]!,
    };

const _$NoteToneEnumMap = {NoteTone.info: 'info', NoteTone.warning: 'warning'};

const _$ContentOriginEnumMap = {
  ContentOrigin.model: 'model',
  ContentOrigin.guardrail: 'guardrail',
  ContentOrigin.validator: 'validator',
};
