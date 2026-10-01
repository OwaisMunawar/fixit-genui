// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiagnosisData _$DiagnosisDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_DiagnosisData', json, ($checkedConvert) {
      final val = _DiagnosisData(
        title: $checkedConvert('title', (v) => v as String),
        likelyCause: $checkedConvert('likelyCause', (v) => v as String),
        confidence: $checkedConvert('confidence', (v) => (v as num).toDouble()),
        difficulty: $checkedConvert(
          'difficulty',
          (v) => $enumDecode(_$DifficultyEnumMap, v),
        ),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$RepairCategoryEnumMap, v),
        ),
        summary: $checkedConvert('summary', (v) => v as String?),
        estimatedMinutes: $checkedConvert(
          'estimatedMinutes',
          (v) => (v as num?)?.toInt(),
        ),
        alternatives: $checkedConvert(
          'alternatives',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
        ),
      );
      return val;
    });

Map<String, dynamic> _$DiagnosisDataToJson(_DiagnosisData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'likelyCause': instance.likelyCause,
      'confidence': instance.confidence,
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'category': _$RepairCategoryEnumMap[instance.category]!,
      'summary': instance.summary,
      'estimatedMinutes': instance.estimatedMinutes,
      'alternatives': instance.alternatives,
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.moderate: 'moderate',
  Difficulty.hard: 'hard',
  Difficulty.pro: 'pro',
};

const _$RepairCategoryEnumMap = {
  RepairCategory.plumbing: 'plumbing',
  RepairCategory.electrical: 'electrical',
  RepairCategory.gas: 'gas',
  RepairCategory.structural: 'structural',
  RepairCategory.flooring: 'flooring',
  RepairCategory.carpentry: 'carpentry',
  RepairCategory.appliance: 'appliance',
  RepairCategory.hvac: 'hvac',
  RepairCategory.roofing: 'roofing',
  RepairCategory.general: 'general',
};
