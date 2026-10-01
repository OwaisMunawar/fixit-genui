import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads real Roboto and Material Icons from the Flutter SDK so goldens show
/// readable text instead of the test font's boxes.
///
/// Real glyph rendering differs slightly between macOS and Linux, which is
/// why CI runs the golden tag on macOS only.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final sdk = Platform.environment['FLUTTER_ROOT'];
  if (sdk != null) {
    final fonts = Directory('$sdk/bin/cache/artifacts/material_fonts');
    Future<void> load(String family, List<String> files) async {
      final loader = FontLoader(family);
      for (final file in files) {
        final font = File('${fonts.path}/$file');
        if (font.existsSync()) {
          loader.addFont(
            Future.value(ByteData.sublistView(font.readAsBytesSync())),
          );
        }
      }
      await loader.load();
    }

    await load('Roboto', [
      'Roboto-Regular.ttf',
      'Roboto-Medium.ttf',
      'Roboto-Bold.ttf',
    ]);
    await load('MaterialIcons', ['MaterialIcons-Regular.otf']);
  }
  await testMain();
}
