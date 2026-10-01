import 'package:drift/drift.dart';
import 'package:fixit/features/jobs/domain/job_status.dart';

@DataClassName('JobRow')
class Jobs extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get status => intEnum<JobStatus>()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get completedSteps => integer().withDefault(const Constant(0))();
  IntColumn get totalSteps => integer().withDefault(const Constant(0))();
  TextColumn get thumbnailPath => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Job history as an append-only log of JSON payloads. Entries are only ever
/// read back whole, in order, so a document column beats a table per kind.
@DataClassName('JobEntryRow')
class JobEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get jobId =>
      text().references(Jobs, #id, onDelete: KeyAction.cascade)();
  IntColumn get seq => integer()();
  TextColumn get payload => text()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {jobId, seq},
  ];
}

@DataClassName('ChecklistProgressRow')
class ChecklistProgress extends Table {
  TextColumn get jobId =>
      text().references(Jobs, #id, onDelete: KeyAction.cascade)();
  TextColumn get surfaceId => text()();
  TextColumn get componentId => text()();

  /// JSON array of completed step ids.
  TextColumn get completedStepIds => text()();

  @override
  Set<Column<Object>> get primaryKey => {jobId, surfaceId, componentId};
}
