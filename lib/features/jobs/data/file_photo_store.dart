import 'dart:io';
import 'dart:typed_data';

import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/features/jobs/domain/photo_store.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

final class FilePhotoStore implements PhotoStore {
  FilePhotoStore(this._root, {this._uuid = const Uuid()});

  final Directory _root;
  final Uuid _uuid;

  static String _jobFolder(String jobId) => p.join('jobs', jobId);

  @override
  Future<String> save(String jobId, Uint8List jpegBytes) async {
    final relative = p.join(_jobFolder(jobId), '${_uuid.v4()}.jpg');
    try {
      final file = File(absolutePath(relative));
      await file.parent.create(recursive: true);
      await file.writeAsBytes(jpegBytes, flush: true);
      return relative;
    } on FileSystemException catch (error) {
      throw StorageFailure(error);
    }
  }

  @override
  Future<Uint8List?> read(String relativePath) async {
    final file = File(absolutePath(relativePath));
    if (!file.existsSync()) return null;
    return file.readAsBytes();
  }

  @override
  String absolutePath(String relativePath) => p.join(_root.path, relativePath);

  @override
  Future<void> deleteJob(String jobId) async {
    final folder = Directory(absolutePath(_jobFolder(jobId)));
    if (folder.existsSync()) await folder.delete(recursive: true);
  }
}
