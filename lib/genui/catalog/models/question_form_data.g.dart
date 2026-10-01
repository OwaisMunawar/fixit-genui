// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionFormData _$QuestionFormDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_QuestionFormData', json, ($checkedConvert) {
      final val = _QuestionFormData(
        title: $checkedConvert('title', (v) => v as String),
        questions: $checkedConvert(
          'questions',
          (v) => (v as List<dynamic>)
              .map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        intro: $checkedConvert('intro', (v) => v as String?),
        submitLabel: $checkedConvert('submitLabel', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$QuestionFormDataToJson(_QuestionFormData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
      'intro': instance.intro,
      'submitLabel': instance.submitLabel,
    };

_Question _$QuestionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_Question', json, ($checkedConvert) {
  final val = _Question(
    id: $checkedConvert('id', (v) => v as String),
    label: $checkedConvert('label', (v) => v as String),
    type: $checkedConvert('type', (v) => $enumDecode(_$QuestionTypeEnumMap, v)),
    options: $checkedConvert(
      'options',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => QuestionOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <QuestionOption>[],
    ),
    min: $checkedConvert('min', (v) => (v as num?)?.toDouble()),
    max: $checkedConvert('max', (v) => (v as num?)?.toDouble()),
    step: $checkedConvert('step', (v) => (v as num?)?.toDouble()),
    unit: $checkedConvert('unit', (v) => v as String?),
    helper: $checkedConvert('helper', (v) => v as String?),
    required: $checkedConvert('required', (v) => v as bool? ?? true),
  );
  return val;
});

Map<String, dynamic> _$QuestionToJson(_Question instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'type': _$QuestionTypeEnumMap[instance.type]!,
  'options': instance.options.map((e) => e.toJson()).toList(),
  'min': instance.min,
  'max': instance.max,
  'step': instance.step,
  'unit': instance.unit,
  'helper': instance.helper,
  'required': instance.required,
};

const _$QuestionTypeEnumMap = {
  QuestionType.singleChoice: 'singleChoice',
  QuestionType.multiChoice: 'multiChoice',
  QuestionType.slider: 'slider',
  QuestionType.yesNo: 'yesNo',
};

_QuestionOption _$QuestionOptionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_QuestionOption', json, ($checkedConvert) {
      final val = _QuestionOption(
        value: $checkedConvert('value', (v) => v as String),
        label: $checkedConvert('label', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$QuestionOptionToJson(_QuestionOption instance) =>
    <String, dynamic>{'value': instance.value, 'label': instance.label};
