import 'package:fixit/core/config/app_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

/// Cross-cutting dependencies. Each is a provider rather than a global so
/// tests and the integration test can override it.
final appConfigProvider = Provider<AppConfig>(
  (ref) => AppConfig.fromEnvironment(),
);

final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

final uuidProvider = Provider<Uuid>((ref) => const Uuid());
