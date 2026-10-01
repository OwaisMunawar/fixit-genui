// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $JobsTable extends Jobs with TableInfo<$JobsTable, JobRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<JobStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<JobStatus>($JobsTable.$converterstatus);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedStepsMeta = const VerificationMeta(
    'completedSteps',
  );
  @override
  late final GeneratedColumn<int> completedSteps = GeneratedColumn<int>(
    'completed_steps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalStepsMeta = const VerificationMeta(
    'totalSteps',
  );
  @override
  late final GeneratedColumn<int> totalSteps = GeneratedColumn<int>(
    'total_steps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _thumbnailPathMeta = const VerificationMeta(
    'thumbnailPath',
  );
  @override
  late final GeneratedColumn<String> thumbnailPath = GeneratedColumn<String>(
    'thumbnail_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    status,
    createdAt,
    updatedAt,
    completedSteps,
    totalSteps,
    thumbnailPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('completed_steps')) {
      context.handle(
        _completedStepsMeta,
        completedSteps.isAcceptableOrUnknown(
          data['completed_steps']!,
          _completedStepsMeta,
        ),
      );
    }
    if (data.containsKey('total_steps')) {
      context.handle(
        _totalStepsMeta,
        totalSteps.isAcceptableOrUnknown(data['total_steps']!, _totalStepsMeta),
      );
    }
    if (data.containsKey('thumbnail_path')) {
      context.handle(
        _thumbnailPathMeta,
        thumbnailPath.isAcceptableOrUnknown(
          data['thumbnail_path']!,
          _thumbnailPathMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JobRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      status: $JobsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      completedSteps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_steps'],
      )!,
      totalSteps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_steps'],
      )!,
      thumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_path'],
      ),
    );
  }

  @override
  $JobsTable createAlias(String alias) {
    return $JobsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<JobStatus, int, int> $converterstatus =
      const EnumIndexConverter<JobStatus>(JobStatus.values);
}

class JobRow extends DataClass implements Insertable<JobRow> {
  final String id;
  final String title;
  final JobStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int completedSteps;
  final int totalSteps;
  final String? thumbnailPath;
  const JobRow({
    required this.id,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.completedSteps,
    required this.totalSteps,
    this.thumbnailPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    {
      map['status'] = Variable<int>($JobsTable.$converterstatus.toSql(status));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['completed_steps'] = Variable<int>(completedSteps);
    map['total_steps'] = Variable<int>(totalSteps);
    if (!nullToAbsent || thumbnailPath != null) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath);
    }
    return map;
  }

  JobsCompanion toCompanion(bool nullToAbsent) {
    return JobsCompanion(
      id: Value(id),
      title: Value(title),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      completedSteps: Value(completedSteps),
      totalSteps: Value(totalSteps),
      thumbnailPath: thumbnailPath == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailPath),
    );
  }

  factory JobRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      status: $JobsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      completedSteps: serializer.fromJson<int>(json['completedSteps']),
      totalSteps: serializer.fromJson<int>(json['totalSteps']),
      thumbnailPath: serializer.fromJson<String?>(json['thumbnailPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'status': serializer.toJson<int>(
        $JobsTable.$converterstatus.toJson(status),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'completedSteps': serializer.toJson<int>(completedSteps),
      'totalSteps': serializer.toJson<int>(totalSteps),
      'thumbnailPath': serializer.toJson<String?>(thumbnailPath),
    };
  }

  JobRow copyWith({
    String? id,
    String? title,
    JobStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? completedSteps,
    int? totalSteps,
    Value<String?> thumbnailPath = const Value.absent(),
  }) => JobRow(
    id: id ?? this.id,
    title: title ?? this.title,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    completedSteps: completedSteps ?? this.completedSteps,
    totalSteps: totalSteps ?? this.totalSteps,
    thumbnailPath: thumbnailPath.present
        ? thumbnailPath.value
        : this.thumbnailPath,
  );
  JobRow copyWithCompanion(JobsCompanion data) {
    return JobRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedSteps: data.completedSteps.present
          ? data.completedSteps.value
          : this.completedSteps,
      totalSteps: data.totalSteps.present
          ? data.totalSteps.value
          : this.totalSteps,
      thumbnailPath: data.thumbnailPath.present
          ? data.thumbnailPath.value
          : this.thumbnailPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedSteps: $completedSteps, ')
          ..write('totalSteps: $totalSteps, ')
          ..write('thumbnailPath: $thumbnailPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    status,
    createdAt,
    updatedAt,
    completedSteps,
    totalSteps,
    thumbnailPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.completedSteps == this.completedSteps &&
          other.totalSteps == this.totalSteps &&
          other.thumbnailPath == this.thumbnailPath);
}

class JobsCompanion extends UpdateCompanion<JobRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<JobStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> completedSteps;
  final Value<int> totalSteps;
  final Value<String?> thumbnailPath;
  final Value<int> rowid;
  const JobsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedSteps = const Value.absent(),
    this.totalSteps = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JobsCompanion.insert({
    required String id,
    required String title,
    required JobStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.completedSteps = const Value.absent(),
    this.totalSteps = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<JobRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? completedSteps,
    Expression<int>? totalSteps,
    Expression<String>? thumbnailPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedSteps != null) 'completed_steps': completedSteps,
      if (totalSteps != null) 'total_steps': totalSteps,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JobsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<JobStatus>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? completedSteps,
    Value<int>? totalSteps,
    Value<String?>? thumbnailPath,
    Value<int>? rowid,
  }) {
    return JobsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedSteps: completedSteps ?? this.completedSteps,
      totalSteps: totalSteps ?? this.totalSteps,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $JobsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (completedSteps.present) {
      map['completed_steps'] = Variable<int>(completedSteps.value);
    }
    if (totalSteps.present) {
      map['total_steps'] = Variable<int>(totalSteps.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedSteps: $completedSteps, ')
          ..write('totalSteps: $totalSteps, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JobEntriesTable extends JobEntries
    with TableInfo<$JobEntriesTable, JobEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<String> jobId = GeneratedColumn<String>(
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jobs (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
    'seq',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, jobId, seq, payload];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'job_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('seq')) {
      context.handle(
        _seqMeta,
        seq.isAcceptableOrUnknown(data['seq']!, _seqMeta),
      );
    } else if (isInserting) {
      context.missing(_seqMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {jobId, seq},
  ];
  @override
  JobEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_id'],
      )!,
      seq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seq'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
    );
  }

  @override
  $JobEntriesTable createAlias(String alias) {
    return $JobEntriesTable(attachedDatabase, alias);
  }
}

class JobEntryRow extends DataClass implements Insertable<JobEntryRow> {
  final int id;
  final String jobId;
  final int seq;
  final String payload;
  const JobEntryRow({
    required this.id,
    required this.jobId,
    required this.seq,
    required this.payload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['job_id'] = Variable<String>(jobId);
    map['seq'] = Variable<int>(seq);
    map['payload'] = Variable<String>(payload);
    return map;
  }

  JobEntriesCompanion toCompanion(bool nullToAbsent) {
    return JobEntriesCompanion(
      id: Value(id),
      jobId: Value(jobId),
      seq: Value(seq),
      payload: Value(payload),
    );
  }

  factory JobEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobEntryRow(
      id: serializer.fromJson<int>(json['id']),
      jobId: serializer.fromJson<String>(json['jobId']),
      seq: serializer.fromJson<int>(json['seq']),
      payload: serializer.fromJson<String>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jobId': serializer.toJson<String>(jobId),
      'seq': serializer.toJson<int>(seq),
      'payload': serializer.toJson<String>(payload),
    };
  }

  JobEntryRow copyWith({int? id, String? jobId, int? seq, String? payload}) =>
      JobEntryRow(
        id: id ?? this.id,
        jobId: jobId ?? this.jobId,
        seq: seq ?? this.seq,
        payload: payload ?? this.payload,
      );
  JobEntryRow copyWithCompanion(JobEntriesCompanion data) {
    return JobEntryRow(
      id: data.id.present ? data.id.value : this.id,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      seq: data.seq.present ? data.seq.value : this.seq,
      payload: data.payload.present ? data.payload.value : this.payload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobEntryRow(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('seq: $seq, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jobId, seq, payload);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobEntryRow &&
          other.id == this.id &&
          other.jobId == this.jobId &&
          other.seq == this.seq &&
          other.payload == this.payload);
}

class JobEntriesCompanion extends UpdateCompanion<JobEntryRow> {
  final Value<int> id;
  final Value<String> jobId;
  final Value<int> seq;
  final Value<String> payload;
  const JobEntriesCompanion({
    this.id = const Value.absent(),
    this.jobId = const Value.absent(),
    this.seq = const Value.absent(),
    this.payload = const Value.absent(),
  });
  JobEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String jobId,
    required int seq,
    required String payload,
  }) : jobId = Value(jobId),
       seq = Value(seq),
       payload = Value(payload);
  static Insertable<JobEntryRow> custom({
    Expression<int>? id,
    Expression<String>? jobId,
    Expression<int>? seq,
    Expression<String>? payload,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobId != null) 'job_id': jobId,
      if (seq != null) 'seq': seq,
      if (payload != null) 'payload': payload,
    });
  }

  JobEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? jobId,
    Value<int>? seq,
    Value<String>? payload,
  }) {
    return JobEntriesCompanion(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      seq: seq ?? this.seq,
      payload: payload ?? this.payload,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<String>(jobId.value);
    }
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobEntriesCompanion(')
          ..write('id: $id, ')
          ..write('jobId: $jobId, ')
          ..write('seq: $seq, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }
}

class $ChecklistProgressTable extends ChecklistProgress
    with TableInfo<$ChecklistProgressTable, ChecklistProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<String> jobId = GeneratedColumn<String>(
    'job_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES jobs (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _surfaceIdMeta = const VerificationMeta(
    'surfaceId',
  );
  @override
  late final GeneratedColumn<String> surfaceId = GeneratedColumn<String>(
    'surface_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _componentIdMeta = const VerificationMeta(
    'componentId',
  );
  @override
  late final GeneratedColumn<String> componentId = GeneratedColumn<String>(
    'component_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedStepIdsMeta = const VerificationMeta(
    'completedStepIds',
  );
  @override
  late final GeneratedColumn<String> completedStepIds = GeneratedColumn<String>(
    'completed_step_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    jobId,
    surfaceId,
    componentId,
    completedStepIds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecklistProgressRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('job_id')) {
      context.handle(
        _jobIdMeta,
        jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta),
      );
    } else if (isInserting) {
      context.missing(_jobIdMeta);
    }
    if (data.containsKey('surface_id')) {
      context.handle(
        _surfaceIdMeta,
        surfaceId.isAcceptableOrUnknown(data['surface_id']!, _surfaceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_surfaceIdMeta);
    }
    if (data.containsKey('component_id')) {
      context.handle(
        _componentIdMeta,
        componentId.isAcceptableOrUnknown(
          data['component_id']!,
          _componentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_componentIdMeta);
    }
    if (data.containsKey('completed_step_ids')) {
      context.handle(
        _completedStepIdsMeta,
        completedStepIds.isAcceptableOrUnknown(
          data['completed_step_ids']!,
          _completedStepIdsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedStepIdsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {jobId, surfaceId, componentId};
  @override
  ChecklistProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistProgressRow(
      jobId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_id'],
      )!,
      surfaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surface_id'],
      )!,
      componentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}component_id'],
      )!,
      completedStepIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_step_ids'],
      )!,
    );
  }

  @override
  $ChecklistProgressTable createAlias(String alias) {
    return $ChecklistProgressTable(attachedDatabase, alias);
  }
}

class ChecklistProgressRow extends DataClass
    implements Insertable<ChecklistProgressRow> {
  final String jobId;
  final String surfaceId;
  final String componentId;

  /// JSON array of completed step ids.
  final String completedStepIds;
  const ChecklistProgressRow({
    required this.jobId,
    required this.surfaceId,
    required this.componentId,
    required this.completedStepIds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['job_id'] = Variable<String>(jobId);
    map['surface_id'] = Variable<String>(surfaceId);
    map['component_id'] = Variable<String>(componentId);
    map['completed_step_ids'] = Variable<String>(completedStepIds);
    return map;
  }

  ChecklistProgressCompanion toCompanion(bool nullToAbsent) {
    return ChecklistProgressCompanion(
      jobId: Value(jobId),
      surfaceId: Value(surfaceId),
      componentId: Value(componentId),
      completedStepIds: Value(completedStepIds),
    );
  }

  factory ChecklistProgressRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistProgressRow(
      jobId: serializer.fromJson<String>(json['jobId']),
      surfaceId: serializer.fromJson<String>(json['surfaceId']),
      componentId: serializer.fromJson<String>(json['componentId']),
      completedStepIds: serializer.fromJson<String>(json['completedStepIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'jobId': serializer.toJson<String>(jobId),
      'surfaceId': serializer.toJson<String>(surfaceId),
      'componentId': serializer.toJson<String>(componentId),
      'completedStepIds': serializer.toJson<String>(completedStepIds),
    };
  }

  ChecklistProgressRow copyWith({
    String? jobId,
    String? surfaceId,
    String? componentId,
    String? completedStepIds,
  }) => ChecklistProgressRow(
    jobId: jobId ?? this.jobId,
    surfaceId: surfaceId ?? this.surfaceId,
    componentId: componentId ?? this.componentId,
    completedStepIds: completedStepIds ?? this.completedStepIds,
  );
  ChecklistProgressRow copyWithCompanion(ChecklistProgressCompanion data) {
    return ChecklistProgressRow(
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      surfaceId: data.surfaceId.present ? data.surfaceId.value : this.surfaceId,
      componentId: data.componentId.present
          ? data.componentId.value
          : this.componentId,
      completedStepIds: data.completedStepIds.present
          ? data.completedStepIds.value
          : this.completedStepIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistProgressRow(')
          ..write('jobId: $jobId, ')
          ..write('surfaceId: $surfaceId, ')
          ..write('componentId: $componentId, ')
          ..write('completedStepIds: $completedStepIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(jobId, surfaceId, componentId, completedStepIds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistProgressRow &&
          other.jobId == this.jobId &&
          other.surfaceId == this.surfaceId &&
          other.componentId == this.componentId &&
          other.completedStepIds == this.completedStepIds);
}

class ChecklistProgressCompanion extends UpdateCompanion<ChecklistProgressRow> {
  final Value<String> jobId;
  final Value<String> surfaceId;
  final Value<String> componentId;
  final Value<String> completedStepIds;
  final Value<int> rowid;
  const ChecklistProgressCompanion({
    this.jobId = const Value.absent(),
    this.surfaceId = const Value.absent(),
    this.componentId = const Value.absent(),
    this.completedStepIds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecklistProgressCompanion.insert({
    required String jobId,
    required String surfaceId,
    required String componentId,
    required String completedStepIds,
    this.rowid = const Value.absent(),
  }) : jobId = Value(jobId),
       surfaceId = Value(surfaceId),
       componentId = Value(componentId),
       completedStepIds = Value(completedStepIds);
  static Insertable<ChecklistProgressRow> custom({
    Expression<String>? jobId,
    Expression<String>? surfaceId,
    Expression<String>? componentId,
    Expression<String>? completedStepIds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (jobId != null) 'job_id': jobId,
      if (surfaceId != null) 'surface_id': surfaceId,
      if (componentId != null) 'component_id': componentId,
      if (completedStepIds != null) 'completed_step_ids': completedStepIds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistProgressCompanion copyWith({
    Value<String>? jobId,
    Value<String>? surfaceId,
    Value<String>? componentId,
    Value<String>? completedStepIds,
    Value<int>? rowid,
  }) {
    return ChecklistProgressCompanion(
      jobId: jobId ?? this.jobId,
      surfaceId: surfaceId ?? this.surfaceId,
      componentId: componentId ?? this.componentId,
      completedStepIds: completedStepIds ?? this.completedStepIds,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (jobId.present) {
      map['job_id'] = Variable<String>(jobId.value);
    }
    if (surfaceId.present) {
      map['surface_id'] = Variable<String>(surfaceId.value);
    }
    if (componentId.present) {
      map['component_id'] = Variable<String>(componentId.value);
    }
    if (completedStepIds.present) {
      map['completed_step_ids'] = Variable<String>(completedStepIds.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistProgressCompanion(')
          ..write('jobId: $jobId, ')
          ..write('surfaceId: $surfaceId, ')
          ..write('componentId: $componentId, ')
          ..write('completedStepIds: $completedStepIds, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $JobsTable jobs = $JobsTable(this);
  late final $JobEntriesTable jobEntries = $JobEntriesTable(this);
  late final $ChecklistProgressTable checklistProgress =
      $ChecklistProgressTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    jobs,
    jobEntries,
    checklistProgress,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'jobs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('job_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'jobs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('checklist_progress', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$JobsTableCreateCompanionBuilder =
    JobsCompanion Function({
      required String id,
      required String title,
      required JobStatus status,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> completedSteps,
      Value<int> totalSteps,
      Value<String?> thumbnailPath,
      Value<int> rowid,
    });
typedef $$JobsTableUpdateCompanionBuilder =
    JobsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<JobStatus> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> completedSteps,
      Value<int> totalSteps,
      Value<String?> thumbnailPath,
      Value<int> rowid,
    });

final class $$JobsTableReferences
    extends BaseReferences<_$AppDatabase, $JobsTable, JobRow> {
  $$JobsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$JobEntriesTable, List<JobEntryRow>>
  _jobEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.jobEntries,
    aliasName: 'jobs__id__job_entries__job_id',
  );

  $$JobEntriesTableProcessedTableManager get jobEntriesRefs {
    final manager = $$JobEntriesTableTableManager(
      $_db,
      $_db.jobEntries,
    ).filter((f) => f.jobId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_jobEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ChecklistProgressTable,
    List<ChecklistProgressRow>
  >
  _checklistProgressRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.checklistProgress,
        aliasName: 'jobs__id__checklist_progress__job_id',
      );

  $$ChecklistProgressTableProcessedTableManager get checklistProgressRefs {
    final manager = $$ChecklistProgressTableTableManager(
      $_db,
      $_db.checklistProgress,
    ).filter((f) => f.jobId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _checklistProgressRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JobsTableFilterComposer extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<JobStatus, JobStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedSteps => $composableBuilder(
    column: $table.completedSteps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalSteps => $composableBuilder(
    column: $table.totalSteps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> jobEntriesRefs(
    Expression<bool> Function($$JobEntriesTableFilterComposer f) f,
  ) {
    final $$JobEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobEntries,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobEntriesTableFilterComposer(
            $db: $db,
            $table: $db.jobEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> checklistProgressRefs(
    Expression<bool> Function($$ChecklistProgressTableFilterComposer f) f,
  ) {
    final $$ChecklistProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checklistProgress,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChecklistProgressTableFilterComposer(
            $db: $db,
            $table: $db.checklistProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobsTableOrderingComposer extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedSteps => $composableBuilder(
    column: $table.completedSteps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalSteps => $composableBuilder(
    column: $table.totalSteps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JobsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobsTable> {
  $$JobsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<JobStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get completedSteps => $composableBuilder(
    column: $table.completedSteps,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalSteps => $composableBuilder(
    column: $table.totalSteps,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => column,
  );

  Expression<T> jobEntriesRefs<T extends Object>(
    Expression<T> Function($$JobEntriesTableAnnotationComposer a) f,
  ) {
    final $$JobEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobEntries,
      getReferencedColumn: (t) => t.jobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.jobEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> checklistProgressRefs<T extends Object>(
    Expression<T> Function($$ChecklistProgressTableAnnotationComposer a) f,
  ) {
    final $$ChecklistProgressTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.checklistProgress,
          getReferencedColumn: (t) => t.jobId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChecklistProgressTableAnnotationComposer(
                $db: $db,
                $table: $db.checklistProgress,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$JobsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobsTable,
          JobRow,
          $$JobsTableFilterComposer,
          $$JobsTableOrderingComposer,
          $$JobsTableAnnotationComposer,
          $$JobsTableCreateCompanionBuilder,
          $$JobsTableUpdateCompanionBuilder,
          (JobRow, $$JobsTableReferences),
          JobRow,
          PrefetchHooks Function({
            bool jobEntriesRefs,
            bool checklistProgressRefs,
          })
        > {
  $$JobsTableTableManager(_$AppDatabase db, $JobsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<JobStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> completedSteps = const Value.absent(),
                Value<int> totalSteps = const Value.absent(),
                Value<String?> thumbnailPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JobsCompanion(
                id: id,
                title: title,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedSteps: completedSteps,
                totalSteps: totalSteps,
                thumbnailPath: thumbnailPath,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required JobStatus status,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> completedSteps = const Value.absent(),
                Value<int> totalSteps = const Value.absent(),
                Value<String?> thumbnailPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JobsCompanion.insert(
                id: id,
                title: title,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedSteps: completedSteps,
                totalSteps: totalSteps,
                thumbnailPath: thumbnailPath,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$JobsTable, JobRow>(table),
                  $$JobsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({jobEntriesRefs = false, checklistProgressRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (jobEntriesRefs) db.jobEntries,
                    if (checklistProgressRefs) db.checklistProgress,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (jobEntriesRefs)
                        await $_getPrefetchedData<
                          JobRow,
                          $JobsTable,
                          JobEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$JobsTableReferences
                              ._jobEntriesRefsTable(db),
                          managerFromTypedResult: (p0) => $$JobsTableReferences(
                            db,
                            table,
                            p0,
                          ).jobEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.jobId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (checklistProgressRefs)
                        await $_getPrefetchedData<
                          JobRow,
                          $JobsTable,
                          ChecklistProgressRow
                        >(
                          currentTable: table,
                          referencedTable: $$JobsTableReferences
                              ._checklistProgressRefsTable(db),
                          managerFromTypedResult: (p0) => $$JobsTableReferences(
                            db,
                            table,
                            p0,
                          ).checklistProgressRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.jobId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$JobsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobsTable,
      JobRow,
      $$JobsTableFilterComposer,
      $$JobsTableOrderingComposer,
      $$JobsTableAnnotationComposer,
      $$JobsTableCreateCompanionBuilder,
      $$JobsTableUpdateCompanionBuilder,
      (JobRow, $$JobsTableReferences),
      JobRow,
      PrefetchHooks Function({bool jobEntriesRefs, bool checklistProgressRefs})
    >;
typedef $$JobEntriesTableCreateCompanionBuilder =
    JobEntriesCompanion Function({
      Value<int> id,
      required String jobId,
      required int seq,
      required String payload,
    });
typedef $$JobEntriesTableUpdateCompanionBuilder =
    JobEntriesCompanion Function({
      Value<int> id,
      Value<String> jobId,
      Value<int> seq,
      Value<String> payload,
    });

final class $$JobEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $JobEntriesTable, JobEntryRow> {
  $$JobEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $JobsTable _jobIdTable(_$AppDatabase db) =>
      db.jobs.createAlias('job_entries__job_id__jobs__id');

  $$JobsTableProcessedTableManager get jobId {
    final $_column = $_itemColumn<String>('job_id')!;

    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$JobEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JobEntriesTable> {
  $$JobEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JobEntriesTable> {
  $$JobEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableOrderingComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobEntriesTable> {
  $$JobEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get seq =>
      $composableBuilder(column: $table.seq, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  $$JobsTableAnnotationComposer get jobId {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobEntriesTable,
          JobEntryRow,
          $$JobEntriesTableFilterComposer,
          $$JobEntriesTableOrderingComposer,
          $$JobEntriesTableAnnotationComposer,
          $$JobEntriesTableCreateCompanionBuilder,
          $$JobEntriesTableUpdateCompanionBuilder,
          (JobEntryRow, $$JobEntriesTableReferences),
          JobEntryRow,
          PrefetchHooks Function({bool jobId})
        > {
  $$JobEntriesTableTableManager(_$AppDatabase db, $JobEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> jobId = const Value.absent(),
                Value<int> seq = const Value.absent(),
                Value<String> payload = const Value.absent(),
              }) => JobEntriesCompanion(
                id: id,
                jobId: jobId,
                seq: seq,
                payload: payload,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String jobId,
                required int seq,
                required String payload,
              }) => JobEntriesCompanion.insert(
                id: id,
                jobId: jobId,
                seq: seq,
                payload: payload,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$JobEntriesTable, JobEntryRow>(table),
                  $$JobEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({jobId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (jobId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.jobId,
                                referencedTable: $$JobEntriesTableReferences
                                    ._jobIdTable(db),
                                referencedColumn: $$JobEntriesTableReferences
                                    ._jobIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$JobEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobEntriesTable,
      JobEntryRow,
      $$JobEntriesTableFilterComposer,
      $$JobEntriesTableOrderingComposer,
      $$JobEntriesTableAnnotationComposer,
      $$JobEntriesTableCreateCompanionBuilder,
      $$JobEntriesTableUpdateCompanionBuilder,
      (JobEntryRow, $$JobEntriesTableReferences),
      JobEntryRow,
      PrefetchHooks Function({bool jobId})
    >;
typedef $$ChecklistProgressTableCreateCompanionBuilder =
    ChecklistProgressCompanion Function({
      required String jobId,
      required String surfaceId,
      required String componentId,
      required String completedStepIds,
      Value<int> rowid,
    });
typedef $$ChecklistProgressTableUpdateCompanionBuilder =
    ChecklistProgressCompanion Function({
      Value<String> jobId,
      Value<String> surfaceId,
      Value<String> componentId,
      Value<String> completedStepIds,
      Value<int> rowid,
    });

final class $$ChecklistProgressTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ChecklistProgressTable,
          ChecklistProgressRow
        > {
  $$ChecklistProgressTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $JobsTable _jobIdTable(_$AppDatabase db) =>
      db.jobs.createAlias('checklist_progress__job_id__jobs__id');

  $$JobsTableProcessedTableManager get jobId {
    final $_column = $_itemColumn<String>('job_id')!;

    final manager = $$JobsTableTableManager(
      $_db,
      $_db.jobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_jobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChecklistProgressTableFilterComposer
    extends Composer<_$AppDatabase, $ChecklistProgressTable> {
  $$ChecklistProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get surfaceId => $composableBuilder(
    column: $table.surfaceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get componentId => $composableBuilder(
    column: $table.componentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedStepIds => $composableBuilder(
    column: $table.completedStepIds,
    builder: (column) => ColumnFilters(column),
  );

  $$JobsTableFilterComposer get jobId {
    final $$JobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableFilterComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChecklistProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $ChecklistProgressTable> {
  $$ChecklistProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get surfaceId => $composableBuilder(
    column: $table.surfaceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get componentId => $composableBuilder(
    column: $table.componentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedStepIds => $composableBuilder(
    column: $table.completedStepIds,
    builder: (column) => ColumnOrderings(column),
  );

  $$JobsTableOrderingComposer get jobId {
    final $$JobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableOrderingComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChecklistProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChecklistProgressTable> {
  $$ChecklistProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get surfaceId =>
      $composableBuilder(column: $table.surfaceId, builder: (column) => column);

  GeneratedColumn<String> get componentId => $composableBuilder(
    column: $table.componentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get completedStepIds => $composableBuilder(
    column: $table.completedStepIds,
    builder: (column) => column,
  );

  $$JobsTableAnnotationComposer get jobId {
    final $$JobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.jobId,
      referencedTable: $db.jobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChecklistProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChecklistProgressTable,
          ChecklistProgressRow,
          $$ChecklistProgressTableFilterComposer,
          $$ChecklistProgressTableOrderingComposer,
          $$ChecklistProgressTableAnnotationComposer,
          $$ChecklistProgressTableCreateCompanionBuilder,
          $$ChecklistProgressTableUpdateCompanionBuilder,
          (ChecklistProgressRow, $$ChecklistProgressTableReferences),
          ChecklistProgressRow,
          PrefetchHooks Function({bool jobId})
        > {
  $$ChecklistProgressTableTableManager(
    _$AppDatabase db,
    $ChecklistProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChecklistProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChecklistProgressTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> jobId = const Value.absent(),
                Value<String> surfaceId = const Value.absent(),
                Value<String> componentId = const Value.absent(),
                Value<String> completedStepIds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistProgressCompanion(
                jobId: jobId,
                surfaceId: surfaceId,
                componentId: componentId,
                completedStepIds: completedStepIds,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String jobId,
                required String surfaceId,
                required String componentId,
                required String completedStepIds,
                Value<int> rowid = const Value.absent(),
              }) => ChecklistProgressCompanion.insert(
                jobId: jobId,
                surfaceId: surfaceId,
                componentId: componentId,
                completedStepIds: completedStepIds,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ChecklistProgressTable, ChecklistProgressRow>(
                    table,
                  ),
                  $$ChecklistProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({jobId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (jobId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.jobId,
                                referencedTable:
                                    $$ChecklistProgressTableReferences
                                        ._jobIdTable(db),
                                referencedColumn:
                                    $$ChecklistProgressTableReferences
                                        ._jobIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChecklistProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChecklistProgressTable,
      ChecklistProgressRow,
      $$ChecklistProgressTableFilterComposer,
      $$ChecklistProgressTableOrderingComposer,
      $$ChecklistProgressTableAnnotationComposer,
      $$ChecklistProgressTableCreateCompanionBuilder,
      $$ChecklistProgressTableUpdateCompanionBuilder,
      (ChecklistProgressRow, $$ChecklistProgressTableReferences),
      ChecklistProgressRow,
      PrefetchHooks Function({bool jobId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$JobsTableTableManager get jobs => $$JobsTableTableManager(_db, _db.jobs);
  $$JobEntriesTableTableManager get jobEntries =>
      $$JobEntriesTableTableManager(_db, _db.jobEntries);
  $$ChecklistProgressTableTableManager get checklistProgress =>
      $$ChecklistProgressTableTableManager(_db, _db.checklistProgress);
}
