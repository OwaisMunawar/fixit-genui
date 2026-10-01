import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/features/assistant/domain/image_downscaler.dart';
import 'package:fixit/features/assistant/domain/picked_photo.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

/// Photo capture via `image_picker`, which covers both the camera and the
/// library with the system UI. The `camera` package would only be worth its
/// weight for a custom viewfinder, which this app doesn't need.
final class ImagePickerPhotoSource implements PhotoSource {
  ImagePickerPhotoSource(this._picker);

  final ImagePicker _picker;

  @override
  bool get canUseCamera => _picker.supportsImageSource(ImageSource.camera);

  @override
  Future<PickedPhoto?> pick(PhotoOrigin origin) async {
    final XFile? file;
    try {
      file = await _picker.pickImage(
        source: switch (origin) {
          PhotoOrigin.camera => ImageSource.camera,
          PhotoOrigin.library => ImageSource.gallery,
        },
        // A first, native-side reduction keeps the bytes crossing the
        // platform channel small; ImageDownscaler then sets the final size.
        maxWidth: 2048,
        maxHeight: 2048,
        requestFullMetadata: false,
      );
    } on PlatformException catch (error) {
      throw PermissionFailure(error.code);
    }
    if (file == null) return null;
    return ImageDownscaler.downscaleInBackground(await file.readAsBytes());
  }
}
