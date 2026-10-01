import 'dart:convert';

import 'package:fixit/genui/generator/repair_request.dart';

/// Maps a repair request onto the Gemini `generateContent` REST body.
///
/// Kept separate from the HTTP client so the wire format is unit-testable
/// without a network.
abstract final class GeminiRequestMapper {
  static Map<String, Object?> toBody(
    RepairRequest request, {
    required String systemPrompt,
    double temperature = 0.3,
  }) => {
    'systemInstruction': {
      'parts': [
        {'text': systemPrompt},
      ],
    },
    'contents': [
      for (final turn in request.history) _content(turn),
      _content(RepairTurn.fromInput(request.input)),
    ],
    'generationConfig': {
      'temperature': temperature,
      'maxOutputTokens': 8192,
    },
  };

  static Map<String, Object?> _content(RepairTurn turn) => {
    'role': turn.role == RepairRole.user ? 'user' : 'model',
    'parts': [
      if (turn.image case final image?)
        {
          'inlineData': {
            'mimeType': image.mimeType,
            'data': base64Encode(image.bytes),
          },
        },
      {'text': turn.text.isEmpty ? '(photo only)' : turn.text},
    ],
  };

  /// Concatenates the answer text, skipping "thought" parts that thinking
  /// models return alongside it.
  static String? textFrom(Map<String, Object?> response) {
    final candidates = response['candidates'];
    if (candidates is! List || candidates.isEmpty) return null;
    final first = candidates.first;
    if (first is! Map) return null;
    final content = first['content'];
    if (content is! Map) return null;
    final parts = content['parts'];
    if (parts is! List) return null;
    final text = parts
        .whereType<Map<Object?, Object?>>()
        .where((part) => part['thought'] != true)
        .map((part) => part['text'])
        .whereType<String>()
        .join();
    return text.isEmpty ? null : text;
  }

  static String? blockReason(Map<String, Object?> response) {
    final feedback = response['promptFeedback'];
    if (feedback is Map && feedback['blockReason'] is String) {
      return feedback['blockReason'] as String;
    }
    final candidates = response['candidates'];
    if (candidates is List && candidates.isNotEmpty) {
      final reason = (candidates.first as Map?)?['finishReason'];
      if (reason case 'SAFETY' || 'PROHIBITED_CONTENT' || 'BLOCKLIST') {
        return reason as String;
      }
    }
    return null;
  }
}
