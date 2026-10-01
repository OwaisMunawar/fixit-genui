import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_stack_data.freezed.dart';
part 'response_stack_data.g.dart';

@freezed
abstract class ResponseStackData with _$ResponseStackData {
  const factory ResponseStackData({required List<String> children}) =
      _ResponseStackData;

  factory ResponseStackData.fromJson(Map<String, Object?> json) =>
      _$ResponseStackDataFromJson(json);
}
