import 'dart:isolate';

import 'package:fixit/features/assistant/domain/picked_photo.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

/// Shrinks photos before they are stored or sent.
///
/// A 12MP phone photo is 3 to 5MB; vision models tile large images and bill
/// per tile, and gain little detail past about 1000px for "what is this
/// fitting". 1024px on the long edge at quality 80 is roughly 150KB, which
/// keeps uploads fast on a weak signal and the local job folder small.
abstract final class ImageDownscaler {
  static const maxDimension = 1024;
  static const jpegQuality = 80;

  /// Returns null if [bytes] is not an image the decoder understands.
  static PickedPhoto? downscale(
    Uint8List bytes, {
    int maxDimension = ImageDownscaler.maxDimension,
    int quality = jpegQuality,
  }) {
    final img.Image? decoded;
    try {
      decoded = img.decodeImage(bytes);
    } on Object {
      // The decoder probes every format it knows and some probes throw
      // RangeError on short or garbage input instead of returning null.
      return null;
    }
    if (decoded == null) return null;
    // Camera JPEGs are often stored sideways with an EXIF rotation flag;
    // bake it in, because the re-encoded file drops EXIF.
    var image = img.bakeOrientation(decoded);
    final longest = image.width > image.height ? image.width : image.height;
    if (longest > maxDimension) {
      image = image.width >= image.height
          ? img.copyResize(
              image,
              width: maxDimension,
              interpolation: img.Interpolation.average,
            )
          : img.copyResize(
              image,
              height: maxDimension,
              interpolation: img.Interpolation.average,
            );
    }
    return PickedPhoto(
      bytes: img.encodeJpg(image, quality: quality),
      width: image.width,
      height: image.height,
    );
  }

  /// Decoding a full-size photo takes long enough to drop frames, so it runs
  /// off the UI isolate.
  static Future<PickedPhoto?> downscaleInBackground(Uint8List bytes) =>
      Isolate.run(() => downscale(bytes));
}
