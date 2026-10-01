import 'package:flutter/foundation.dart';

enum PhotoOrigin { camera, library }

/// A photo that has already been downscaled and re-encoded as JPEG.
@immutable
final class PickedPhoto {
  const PickedPhoto({
    required this.bytes,
    required this.width,
    required this.height,
  });

  final Uint8List bytes;
  final int width;
  final int height;

  String get mimeType => 'image/jpeg';
}

abstract interface class PhotoSource {
  bool get canUseCamera;

  /// Returns null when the user cancels. Throws `PermissionFailure` when
  /// access was denied.
  Future<PickedPhoto?> pick(PhotoOrigin origin);
}
