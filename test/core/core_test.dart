import 'package:fixit/core/config/app_config.dart';
import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/core/errors/failure_messages.dart';
import 'package:fixit/core/format/formatters.dart';
import 'package:fixit/l10n/gen/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppConfig', () {
    test('an empty or blank key means demo mode', () {
      for (final key in ['', '   ']) {
        expect(
          AppConfig(geminiApiKey: key, geminiModel: 'm', forceDemo: false).mode,
          GeneratorMode.demo,
        );
      }
    });

    test('a key selects Gemini unless demo is forced', () {
      const live = AppConfig(
        geminiApiKey: 'k',
        geminiModel: 'm',
        forceDemo: false,
      );
      const forced = AppConfig(
        geminiApiKey: 'k',
        geminiModel: 'm',
        forceDemo: true,
      );
      expect(live.mode, GeneratorMode.gemini);
      expect(forced.mode, GeneratorMode.demo);
    });

    test('defaults to demo mode in tests', () {
      expect(AppConfig.fromEnvironment().mode, GeneratorMode.demo);
    });
  });

  group('formatMoney', () {
    test('drops cents on whole amounts', () {
      expect(formatMoney(24, locale: 'en_US'), r'$24');
      expect(formatMoney(4.5, locale: 'en_US'), r'$4.50');
    });

    test('uses the quoted currency', () {
      expect(formatMoney(10, currency: 'eur', locale: 'en_US'), '€10');
    });

    test('formats ranges and collapses equal ends', () {
      expect(formatMoneyRange(150, 400, locale: 'en_US'), r'$150 to $400');
      expect(formatMoneyRange(90, 90, locale: 'en_US'), r'$90');
    });
  });

  test('every failure has a message and a retry policy', () {
    final l10n = AppLocalizationsEn();
    final failures = <AppFailure>[
      const OfflineFailure(),
      const InvalidApiKeyFailure(),
      const RateLimitedFailure(),
      const BlockedResponseFailure('SAFETY'),
      const ServiceFailure(statusCode: 500, body: 'oops'),
      const PermissionFailure('camera_access_denied'),
      const StorageFailure('disk full'),
      const UnexpectedFailure('boom'),
    ];
    for (final failure in failures) {
      expect(failure.localizedMessage(l10n), isNotEmpty);
      expect(failure.toString(), contains(failure.debugMessage));
    }
    expect(const InvalidApiKeyFailure().isRetryable, isFalse);
    expect(const PermissionFailure('x').isRetryable, isFalse);
    expect(const OfflineFailure().isRetryable, isTrue);
  });
}
