import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_form_data.freezed.dart';
part 'question_form_data.g.dart';

@freezed
abstract class QuestionFormData with _$QuestionFormData {
  const factory QuestionFormData({
    required String title,
    required List<Question> questions,
    String? intro,
    String? submitLabel,
  }) = _QuestionFormData;

  factory QuestionFormData.fromJson(Map<String, Object?> json) =>
      _$QuestionFormDataFromJson(json);
}

@freezed
abstract class Question with _$Question {
  const factory Question({
    required String id,
    required String label,
    required QuestionType type,
    @Default(<QuestionOption>[]) List<QuestionOption> options,
    double? min,
    double? max,
    double? step,
    String? unit,
    String? helper,
    @Default(true) bool required,
  }) = _Question;

  factory Question.fromJson(Map<String, Object?> json) =>
      _$QuestionFromJson(json);
}

@freezed
abstract class QuestionOption with _$QuestionOption {
  const factory QuestionOption({required String value, required String label}) =
      _QuestionOption;

  factory QuestionOption.fromJson(Map<String, Object?> json) =>
      _$QuestionOptionFromJson(json);
}
