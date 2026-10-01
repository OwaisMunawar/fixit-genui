// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pro_callout_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProCalloutData _$ProCalloutDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ProCalloutData', json, ($checkedConvert) {
      final val = _ProCalloutData(
        title: $checkedConvert('title', (v) => v as String),
        reasons: $checkedConvert(
          'reasons',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        costLow: $checkedConvert('costLow', (v) => (v as num).toDouble()),
        costHigh: $checkedConvert('costHigh', (v) => (v as num).toDouble()),
        trade: $checkedConvert('trade', (v) => v as String?),
        currency: $checkedConvert('currency', (v) => v as String? ?? 'USD'),
        origin: $checkedConvert(
          'origin',
          (v) =>
              $enumDecodeNullable(_$ContentOriginEnumMap, v) ??
              ContentOrigin.model,
        ),
      );
      return val;
    });

Map<String, dynamic> _$ProCalloutDataToJson(_ProCalloutData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'reasons': instance.reasons,
      'costLow': instance.costLow,
      'costHigh': instance.costHigh,
      'trade': instance.trade,
      'currency': instance.currency,
      'origin': _$ContentOriginEnumMap[instance.origin]!,
    };

const _$ContentOriginEnumMap = {
  ContentOrigin.model: 'model',
  ContentOrigin.guardrail: 'guardrail',
  ContentOrigin.validator: 'validator',
};
