import 'dart:typed_data';

/// Where job photos live. Paths are relative to the store, because the app
/// container path on iOS changes between installs and updates.
abstract interface class PhotoStore {
  Future<String> save(String jobId, Uint8List jpegBytes);

  Future<Uint8List?> read(String relativePath);

  /// Absolute path for display. The file may no longer exist.
  String absolutePath(String relativePath);

  Future<void> deleteJob(String jobId);
}
