import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pro_callout_data.freezed.dart';
part 'pro_callout_data.g.dart';

@freezed
abstract class ProCalloutData with _$ProCalloutData {
  const factory ProCalloutData({
    required String title,
    required List<String> reasons,
    required double costLow,
    required double costHigh,
    String? trade,
    @Default('USD') String currency,
    @Default(ContentOrigin.model) ContentOrigin origin,
  }) = _ProCalloutData;

  factory ProCalloutData.fromJson(Map<String, Object?> json) =>
      _$ProCalloutDataFromJson(json);
}
