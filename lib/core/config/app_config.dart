/// Which content generator drives the GenUI surface.
enum GeneratorMode { demo, gemini }

/// Build-time configuration, read from `--dart-define` values.
///
/// Nothing here is a secret that ships in source control: the Gemini key is
/// supplied per build and an empty key means demo mode.
final class AppConfig {
  const AppConfig({
    required this.geminiApiKey,
    required this.geminiModel,
    required this.forceDemo,
  });

  factory AppConfig.fromEnvironment() => const AppConfig(
    geminiApiKey: String.fromEnvironment('GEMINI_API_KEY'),
    geminiModel: String.fromEnvironment(
      'GEMINI_MODEL',
      defaultValue: 'gemini-2.5-flash',
    ),
    forceDemo: bool.fromEnvironment('FIXIT_DEMO'),
  );

  final String geminiApiKey;
  final String geminiModel;

  /// Lets a build that has a key still run the scripted demo, which is what
  /// screenshots and the integration test rely on.
  final bool forceDemo;

  GeneratorMode get mode => forceDemo || geminiApiKey.trim().isEmpty
      ? GeneratorMode.demo
      : GeneratorMode.gemini;
}
