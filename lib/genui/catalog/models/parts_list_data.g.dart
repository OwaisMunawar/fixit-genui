// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parts_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartsListData _$PartsListDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PartsListData', json, ($checkedConvert) {
      final val = _PartsListData(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => PartItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        title: $checkedConvert('title', (v) => v as String?),
        tools: $checkedConvert(
          'tools',
          (v) =>
              (v as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
        ),
        currency: $checkedConvert('currency', (v) => v as String? ?? 'USD'),
      );
      return val;
    });

Map<String, dynamic> _$PartsListDataToJson(_PartsListData instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'title': instance.title,
      'tools': instance.tools,
      'currency': instance.currency,
    };

_PartItem _$PartItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PartItem', json, ($checkedConvert) {
      final val = _PartItem(
        name: $checkedConvert('name', (v) => v as String),
        quantity: $checkedConvert('quantity', (v) => (v as num?)?.toInt() ?? 1),
        unitCost: $checkedConvert('unitCost', (v) => (v as num?)?.toDouble()),
        note: $checkedConvert('note', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$PartItemToJson(_PartItem instance) => <String, dynamic>{
  'name': instance.name,
  'quantity': instance.quantity,
  'unitCost': instance.unitCost,
  'note': instance.note,
};
