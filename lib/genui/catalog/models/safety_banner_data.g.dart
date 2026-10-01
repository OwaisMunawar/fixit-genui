// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safety_banner_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SafetyBannerData _$SafetyBannerDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_SafetyBannerData', json, ($checkedConvert) {
      final val = _SafetyBannerData(
        severity: $checkedConvert(
          'severity',
          (v) => $enumDecode(_$SafetySeverityEnumMap, v),
        ),
        title: $checkedConvert('title', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
        origin: $checkedConvert(
          'origin',
          (v) =>
              $enumDecodeNullable(_$ContentOriginEnumMap, v) ??
              ContentOrigin.model,
        ),
      );
      return val;
    });

Map<String, dynamic> _$SafetyBannerDataToJson(_SafetyBannerData instance) =>
    <String, dynamic>{
      'severity': _$SafetySeverityEnumMap[instance.severity]!,
      'title': instance.title,
      'message': instance.message,
      'origin': _$ContentOriginEnumMap[instance.origin]!,
    };

const _$SafetySeverityEnumMap = {
  SafetySeverity.caution: 'caution',
  SafetySeverity.warning: 'warning',
  SafetySeverity.danger: 'danger',
};

const _$ContentOriginEnumMap = {
  ContentOrigin.model: 'model',
  ContentOrigin.guardrail: 'guardrail',
  ContentOrigin.validator: 'validator',
};
