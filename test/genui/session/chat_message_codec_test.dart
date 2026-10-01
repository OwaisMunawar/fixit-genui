import 'dart:convert';
import 'dart:typed_data';

import 'package:fixit/genui/generator/repair_request.dart';
import 'package:fixit/genui/session/chat_message_codec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genui/genui.dart';

void main() {
  test('round-trips text with a photo', () {
    final input = TextInput(
      text: 'Leak',
      image: ImageAttachment(bytes: Uint8List.fromList([1, 2]), path: 'a.jpg'),
    );

    final decoded =
        ChatMessageCodec.decode(ChatMessageCodec.encode(input))! as TextInput;

    expect(decoded.text, 'Leak');
    expect(decoded.image!.bytes, [1, 2]);
    expect(decoded.image!.path, 'a.jpg');
  });

  test('round-trips submitted answers', () {
    const input = AnswersInput(
      surfaceId: 't0-0',
      componentId: 'questions',
      formTitle: 'Quick questions',
      answers: {'handles': 'single'},
      summary: ['Handles? One lever'],
    );

    final decoded =
        ChatMessageCodec.decode(ChatMessageCodec.encode(input))!
            as AnswersInput;

    expect(decoded.surfaceId, 't0-0');
    expect(decoded.answers, {'handles': 'single'});
    expect(decoded.promptText, contains('- Handles? One lever'));
  });

  test("ignores genui's validation error reports", () {
    final message = ChatMessage.user(
      '',
      parts: [
        UiInteractionPart.create(
          jsonEncode({
            'version': 'v0.9',
            'error': {'code': 'VALIDATION_FAILED'},
          }),
        ),
      ],
    );

    expect(ChatMessageCodec.decode(message), isNull);
  });

  test('ignores unknown actions and empty messages', () {
    final unknown = ChatMessage.user(
      '',
      parts: [
        UiInteractionPart.create(
          jsonEncode({
            'version': 'v0.9',
            'action': {'name': 'somethingElse'},
          }),
        ),
      ],
    );

    expect(ChatMessageCodec.decode(unknown), isNull);
    expect(ChatMessageCodec.decode(ChatMessage.user('  ')), isNull);
  });
}
