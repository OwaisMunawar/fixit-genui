import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_card_data.freezed.dart';
part 'note_card_data.g.dart';

@freezed
abstract class NoteCardData with _$NoteCardData {
  const factory NoteCardData({
    required String body,
    String? title,
    @Default(NoteTone.info) NoteTone tone,
    @Default(ContentOrigin.model) ContentOrigin origin,
  }) = _NoteCardData;

  factory NoteCardData.fromJson(Map<String, Object?> json) =>
      _$NoteCardDataFromJson(json);
}
