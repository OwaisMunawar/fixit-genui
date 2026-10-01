import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:fixit/features/jobs/data/database/tables.dart';
import 'package:fixit/features/jobs/domain/job_status.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Jobs, JobEntries, ChecklistProgress])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  factory AppDatabase.onDevice() => AppDatabase(driftDatabase(name: 'fixit'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    // SQLite ignores foreign keys, and so the cascades above, unless asked.
    beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
  );
}
