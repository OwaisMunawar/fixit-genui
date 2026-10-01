import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnosis_data.freezed.dart';
part 'diagnosis_data.g.dart';

@freezed
abstract class DiagnosisData with _$DiagnosisData {
  const factory DiagnosisData({
    required String title,
    required String likelyCause,
    required double confidence,
    required Difficulty difficulty,
    required RepairCategory category,
    String? summary,
    int? estimatedMinutes,
    @Default(<String>[]) List<String> alternatives,
  }) = _DiagnosisData;

  factory DiagnosisData.fromJson(Map<String, Object?> json) =>
      _$DiagnosisDataFromJson(json);
}
