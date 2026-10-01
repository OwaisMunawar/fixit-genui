import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/genui/generator/gemini/gemini_request_mapper.dart';
import 'package:fixit/genui/generator/repair_generator.dart';
import 'package:fixit/genui/generator/repair_request.dart';

/// Calls the Gemini API directly over REST with an API key.
///
/// No Firebase project needed, which keeps setup to one `--dart-define`. The
/// trade-off is that the key ships inside the app binary; see
/// docs/ARCHITECTURE.md (ADR 2) for when to move to `firebase_ai` instead.
final class GeminiRepairGenerator implements RepairGenerator {
  GeminiRepairGenerator({
    required this._dio,
    required this._apiKey,
    required this._model,
    required this._systemPrompt,
  });

  static const baseUrl = 'https://generativelanguage.googleapis.com/v1beta/';

  static Dio createDio() => Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 90),
      contentType: Headers.jsonContentType,
    ),
  );

  final Dio _dio;
  final String _apiKey;
  final String _model;
  final String _systemPrompt;

  @override
  Future<String> generate(RepairRequest request) async {
    final Response<Map<String, Object?>> response;
    try {
      response = await _dio.post<Map<String, Object?>>(
        'models/$_model:generateContent',
        data: GeminiRequestMapper.toBody(request, systemPrompt: _systemPrompt),
        // A header rather than the `key` query parameter, so the key never
        // appears in URLs, proxies or request logs.
        options: Options(headers: {'x-goog-api-key': _apiKey}),
      );
    } on DioException catch (error) {
      throw mapDioException(error);
    }

    final body = response.data ?? const {};
    final blocked = GeminiRequestMapper.blockReason(body);
    if (blocked != null) throw BlockedResponseFailure(blocked);
    final text = GeminiRequestMapper.textFrom(body);
    if (text == null) {
      throw const BlockedResponseFailure('Empty response from Gemini');
    }
    return text;
  }

  static AppFailure mapDioException(DioException error) {
    final status = error.response?.statusCode;
    return switch (error.type) {
      DioExceptionType.connectionError ||
      DioExceptionType.connectionTimeout => const OfflineFailure(),
      DioExceptionType.unknown when error.error is SocketException =>
        const OfflineFailure(),
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => const ServiceFailure(
        statusCode: null,
        body: 'timeout',
      ),
      DioExceptionType.badResponse => switch (status) {
        400 when '${error.response?.data}'.contains('API_KEY_INVALID') =>
          const InvalidApiKeyFailure(),
        401 || 403 => const InvalidApiKeyFailure(),
        429 => const RateLimitedFailure(),
        _ => ServiceFailure(
          statusCode: status,
          body: '${error.response?.data}',
        ),
      },
      _ => UnexpectedFailure(error),
    };
  }
}
