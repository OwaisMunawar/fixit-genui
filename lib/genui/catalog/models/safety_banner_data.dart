import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'safety_banner_data.freezed.dart';
part 'safety_banner_data.g.dart';

@freezed
abstract class SafetyBannerData with _$SafetyBannerData {
  const factory SafetyBannerData({
    required SafetySeverity severity,
    required String title,
    required String message,
    @Default(ContentOrigin.model) ContentOrigin origin,
  }) = _SafetyBannerData;

  factory SafetyBannerData.fromJson(Map<String, Object?> json) =>
      _$SafetyBannerDataFromJson(json);
}
