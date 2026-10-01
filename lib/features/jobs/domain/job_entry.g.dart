// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntry _$UserEntryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserEntry', json, ($checkedConvert) {
      final val = UserEntry(
        text: $checkedConvert('text', (v) => v as String),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        imagePath: $checkedConvert('imagePath', (v) => v as String?),
        $type: $checkedConvert('kind', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'kind'});

Map<String, dynamic> _$UserEntryToJson(UserEntry instance) => <String, dynamic>{
  'text': instance.text,
  'createdAt': instance.createdAt.toIso8601String(),
  'imagePath': instance.imagePath,
  'kind': instance.$type,
};

AnswersEntry _$AnswersEntryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AnswersEntry', json, ($checkedConvert) {
      final val = AnswersEntry(
        surfaceId: $checkedConvert('surfaceId', (v) => v as String),
        componentId: $checkedConvert('componentId', (v) => v as String),
        formTitle: $checkedConvert('formTitle', (v) => v as String),
        answers: $checkedConvert('answers', (v) => v as Map<String, dynamic>),
        summary: $checkedConvert(
          'summary',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        $type: $checkedConvert('kind', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'kind'});

Map<String, dynamic> _$AnswersEntryToJson(AnswersEntry instance) =>
    <String, dynamic>{
      'surfaceId': instance.surfaceId,
      'componentId': instance.componentId,
      'formTitle': instance.formTitle,
      'answers': instance.answers,
      'summary': instance.summary,
      'createdAt': instance.createdAt.toIso8601String(),
      'kind': instance.$type,
    };

ModelEntry _$ModelEntryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ModelEntry', json, ($checkedConvert) {
  final val = ModelEntry(
    rawResponse: $checkedConvert('rawResponse', (v) => v as String),
    text: $checkedConvert('text', (v) => v as String),
    surfaceIds: $checkedConvert(
      'surfaceIds',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    messages: $checkedConvert(
      'messages',
      (v) =>
          (v as List<dynamic>).map((e) => e as Map<String, dynamic>).toList(),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    checklists: $checkedConvert(
      'checklists',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => ChecklistRef.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ChecklistRef>[],
    ),
    categories: $checkedConvert(
      'categories',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    ),
    $type: $checkedConvert('kind', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'kind'});

Map<String, dynamic> _$ModelEntryToJson(ModelEntry instance) =>
    <String, dynamic>{
      'rawResponse': instance.rawResponse,
      'text': instance.text,
      'surfaceIds': instance.surfaceIds,
      'messages': instance.messages,
      'createdAt': instance.createdAt.toIso8601String(),
      'checklists': instance.checklists.map((e) => e.toJson()).toList(),
      'categories': instance.categories,
      'kind': instance.$type,
    };
