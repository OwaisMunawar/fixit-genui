import 'dart:io';
import 'dart:typed_data';

import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/features/jobs/data/file_photo_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory root;
  late FilePhotoStore store;

  setUp(() {
    root = Directory.systemTemp.createTempSync('fixit_photos');
    store = FilePhotoStore(root);
  });

  tearDown(() => root.deleteSync(recursive: true));

  test('saves under the job folder with a relative path', () async {
    final path = await store.save('job1', Uint8List.fromList([1, 2, 3]));

    expect(path, startsWith('jobs/job1/'));
    expect(path, endsWith('.jpg'));
    expect(File(store.absolutePath(path)).existsSync(), isTrue);
    expect(await store.read(path), [1, 2, 3]);
  });

  test('reading a missing photo returns null', () async {
    expect(await store.read('jobs/none/x.jpg'), isNull);
  });

  test('deletes a job folder, and tolerates one that never existed', () async {
    final path = await store.save('job1', Uint8List(1));

    await store.deleteJob('job1');
    await store.deleteJob('never');

    expect(File(store.absolutePath(path)).existsSync(), isFalse);
  });

  test('surfaces file system errors as a StorageFailure', () async {
    final blocked = FilePhotoStore(Directory('/dev/null/fixit'));
    await expectLater(
      blocked.save('job', Uint8List(1)),
      throwsA(isA<StorageFailure>()),
    );
  });
}
