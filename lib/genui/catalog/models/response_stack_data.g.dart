// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_stack_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResponseStackData _$ResponseStackDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ResponseStackData', json, ($checkedConvert) {
      final val = _ResponseStackData(
        children: $checkedConvert(
          'children',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ResponseStackDataToJson(_ResponseStackData instance) =>
    <String, dynamic>{'children': instance.children};
