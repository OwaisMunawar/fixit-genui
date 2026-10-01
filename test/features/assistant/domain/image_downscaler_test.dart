import 'dart:typed_data';

import 'package:fixit/features/assistant/domain/image_downscaler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

Uint8List pngOf(int width, int height) =>
    img.encodePng(img.Image(width: width, height: height));

void main() {
  test('caps the long edge and keeps the aspect ratio', () {
    final landscape = ImageDownscaler.downscale(pngOf(4000, 3000))!;
    expect((landscape.width, landscape.height), (1024, 768));

    final portrait = ImageDownscaler.downscale(pngOf(1500, 3000))!;
    expect((portrait.width, portrait.height), (512, 1024));
  });

  test('leaves small images their size but re-encodes as JPEG', () {
    final photo = ImageDownscaler.downscale(pngOf(300, 200))!;

    expect((photo.width, photo.height), (300, 200));
    expect(photo.bytes.sublist(0, 2), [0xFF, 0xD8], reason: 'JPEG magic');
    expect(photo.mimeType, 'image/jpeg');
  });

  test('returns null for bytes that are not an image', () {
    expect(ImageDownscaler.downscale(Uint8List.fromList([1, 2, 3])), isNull);
  });

  test('runs off the UI isolate', () async {
    final photo = await ImageDownscaler.downscaleInBackground(
      pngOf(2048, 100),
    );
    expect(photo!.width, 1024);
  });
}
