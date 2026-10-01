import 'package:freezed_annotation/freezed_annotation.dart';

part 'parts_list_data.freezed.dart';
part 'parts_list_data.g.dart';

@freezed
abstract class PartsListData with _$PartsListData {
  const factory PartsListData({
    required List<PartItem> items,
    String? title,
    @Default(<String>[]) List<String> tools,
    @Default('USD') String currency,
  }) = _PartsListData;

  const PartsListData._();

  factory PartsListData.fromJson(Map<String, Object?> json) =>
      _$PartsListDataFromJson(json);

  /// Computed client-side rather than trusted from the model, which is bad at
  /// arithmetic and would otherwise show a total that doesn't add up.
  double get estimatedTotal =>
      items.fold(0, (sum, item) => sum + (item.lineTotal ?? 0));

  bool get hasPricing => items.any((item) => item.unitCost != null);
}

@freezed
abstract class PartItem with _$PartItem {
  const factory PartItem({
    required String name,
    @Default(1) int quantity,
    double? unitCost,
    String? note,
  }) = _PartItem;

  const PartItem._();

  factory PartItem.fromJson(Map<String, Object?> json) =>
      _$PartItemFromJson(json);

  double? get lineTotal => unitCost == null ? null : unitCost! * quantity;
}
