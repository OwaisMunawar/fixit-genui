import 'package:a2ui_core/a2ui_core.dart' as core;
import 'package:fixit/genui/pipeline/pipeline_issue.dart';
import 'package:fixit/genui/pipeline/response_parser.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/responses.dart';

void main() {
  group('ResponseParser', () {
    test('separates prose from fenced A2UI messages', () async {
      final parsed = await ResponseParser.parse(
        rawResponse([diagnosis], text: 'Here is what I think.'),
      );

      expect(parsed.text, 'Here is what I think.');
      expect(parsed.messages, hasLength(2));
      expect(parsed.messages.first, isA<core.CreateSurfaceMessage>());
      expect(parsed.messages.last, isA<core.UpdateComponentsMessage>());
      expect(parsed.issues, isEmpty);
    });

    test('records a malformed A2UI message instead of throwing', () async {
      const raw = '```json\n{"version": "v0.8", "createSurface": {}}\n```';

      final parsed = await ResponseParser.parse(raw);

      expect(parsed.messages, isEmpty);
      expect(parsed.issues.single.kind, IssueKind.malformedMessage);
    });

    test('keeps non-A2UI JSON off the screen', () async {
      const raw = 'Sure.\n```json\n[{"id": "root", "component": "X"}]\n```';

      final parsed = await ResponseParser.parse(raw);

      expect(parsed.text, 'Sure.');
      expect(parsed.issues.single.kind, IssueKind.unrecognisedJson);
    });

    test('returns plain text when there is no JSON at all', () async {
      final parsed = await ResponseParser.parse('Just turn it off.');

      expect(parsed.messages, isEmpty);
      expect(parsed.text, 'Just turn it off.');
    });
  });
}
