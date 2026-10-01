import 'package:fixit/app.dart';
import 'package:fixit/features/jobs/data/file_photo_store.dart';
import 'package:fixit/features/jobs/jobs_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:path_provider/path_provider.dart';

/// Builds the app with its async dependencies resolved. The integration test
/// calls this too, with overrides for the database and generator.
Future<Widget> bootstrap({List<Override> overrides = const []}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final documents = await getApplicationDocumentsDirectory();
  return ProviderScope(
    overrides: [
      photoStoreProvider.overrideWithValue(FilePhotoStore(documents)),
      ...overrides,
    ],
    child: const FixitApp(),
  );
}
