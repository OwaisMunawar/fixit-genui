import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fixit/core/di/core_providers.dart';
import 'package:fixit/features/jobs/data/database/app_database.dart';
import 'package:fixit/features/jobs/domain/job_repository.dart';
import 'package:fixit/features/jobs/jobs_providers.dart';
import 'package:fixit/genui/generator/repair_generator.dart';
import 'package:fixit/genui/genui_providers.dart';
import 'package:flutter_riverpod/misc.dart';

import 'fakes.dart';

AppDatabase memoryDatabase() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  return AppDatabase(NativeDatabase.memory());
}

/// Everything a test needs to run the real app offline.
List<Override> appOverrides({
  required RepairGenerator generator,
  AppDatabase? db,
  JobRepository? repository,
  MemoryPhotoStore? photos,
  DateTime Function()? clock,
}) => [
  if (db != null) appDatabaseProvider.overrideWithValue(db),
  if (repository != null) jobRepositoryProvider.overrideWithValue(repository),
  photoStoreProvider.overrideWithValue(photos ?? MemoryPhotoStore()),
  repairGeneratorProvider.overrideWithValue(generator),
  if (clock != null) clockProvider.overrideWithValue(clock),
];
