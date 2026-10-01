import 'package:fixit/core/theme/app_theme.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';

/// Wraps [child] in the app's theme, localisations and a [ProviderScope].
Widget testApp(
  Widget child, {
  Brightness brightness = Brightness.light,
  List<Override> overrides = const [],
  bool scroll = true,
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.dark ? AppTheme.dark() : AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: scroll
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: child,
              )
            : child,
      ),
    ),
  );
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget child, {
    Brightness brightness = Brightness.light,
    List<Override> overrides = const [],
    bool scroll = true,
  }) async {
    await pumpWidget(
      testApp(
        child,
        brightness: brightness,
        overrides: overrides,
        scroll: scroll,
      ),
    );
    await pump();
  }
}
