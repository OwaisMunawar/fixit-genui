import 'dart:convert';

import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/generator/repair_request.dart';
import 'package:genui/genui.dart';

/// Translates between genui's [ChatMessage] and the app's typed inputs.
///
/// genui funnels user text and widget actions through the same
/// `sendRequest(ChatMessage)` call; this is where the two are told apart.
abstract final class ChatMessageCodec {
  static const _imagePathKey = 'fixit.imagePath';

  static ChatMessage encode(TurnInput input) => switch (input) {
    TextInput(:final text, :final image) => ChatMessage.user(
      text,
      parts: [
        if (image != null) DataPart(image.bytes, mimeType: image.mimeType),
      ],
      metadata: {_imagePathKey: ?image?.path},
    ),
    AnswersInput() => ChatMessage.user(
      '',
      parts: [
        UiInteractionPart.create(
          jsonEncode({
            'version': 'v0.9',
            'action': {
              'name': CatalogNames.submitAnswersAction,
              'surfaceId': input.surfaceId,
              'sourceComponentId': input.componentId,
              'context': {
                'formTitle': input.formTitle,
                'answers': input.answers,
                'summary': input.summary,
              },
            },
          }),
        ),
      ],
    ),
  };

  /// Returns null for messages that should not reach the model, such as
  /// genui's own validation error reports.
  static TurnInput? decode(ChatMessage message) {
    final interactions = message.parts.uiInteractionParts.toList();
    if (interactions.isNotEmpty) {
      return interactions.map(_decodeInteraction).nonNulls.firstOrNull;
    }

    final image = message.parts
        .whereType<DataPart>()
        .where((part) => part.mimeType.startsWith('image/'))
        .firstOrNull;
    final text = message.text.trim();
    if (text.isEmpty && image == null) return null;
    return TextInput(
      text: text,
      image: image == null
          ? null
          : ImageAttachment(
              bytes: image.bytes,
              mimeType: image.mimeType,
              path: message.metadata[_imagePathKey] as String?,
            ),
    );
  }

  static TurnInput? _decodeInteraction(UiInteractionPart part) {
    final Object? json;
    try {
      json = jsonDecode(part.interaction);
    } on FormatException {
      return null;
    }
    if (json is! Map<String, Object?>) return null;
    if (json['error'] != null) {
      genUiLogger.warning('genui reported a surface error: ${json['error']}');
      return null;
    }
    final action = json['action'];
    if (action is! Map<String, Object?> ||
        action['name'] != CatalogNames.submitAnswersAction) {
      return null;
    }
    final context = action['context'] as Map<String, Object?>? ?? const {};
    return AnswersInput(
      surfaceId: action['surfaceId'] as String? ?? '',
      componentId: action['sourceComponentId'] as String? ?? '',
      formTitle: context['formTitle'] as String? ?? '',
      answers: Map<String, Object?>.from(
        context['answers'] as Map? ?? const <String, Object?>{},
      ),
      summary:
          (context['summary'] as List?)?.whereType<String>().toList() ??
          const [],
    );
  }
}
