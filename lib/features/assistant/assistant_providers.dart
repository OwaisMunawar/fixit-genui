import 'package:fixit/features/assistant/data/image_picker_photo_source.dart';
import 'package:fixit/features/assistant/domain/picked_photo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final photoSourceProvider = Provider<PhotoSource>(
  (ref) => ImagePickerPhotoSource(ImagePicker()),
);
