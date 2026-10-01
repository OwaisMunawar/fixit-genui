import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/genui/catalog/fixit_catalog.dart';
import 'package:fixit/genui/generator/gemini/gemini_repair_generator.dart';
import 'package:fixit/genui/generator/gemini/gemini_request_mapper.dart';
import 'package:fixit/genui/generator/repair_request.dart';
import 'package:fixit/genui/generator/system_prompt.dart';
import 'package:flutter_test/flutter_test.dart';

/// Answers every request with a canned status and body, recording what was
/// sent. Avoids a mocking library for something this small.
final class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.status, this.body, {this.throwType});

  final int status;
  final Object body;
  final DioExceptionType? throwType;
  RequestOptions? lastRequest;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    if (throwType != null) {
      throw DioException(requestOptions: options, type: throwType!);
    }
    return ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

const _request = RepairRequest(
  history: [
    RepairTurn(role: RepairRole.user, text: 'Faucet drips'),
    RepairTurn(role: RepairRole.model, text: '```json{}```'),
  ],
  input: TextInput(text: 'It is a single lever'),
);

(GeminiRepairGenerator, _FakeAdapter) _generator(
  int status,
  Object body, {
  DioExceptionType? throwType,
}) {
  final adapter = _FakeAdapter(status, body, throwType: throwType);
  final dio = GeminiRepairGenerator.createDio()..httpClientAdapter = adapter;
  return (
    GeminiRepairGenerator(
      dio: dio,
      apiKey: 'test-key',
      model: 'gemini-test',
      systemPrompt: 'SYSTEM',
    ),
    adapter,
  );
}

Map<String, Object?> _answer(String text, {String finish = 'STOP'}) => {
  'candidates': [
    {
      'content': {
        'parts': [
          {'text': 'thinking...', 'thought': true},
          {'text': text},
        ],
      },
      'finishReason': finish,
    },
  ],
};

void main() {
  group('GeminiRequestMapper', () {
    test('maps history and the new turn, photo first', () {
      final body = GeminiRequestMapper.toBody(
        RepairRequest(
          history: _request.history,
          input: TextInput(
            text: '',
            image: ImageAttachment(bytes: Uint8List.fromList([1, 2, 3])),
          ),
        ),
        systemPrompt: 'SYSTEM',
      );

      final contents = body['contents']! as List;
      expect(contents.map((c) => (c as Map)['role']), [
        'user',
        'model',
        'user',
      ]);
      final parts = (contents.last as Map)['parts'] as List;
      expect((parts.first as Map)['inlineData'], {
        'mimeType': 'image/jpeg',
        'data': base64Encode([1, 2, 3]),
      });
      expect((parts.last as Map)['text'], '(photo only)');
    });

    test('skips thought parts and reads block reasons', () {
      expect(GeminiRequestMapper.textFrom(_answer('Answer')), 'Answer');
      expect(GeminiRequestMapper.textFrom(const {}), isNull);
      expect(
        GeminiRequestMapper.blockReason(const {
          'promptFeedback': {'blockReason': 'SAFETY'},
        }),
        'SAFETY',
      );
      expect(
        GeminiRequestMapper.blockReason(_answer('x', finish: 'SAFETY')),
        'SAFETY',
      );
      expect(GeminiRequestMapper.blockReason(_answer('x')), isNull);
    });
  });

  group('GeminiRepairGenerator', () {
    test('posts to generateContent with the key in a header', () async {
      final (generator, adapter) = _generator(200, _answer('Hello'));

      expect(await generator.generate(_request), 'Hello');
      final sent = adapter.lastRequest!;
      expect(sent.path, 'models/gemini-test:generateContent');
      expect(sent.headers['x-goog-api-key'], 'test-key');
      expect(sent.uri.queryParameters, isEmpty);
    });

    test('maps blocked and empty responses', () async {
      final (blocked, _) = _generator(200, {
        'promptFeedback': {'blockReason': 'SAFETY'},
      });
      await expectLater(
        blocked.generate(_request),
        throwsA(isA<BlockedResponseFailure>()),
      );

      final (empty, _) = _generator(200, {'candidates': <Object>[]});
      await expectLater(
        empty.generate(_request),
        throwsA(isA<BlockedResponseFailure>()),
      );
    });

    for (final (status, body, failure) in [
      (401, <String, Object?>{}, isA<InvalidApiKeyFailure>()),
      (
        400,
        <String, Object?>{
          'error': {'status': 'API_KEY_INVALID'},
        },
        isA<InvalidApiKeyFailure>(),
      ),
      (429, <String, Object?>{}, isA<RateLimitedFailure>()),
      (503, <String, Object?>{}, isA<ServiceFailure>()),
    ]) {
      test('maps HTTP $status', () async {
        final (generator, _) = _generator(status, body);
        await expectLater(generator.generate(_request), throwsA(failure));
      });
    }

    for (final (type, failure) in [
      (DioExceptionType.connectionError, isA<OfflineFailure>()),
      (DioExceptionType.receiveTimeout, isA<ServiceFailure>()),
      (DioExceptionType.cancel, isA<UnexpectedFailure>()),
    ]) {
      test('maps ${type.name}', () async {
        final (generator, _) = _generator(0, const {}, throwType: type);
        await expectLater(generator.generate(_request), throwsA(failure));
      });
    }
  });

  test('the system prompt carries the catalog and safety rules', () {
    final prompt = FixitSystemPrompt.build(FixitCatalog.catalog);

    expect(prompt, contains(FixitCatalog.id));
    expect(prompt, contains('SAFETY RULES'));
    for (final item in FixitCatalog.items) {
      expect(prompt, contains(item.name));
    }
  });
}
