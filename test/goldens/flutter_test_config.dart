import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads real Roboto and Material Icons from the Flutter SDK so goldens show
/// readable text instead of the test font's boxes.
///
/// Real glyph rendering differs slightly between machines (and a lot between
/// macOS and Linux, which is why CI runs the golden tag on macOS only), so the
/// comparator below tolerates anti-aliasing noise but not layout changes.
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
  final comparator = goldenFileComparator;
  if (comparator is LocalFileComparator) {
    goldenFileComparator = _TolerantComparator(
      comparator.basedir.resolve('catalog_goldens_test.dart'),
    );
  }
  await testMain();
}

/// Accepts goldens that differ by at most [tolerance] of their pixels.
///
/// 0.5% is well above the ~0.02% of glyph anti-aliasing seen between Apple
/// Silicon machines, and far below what a moved, resized or recoloured element
/// produces.
final class _TolerantComparator extends LocalFileComparator {
  _TolerantComparator(super.testFile);

  static const tolerance = 0.005;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );
    try {
      if (result.passed || result.diffPercent <= tolerance) return true;
      throw TestFailure(await generateFailureOutput(result, golden, basedir));
    } finally {
      result.dispose();
    }
  }
}
