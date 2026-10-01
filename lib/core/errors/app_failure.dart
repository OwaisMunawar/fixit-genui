/// Every failure the UI knows how to explain.
///
/// Infrastructure code converts exceptions into one of these at the boundary,
/// so presentation code can switch exhaustively instead of guessing at
/// exception types from three different packages.
sealed class AppFailure implements Exception {
  const AppFailure();

  /// Developer-facing detail. Never shown to the user.
  String get debugMessage;

  /// Whether retrying the same request has a reasonable chance of working.
  bool get isRetryable => true;

  @override
  String toString() => 'AppFailure: $debugMessage';
}

final class OfflineFailure extends AppFailure {
  const OfflineFailure([this.debugMessage = 'No network connection']);

  @override
  final String debugMessage;
}

final class InvalidApiKeyFailure extends AppFailure {
  const InvalidApiKeyFailure([this.debugMessage = 'API key rejected']);

  @override
  final String debugMessage;

  @override
  bool get isRetryable => false;
}

final class RateLimitedFailure extends AppFailure {
  const RateLimitedFailure([this.debugMessage = 'HTTP 429']);

  @override
  final String debugMessage;
}

/// The model returned nothing usable, usually because a safety filter fired.
final class BlockedResponseFailure extends AppFailure {
  const BlockedResponseFailure(this.debugMessage);

  @override
  final String debugMessage;
}

final class ServiceFailure extends AppFailure {
  const ServiceFailure({required this.statusCode, this.body});

  final int? statusCode;
  final String? body;

  @override
  String get debugMessage => 'HTTP $statusCode ${body ?? ''}'.trim();
}

final class PermissionFailure extends AppFailure {
  const PermissionFailure(this.debugMessage);

  @override
  final String debugMessage;

  @override
  bool get isRetryable => false;
}

final class StorageFailure extends AppFailure {
  const StorageFailure(this.cause);

  final Object cause;

  @override
  String get debugMessage => cause.toString();
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure(this.cause);

  final Object cause;

  @override
  String get debugMessage => cause.toString();
}
