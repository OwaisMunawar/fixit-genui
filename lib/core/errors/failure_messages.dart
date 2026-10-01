import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';

extension AppFailureMessage on AppFailure {
  String localizedMessage(AppLocalizations l10n) => switch (this) {
    OfflineFailure() => l10n.failureOffline,
    InvalidApiKeyFailure() => l10n.failureInvalidKey,
    RateLimitedFailure() => l10n.failureRateLimited,
    BlockedResponseFailure() => l10n.failureBlocked,
    ServiceFailure() => l10n.failureService,
    PermissionFailure() => l10n.failurePermission,
    StorageFailure() => l10n.failureStorage,
    UnexpectedFailure() => l10n.failureUnknown,
  };
}
