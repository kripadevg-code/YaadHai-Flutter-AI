// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StudentProfilesTable extends StudentProfiles with TableInfo<$StudentProfilesTable, StudentProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _examTargetMeta = const VerificationMeta('examTarget');
  @override
  late final GeneratedColumn<String> examTarget = GeneratedColumn<String>(
    'exam_target',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyGoalMinutesMeta = const VerificationMeta('dailyGoalMinutes');
  @override
  late final GeneratedColumn<int> dailyGoalMinutes = GeneratedColumn<int>(
    'daily_goal_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, email, avatarUrl, examTarget, dailyGoalMinutes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<StudentProfile> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(_emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta, avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    }
    if (data.containsKey('exam_target')) {
      context.handle(_examTargetMeta, examTarget.isAcceptableOrUnknown(data['exam_target']!, _examTargetMeta));
    }
    if (data.containsKey('daily_goal_minutes')) {
      context.handle(_dailyGoalMinutesMeta, dailyGoalMinutes.isAcceptableOrUnknown(data['daily_goal_minutes']!, _dailyGoalMinutesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentProfile(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}email']),
      avatarUrl: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}avatar_url']),
      examTarget: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}exam_target']),
      dailyGoalMinutes: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}daily_goal_minutes'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $StudentProfilesTable createAlias(String alias) {
    return $StudentProfilesTable(attachedDatabase, alias);
  }
}

class StudentProfile extends DataClass implements Insertable<StudentProfile> {
  final String id;
  final String name;
  final String? email;
  final String? avatarUrl;
  final String? examTarget;
  final int dailyGoalMinutes;
  final DateTime createdAt;
  const StudentProfile({
    required this.id,
    required this.name,
    this.email,
    this.avatarUrl,
    this.examTarget,
    required this.dailyGoalMinutes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || examTarget != null) {
      map['exam_target'] = Variable<String>(examTarget);
    }
    map['daily_goal_minutes'] = Variable<int>(dailyGoalMinutes);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StudentProfilesCompanion toCompanion(bool nullToAbsent) {
    return StudentProfilesCompanion(
      id: Value(id),
      name: Value(name),
      email: email == null && nullToAbsent ? const Value.absent() : Value(email),
      avatarUrl: avatarUrl == null && nullToAbsent ? const Value.absent() : Value(avatarUrl),
      examTarget: examTarget == null && nullToAbsent ? const Value.absent() : Value(examTarget),
      dailyGoalMinutes: Value(dailyGoalMinutes),
      createdAt: Value(createdAt),
    );
  }

  factory StudentProfile.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      examTarget: serializer.fromJson<String?>(json['examTarget']),
      dailyGoalMinutes: serializer.fromJson<int>(json['dailyGoalMinutes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'examTarget': serializer.toJson<String?>(examTarget),
      'dailyGoalMinutes': serializer.toJson<int>(dailyGoalMinutes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StudentProfile copyWith({
    String? id,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> examTarget = const Value.absent(),
    int? dailyGoalMinutes,
    DateTime? createdAt,
  }) => StudentProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    examTarget: examTarget.present ? examTarget.value : this.examTarget,
    dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
    createdAt: createdAt ?? this.createdAt,
  );
  StudentProfile copyWithCompanion(StudentProfilesCompanion data) {
    return StudentProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      examTarget: data.examTarget.present ? data.examTarget.value : this.examTarget,
      dailyGoalMinutes: data.dailyGoalMinutes.present ? data.dailyGoalMinutes.value : this.dailyGoalMinutes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('examTarget: $examTarget, ')
          ..write('dailyGoalMinutes: $dailyGoalMinutes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, avatarUrl, examTarget, dailyGoalMinutes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.avatarUrl == this.avatarUrl &&
          other.examTarget == this.examTarget &&
          other.dailyGoalMinutes == this.dailyGoalMinutes &&
          other.createdAt == this.createdAt);
}

class StudentProfilesCompanion extends UpdateCompanion<StudentProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> avatarUrl;
  final Value<String?> examTarget;
  final Value<int> dailyGoalMinutes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const StudentProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.examTarget = const Value.absent(),
    this.dailyGoalMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentProfilesCompanion.insert({
    required String id,
    required String name,
    this.email = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.examTarget = const Value.absent(),
    this.dailyGoalMinutes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<StudentProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? avatarUrl,
    Expression<String>? examTarget,
    Expression<int>? dailyGoalMinutes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (examTarget != null) 'exam_target': examTarget,
      if (dailyGoalMinutes != null) 'daily_goal_minutes': dailyGoalMinutes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? avatarUrl,
    Value<String?>? examTarget,
    Value<int>? dailyGoalMinutes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return StudentProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      examTarget: examTarget ?? this.examTarget,
      dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (examTarget.present) {
      map['exam_target'] = Variable<String>(examTarget.value);
    }
    if (dailyGoalMinutes.present) {
      map['daily_goal_minutes'] = Variable<int>(dailyGoalMinutes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('examTarget: $examTarget, ')
          ..write('dailyGoalMinutes: $dailyGoalMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorHexMeta = const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
    'color_hex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('6C5CE7'),
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta('iconName');
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('menu_book'),
  );
  static const VerificationMeta _totalChaptersMeta = const VerificationMeta('totalChapters');
  @override
  late final GeneratedColumn<int> totalChapters = GeneratedColumn<int>(
    'total_chapters',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, colorHex, iconName, totalChapters, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(Insertable<Subject> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta, colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    if (data.containsKey('icon_name')) {
      context.handle(_iconNameMeta, iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta));
    }
    if (data.containsKey('total_chapters')) {
      context.handle(_totalChaptersMeta, totalChapters.isAcceptableOrUnknown(data['total_chapters']!, _totalChaptersMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      colorHex: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
      iconName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}icon_name'])!,
      totalChapters: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}total_chapters'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  final String id;
  final String name;
  final String colorHex;
  final String iconName;
  final int totalChapters;
  final DateTime createdAt;
  const Subject({
    required this.id,
    required this.name,
    required this.colorHex,
    required this.iconName,
    required this.totalChapters,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color_hex'] = Variable<String>(colorHex);
    map['icon_name'] = Variable<String>(iconName);
    map['total_chapters'] = Variable<int>(totalChapters);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      name: Value(name),
      colorHex: Value(colorHex),
      iconName: Value(iconName),
      totalChapters: Value(totalChapters),
      createdAt: Value(createdAt),
    );
  }

  factory Subject.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      iconName: serializer.fromJson<String>(json['iconName']),
      totalChapters: serializer.fromJson<int>(json['totalChapters']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'colorHex': serializer.toJson<String>(colorHex),
      'iconName': serializer.toJson<String>(iconName),
      'totalChapters': serializer.toJson<int>(totalChapters),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Subject copyWith({String? id, String? name, String? colorHex, String? iconName, int? totalChapters, DateTime? createdAt}) => Subject(
    id: id ?? this.id,
    name: name ?? this.name,
    colorHex: colorHex ?? this.colorHex,
    iconName: iconName ?? this.iconName,
    totalChapters: totalChapters ?? this.totalChapters,
    createdAt: createdAt ?? this.createdAt,
  );
  Subject copyWithCompanion(SubjectsCompanion data) {
    return Subject(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      totalChapters: data.totalChapters.present ? data.totalChapters.value : this.totalChapters,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorHex: $colorHex, ')
          ..write('iconName: $iconName, ')
          ..write('totalChapters: $totalChapters, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, colorHex, iconName, totalChapters, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorHex == this.colorHex &&
          other.iconName == this.iconName &&
          other.totalChapters == this.totalChapters &&
          other.createdAt == this.createdAt);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> colorHex;
  final Value<String> iconName;
  final Value<int> totalChapters;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.iconName = const Value.absent(),
    this.totalChapters = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubjectsCompanion.insert({
    required String id,
    required String name,
    this.colorHex = const Value.absent(),
    this.iconName = const Value.absent(),
    this.totalChapters = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Subject> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? colorHex,
    Expression<String>? iconName,
    Expression<int>? totalChapters,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorHex != null) 'color_hex': colorHex,
      if (iconName != null) 'icon_name': iconName,
      if (totalChapters != null) 'total_chapters': totalChapters,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubjectsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? colorHex,
    Value<String>? iconName,
    Value<int>? totalChapters,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SubjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
      iconName: iconName ?? this.iconName,
      totalChapters: totalChapters ?? this.totalChapters,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (totalChapters.present) {
      map['total_chapters'] = Variable<int>(totalChapters.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorHex: $colorHex, ')
          ..write('iconName: $iconName, ')
          ..write('totalChapters: $totalChapters, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChaptersTable extends Chapters with TableInfo<$ChaptersTable, Chapter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChaptersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES subjects (id)'),
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
  static const VerificationMeta _descriptionMeta = const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _masteryLevelMeta = const VerificationMeta('masteryLevel');
  @override
  late final GeneratedColumn<int> masteryLevel = GeneratedColumn<int>(
    'mastery_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_completed" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastStudiedAtMeta = const VerificationMeta('lastStudiedAt');
  @override
  late final GeneratedColumn<DateTime> lastStudiedAt = GeneratedColumn<DateTime>(
    'last_studied_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectId,
    title,
    description,
    orderIndex,
    masteryLevel,
    isCompleted,
    lastStudiedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapters';
  @override
  VerificationContext validateIntegrity(Insertable<Chapter> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta, subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(_titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['description']!, _descriptionMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(_orderIndexMeta, orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta));
    }
    if (data.containsKey('mastery_level')) {
      context.handle(_masteryLevelMeta, masteryLevel.isAcceptableOrUnknown(data['mastery_level']!, _masteryLevelMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(_isCompletedMeta, isCompleted.isAcceptableOrUnknown(data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('last_studied_at')) {
      context.handle(_lastStudiedAtMeta, lastStudiedAt.isAcceptableOrUnknown(data['last_studied_at']!, _lastStudiedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chapter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chapter(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      subjectId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}subject_id'])!,
      title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}description']),
      orderIndex: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
      masteryLevel: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}mastery_level'])!,
      isCompleted: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      lastStudiedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}last_studied_at']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ChaptersTable createAlias(String alias) {
    return $ChaptersTable(attachedDatabase, alias);
  }
}

class Chapter extends DataClass implements Insertable<Chapter> {
  final String id;
  final String subjectId;
  final String title;
  final String? description;
  final int orderIndex;
  final int masteryLevel;
  final bool isCompleted;
  final DateTime? lastStudiedAt;
  final DateTime createdAt;
  const Chapter({
    required this.id,
    required this.subjectId,
    required this.title,
    this.description,
    required this.orderIndex,
    required this.masteryLevel,
    required this.isCompleted,
    this.lastStudiedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subject_id'] = Variable<String>(subjectId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['order_index'] = Variable<int>(orderIndex);
    map['mastery_level'] = Variable<int>(masteryLevel);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || lastStudiedAt != null) {
      map['last_studied_at'] = Variable<DateTime>(lastStudiedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ChaptersCompanion toCompanion(bool nullToAbsent) {
    return ChaptersCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      title: Value(title),
      description: description == null && nullToAbsent ? const Value.absent() : Value(description),
      orderIndex: Value(orderIndex),
      masteryLevel: Value(masteryLevel),
      isCompleted: Value(isCompleted),
      lastStudiedAt: lastStudiedAt == null && nullToAbsent ? const Value.absent() : Value(lastStudiedAt),
      createdAt: Value(createdAt),
    );
  }

  factory Chapter.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chapter(
      id: serializer.fromJson<String>(json['id']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      masteryLevel: serializer.fromJson<int>(json['masteryLevel']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      lastStudiedAt: serializer.fromJson<DateTime?>(json['lastStudiedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subjectId': serializer.toJson<String>(subjectId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'masteryLevel': serializer.toJson<int>(masteryLevel),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'lastStudiedAt': serializer.toJson<DateTime?>(lastStudiedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Chapter copyWith({
    String? id,
    String? subjectId,
    String? title,
    Value<String?> description = const Value.absent(),
    int? orderIndex,
    int? masteryLevel,
    bool? isCompleted,
    Value<DateTime?> lastStudiedAt = const Value.absent(),
    DateTime? createdAt,
  }) => Chapter(
    id: id ?? this.id,
    subjectId: subjectId ?? this.subjectId,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    orderIndex: orderIndex ?? this.orderIndex,
    masteryLevel: masteryLevel ?? this.masteryLevel,
    isCompleted: isCompleted ?? this.isCompleted,
    lastStudiedAt: lastStudiedAt.present ? lastStudiedAt.value : this.lastStudiedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Chapter copyWithCompanion(ChaptersCompanion data) {
    return Chapter(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present ? data.description.value : this.description,
      orderIndex: data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
      masteryLevel: data.masteryLevel.present ? data.masteryLevel.value : this.masteryLevel,
      isCompleted: data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      lastStudiedAt: data.lastStudiedAt.present ? data.lastStudiedAt.value : this.lastStudiedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chapter(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('masteryLevel: $masteryLevel, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('lastStudiedAt: $lastStudiedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, subjectId, title, description, orderIndex, masteryLevel, isCompleted, lastStudiedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chapter &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.title == this.title &&
          other.description == this.description &&
          other.orderIndex == this.orderIndex &&
          other.masteryLevel == this.masteryLevel &&
          other.isCompleted == this.isCompleted &&
          other.lastStudiedAt == this.lastStudiedAt &&
          other.createdAt == this.createdAt);
}

class ChaptersCompanion extends UpdateCompanion<Chapter> {
  final Value<String> id;
  final Value<String> subjectId;
  final Value<String> title;
  final Value<String?> description;
  final Value<int> orderIndex;
  final Value<int> masteryLevel;
  final Value<bool> isCompleted;
  final Value<DateTime?> lastStudiedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ChaptersCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.masteryLevel = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.lastStudiedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChaptersCompanion.insert({
    required String id,
    required String subjectId,
    required String title,
    this.description = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.masteryLevel = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.lastStudiedAt = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       subjectId = Value(subjectId),
       title = Value(title),
       createdAt = Value(createdAt);
  static Insertable<Chapter> custom({
    Expression<String>? id,
    Expression<String>? subjectId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? orderIndex,
    Expression<int>? masteryLevel,
    Expression<bool>? isCompleted,
    Expression<DateTime>? lastStudiedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (orderIndex != null) 'order_index': orderIndex,
      if (masteryLevel != null) 'mastery_level': masteryLevel,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (lastStudiedAt != null) 'last_studied_at': lastStudiedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChaptersCompanion copyWith({
    Value<String>? id,
    Value<String>? subjectId,
    Value<String>? title,
    Value<String?>? description,
    Value<int>? orderIndex,
    Value<int>? masteryLevel,
    Value<bool>? isCompleted,
    Value<DateTime?>? lastStudiedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ChaptersCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      description: description ?? this.description,
      orderIndex: orderIndex ?? this.orderIndex,
      masteryLevel: masteryLevel ?? this.masteryLevel,
      isCompleted: isCompleted ?? this.isCompleted,
      lastStudiedAt: lastStudiedAt ?? this.lastStudiedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (masteryLevel.present) {
      map['mastery_level'] = Variable<int>(masteryLevel.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (lastStudiedAt.present) {
      map['last_studied_at'] = Variable<DateTime>(lastStudiedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChaptersCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('masteryLevel: $masteryLevel, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('lastStudiedAt: $lastStudiedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConceptsTable extends Concepts with TableInfo<$ConceptsTable, Concept> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConceptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta('chapterId');
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES chapters (id)'),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES subjects (id)'),
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
  static const VerificationMeta _summaryMeta = const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailedExplanationMeta = const VerificationMeta('detailedExplanation');
  @override
  late final GeneratedColumn<String> detailedExplanation = GeneratedColumn<String>(
    'detailed_explanation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keyPointsMeta = const VerificationMeta('keyPoints');
  @override
  late final GeneratedColumn<String> keyPoints = GeneratedColumn<String>(
    'key_points',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relatedConceptIdsMeta = const VerificationMeta('relatedConceptIds');
  @override
  late final GeneratedColumn<String> relatedConceptIds = GeneratedColumn<String>(
    'related_concept_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _masteryLevelMeta = const VerificationMeta('masteryLevel');
  @override
  late final GeneratedColumn<int> masteryLevel = GeneratedColumn<int>(
    'mastery_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _importanceScoreMeta = const VerificationMeta('importanceScore');
  @override
  late final GeneratedColumn<int> importanceScore = GeneratedColumn<int>(
    'importance_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _isInterviewRelevantMeta = const VerificationMeta('isInterviewRelevant');
  @override
  late final GeneratedColumn<bool> isInterviewRelevant = GeneratedColumn<bool>(
    'is_interview_relevant',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_interview_relevant" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    chapterId,
    subjectId,
    title,
    summary,
    detailedExplanation,
    keyPoints,
    relatedConceptIds,
    tags,
    masteryLevel,
    importanceScore,
    isInterviewRelevant,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'concepts';
  @override
  VerificationContext validateIntegrity(Insertable<Concept> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(_chapterIdMeta, chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta));
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta, subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(_titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta, summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('detailed_explanation')) {
      context.handle(
        _detailedExplanationMeta,
        detailedExplanation.isAcceptableOrUnknown(data['detailed_explanation']!, _detailedExplanationMeta),
      );
    }
    if (data.containsKey('key_points')) {
      context.handle(_keyPointsMeta, keyPoints.isAcceptableOrUnknown(data['key_points']!, _keyPointsMeta));
    }
    if (data.containsKey('related_concept_ids')) {
      context.handle(_relatedConceptIdsMeta, relatedConceptIds.isAcceptableOrUnknown(data['related_concept_ids']!, _relatedConceptIdsMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(_tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('mastery_level')) {
      context.handle(_masteryLevelMeta, masteryLevel.isAcceptableOrUnknown(data['mastery_level']!, _masteryLevelMeta));
    }
    if (data.containsKey('importance_score')) {
      context.handle(_importanceScoreMeta, importanceScore.isAcceptableOrUnknown(data['importance_score']!, _importanceScoreMeta));
    }
    if (data.containsKey('is_interview_relevant')) {
      context.handle(
        _isInterviewRelevantMeta,
        isInterviewRelevant.isAcceptableOrUnknown(data['is_interview_relevant']!, _isInterviewRelevantMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Concept map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Concept(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      chapterId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}chapter_id'])!,
      subjectId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}subject_id'])!,
      title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      summary: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}summary'])!,
      detailedExplanation: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}detailed_explanation']),
      keyPoints: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}key_points']),
      relatedConceptIds: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}related_concept_ids']),
      tags: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}tags']),
      masteryLevel: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}mastery_level'])!,
      importanceScore: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}importance_score'])!,
      isInterviewRelevant: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_interview_relevant'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ConceptsTable createAlias(String alias) {
    return $ConceptsTable(attachedDatabase, alias);
  }
}

class Concept extends DataClass implements Insertable<Concept> {
  final String id;
  final String chapterId;
  final String subjectId;
  final String title;
  final String summary;
  final String? detailedExplanation;
  final String? keyPoints;
  final String? relatedConceptIds;
  final String? tags;
  final int masteryLevel;
  final int importanceScore;
  final bool isInterviewRelevant;
  final DateTime createdAt;
  const Concept({
    required this.id,
    required this.chapterId,
    required this.subjectId,
    required this.title,
    required this.summary,
    this.detailedExplanation,
    this.keyPoints,
    this.relatedConceptIds,
    this.tags,
    required this.masteryLevel,
    required this.importanceScore,
    required this.isInterviewRelevant,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['chapter_id'] = Variable<String>(chapterId);
    map['subject_id'] = Variable<String>(subjectId);
    map['title'] = Variable<String>(title);
    map['summary'] = Variable<String>(summary);
    if (!nullToAbsent || detailedExplanation != null) {
      map['detailed_explanation'] = Variable<String>(detailedExplanation);
    }
    if (!nullToAbsent || keyPoints != null) {
      map['key_points'] = Variable<String>(keyPoints);
    }
    if (!nullToAbsent || relatedConceptIds != null) {
      map['related_concept_ids'] = Variable<String>(relatedConceptIds);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['mastery_level'] = Variable<int>(masteryLevel);
    map['importance_score'] = Variable<int>(importanceScore);
    map['is_interview_relevant'] = Variable<bool>(isInterviewRelevant);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ConceptsCompanion toCompanion(bool nullToAbsent) {
    return ConceptsCompanion(
      id: Value(id),
      chapterId: Value(chapterId),
      subjectId: Value(subjectId),
      title: Value(title),
      summary: Value(summary),
      detailedExplanation: detailedExplanation == null && nullToAbsent ? const Value.absent() : Value(detailedExplanation),
      keyPoints: keyPoints == null && nullToAbsent ? const Value.absent() : Value(keyPoints),
      relatedConceptIds: relatedConceptIds == null && nullToAbsent ? const Value.absent() : Value(relatedConceptIds),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      masteryLevel: Value(masteryLevel),
      importanceScore: Value(importanceScore),
      isInterviewRelevant: Value(isInterviewRelevant),
      createdAt: Value(createdAt),
    );
  }

  factory Concept.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Concept(
      id: serializer.fromJson<String>(json['id']),
      chapterId: serializer.fromJson<String>(json['chapterId']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      title: serializer.fromJson<String>(json['title']),
      summary: serializer.fromJson<String>(json['summary']),
      detailedExplanation: serializer.fromJson<String?>(json['detailedExplanation']),
      keyPoints: serializer.fromJson<String?>(json['keyPoints']),
      relatedConceptIds: serializer.fromJson<String?>(json['relatedConceptIds']),
      tags: serializer.fromJson<String?>(json['tags']),
      masteryLevel: serializer.fromJson<int>(json['masteryLevel']),
      importanceScore: serializer.fromJson<int>(json['importanceScore']),
      isInterviewRelevant: serializer.fromJson<bool>(json['isInterviewRelevant']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'chapterId': serializer.toJson<String>(chapterId),
      'subjectId': serializer.toJson<String>(subjectId),
      'title': serializer.toJson<String>(title),
      'summary': serializer.toJson<String>(summary),
      'detailedExplanation': serializer.toJson<String?>(detailedExplanation),
      'keyPoints': serializer.toJson<String?>(keyPoints),
      'relatedConceptIds': serializer.toJson<String?>(relatedConceptIds),
      'tags': serializer.toJson<String?>(tags),
      'masteryLevel': serializer.toJson<int>(masteryLevel),
      'importanceScore': serializer.toJson<int>(importanceScore),
      'isInterviewRelevant': serializer.toJson<bool>(isInterviewRelevant),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Concept copyWith({
    String? id,
    String? chapterId,
    String? subjectId,
    String? title,
    String? summary,
    Value<String?> detailedExplanation = const Value.absent(),
    Value<String?> keyPoints = const Value.absent(),
    Value<String?> relatedConceptIds = const Value.absent(),
    Value<String?> tags = const Value.absent(),
    int? masteryLevel,
    int? importanceScore,
    bool? isInterviewRelevant,
    DateTime? createdAt,
  }) => Concept(
    id: id ?? this.id,
    chapterId: chapterId ?? this.chapterId,
    subjectId: subjectId ?? this.subjectId,
    title: title ?? this.title,
    summary: summary ?? this.summary,
    detailedExplanation: detailedExplanation.present ? detailedExplanation.value : this.detailedExplanation,
    keyPoints: keyPoints.present ? keyPoints.value : this.keyPoints,
    relatedConceptIds: relatedConceptIds.present ? relatedConceptIds.value : this.relatedConceptIds,
    tags: tags.present ? tags.value : this.tags,
    masteryLevel: masteryLevel ?? this.masteryLevel,
    importanceScore: importanceScore ?? this.importanceScore,
    isInterviewRelevant: isInterviewRelevant ?? this.isInterviewRelevant,
    createdAt: createdAt ?? this.createdAt,
  );
  Concept copyWithCompanion(ConceptsCompanion data) {
    return Concept(
      id: data.id.present ? data.id.value : this.id,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      title: data.title.present ? data.title.value : this.title,
      summary: data.summary.present ? data.summary.value : this.summary,
      detailedExplanation: data.detailedExplanation.present ? data.detailedExplanation.value : this.detailedExplanation,
      keyPoints: data.keyPoints.present ? data.keyPoints.value : this.keyPoints,
      relatedConceptIds: data.relatedConceptIds.present ? data.relatedConceptIds.value : this.relatedConceptIds,
      tags: data.tags.present ? data.tags.value : this.tags,
      masteryLevel: data.masteryLevel.present ? data.masteryLevel.value : this.masteryLevel,
      importanceScore: data.importanceScore.present ? data.importanceScore.value : this.importanceScore,
      isInterviewRelevant: data.isInterviewRelevant.present ? data.isInterviewRelevant.value : this.isInterviewRelevant,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Concept(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('detailedExplanation: $detailedExplanation, ')
          ..write('keyPoints: $keyPoints, ')
          ..write('relatedConceptIds: $relatedConceptIds, ')
          ..write('tags: $tags, ')
          ..write('masteryLevel: $masteryLevel, ')
          ..write('importanceScore: $importanceScore, ')
          ..write('isInterviewRelevant: $isInterviewRelevant, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    chapterId,
    subjectId,
    title,
    summary,
    detailedExplanation,
    keyPoints,
    relatedConceptIds,
    tags,
    masteryLevel,
    importanceScore,
    isInterviewRelevant,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Concept &&
          other.id == this.id &&
          other.chapterId == this.chapterId &&
          other.subjectId == this.subjectId &&
          other.title == this.title &&
          other.summary == this.summary &&
          other.detailedExplanation == this.detailedExplanation &&
          other.keyPoints == this.keyPoints &&
          other.relatedConceptIds == this.relatedConceptIds &&
          other.tags == this.tags &&
          other.masteryLevel == this.masteryLevel &&
          other.importanceScore == this.importanceScore &&
          other.isInterviewRelevant == this.isInterviewRelevant &&
          other.createdAt == this.createdAt);
}

class ConceptsCompanion extends UpdateCompanion<Concept> {
  final Value<String> id;
  final Value<String> chapterId;
  final Value<String> subjectId;
  final Value<String> title;
  final Value<String> summary;
  final Value<String?> detailedExplanation;
  final Value<String?> keyPoints;
  final Value<String?> relatedConceptIds;
  final Value<String?> tags;
  final Value<int> masteryLevel;
  final Value<int> importanceScore;
  final Value<bool> isInterviewRelevant;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ConceptsCompanion({
    this.id = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.title = const Value.absent(),
    this.summary = const Value.absent(),
    this.detailedExplanation = const Value.absent(),
    this.keyPoints = const Value.absent(),
    this.relatedConceptIds = const Value.absent(),
    this.tags = const Value.absent(),
    this.masteryLevel = const Value.absent(),
    this.importanceScore = const Value.absent(),
    this.isInterviewRelevant = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConceptsCompanion.insert({
    required String id,
    required String chapterId,
    required String subjectId,
    required String title,
    required String summary,
    this.detailedExplanation = const Value.absent(),
    this.keyPoints = const Value.absent(),
    this.relatedConceptIds = const Value.absent(),
    this.tags = const Value.absent(),
    this.masteryLevel = const Value.absent(),
    this.importanceScore = const Value.absent(),
    this.isInterviewRelevant = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       chapterId = Value(chapterId),
       subjectId = Value(subjectId),
       title = Value(title),
       summary = Value(summary),
       createdAt = Value(createdAt);
  static Insertable<Concept> custom({
    Expression<String>? id,
    Expression<String>? chapterId,
    Expression<String>? subjectId,
    Expression<String>? title,
    Expression<String>? summary,
    Expression<String>? detailedExplanation,
    Expression<String>? keyPoints,
    Expression<String>? relatedConceptIds,
    Expression<String>? tags,
    Expression<int>? masteryLevel,
    Expression<int>? importanceScore,
    Expression<bool>? isInterviewRelevant,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chapterId != null) 'chapter_id': chapterId,
      if (subjectId != null) 'subject_id': subjectId,
      if (title != null) 'title': title,
      if (summary != null) 'summary': summary,
      if (detailedExplanation != null) 'detailed_explanation': detailedExplanation,
      if (keyPoints != null) 'key_points': keyPoints,
      if (relatedConceptIds != null) 'related_concept_ids': relatedConceptIds,
      if (tags != null) 'tags': tags,
      if (masteryLevel != null) 'mastery_level': masteryLevel,
      if (importanceScore != null) 'importance_score': importanceScore,
      if (isInterviewRelevant != null) 'is_interview_relevant': isInterviewRelevant,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConceptsCompanion copyWith({
    Value<String>? id,
    Value<String>? chapterId,
    Value<String>? subjectId,
    Value<String>? title,
    Value<String>? summary,
    Value<String?>? detailedExplanation,
    Value<String?>? keyPoints,
    Value<String?>? relatedConceptIds,
    Value<String?>? tags,
    Value<int>? masteryLevel,
    Value<int>? importanceScore,
    Value<bool>? isInterviewRelevant,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ConceptsCompanion(
      id: id ?? this.id,
      chapterId: chapterId ?? this.chapterId,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      detailedExplanation: detailedExplanation ?? this.detailedExplanation,
      keyPoints: keyPoints ?? this.keyPoints,
      relatedConceptIds: relatedConceptIds ?? this.relatedConceptIds,
      tags: tags ?? this.tags,
      masteryLevel: masteryLevel ?? this.masteryLevel,
      importanceScore: importanceScore ?? this.importanceScore,
      isInterviewRelevant: isInterviewRelevant ?? this.isInterviewRelevant,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (detailedExplanation.present) {
      map['detailed_explanation'] = Variable<String>(detailedExplanation.value);
    }
    if (keyPoints.present) {
      map['key_points'] = Variable<String>(keyPoints.value);
    }
    if (relatedConceptIds.present) {
      map['related_concept_ids'] = Variable<String>(relatedConceptIds.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (masteryLevel.present) {
      map['mastery_level'] = Variable<int>(masteryLevel.value);
    }
    if (importanceScore.present) {
      map['importance_score'] = Variable<int>(importanceScore.value);
    }
    if (isInterviewRelevant.present) {
      map['is_interview_relevant'] = Variable<bool>(isInterviewRelevant.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConceptsCompanion(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('detailedExplanation: $detailedExplanation, ')
          ..write('keyPoints: $keyPoints, ')
          ..write('relatedConceptIds: $relatedConceptIds, ')
          ..write('tags: $tags, ')
          ..write('masteryLevel: $masteryLevel, ')
          ..write('importanceScore: $importanceScore, ')
          ..write('isInterviewRelevant: $isInterviewRelevant, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FlashcardsTable extends Flashcards with TableInfo<$FlashcardsTable, Flashcard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlashcardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conceptIdMeta = const VerificationMeta('conceptId');
  @override
  late final GeneratedColumn<String> conceptId = GeneratedColumn<String>(
    'concept_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES concepts (id)'),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta('chapterId');
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES chapters (id)'),
  );
  static const VerificationMeta _questionMeta = const VerificationMeta('question');
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
    'answer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hintMeta = const VerificationMeta('hint');
  @override
  late final GeneratedColumn<String> hint = GeneratedColumn<String>(
    'hint',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _masteryLevelMeta = const VerificationMeta('masteryLevel');
  @override
  late final GeneratedColumn<int> masteryLevel = GeneratedColumn<int>(
    'mastery_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastReviewedAtMeta = const VerificationMeta('lastReviewedAt');
  @override
  late final GeneratedColumn<DateTime> lastReviewedAt = GeneratedColumn<DateTime>(
    'last_reviewed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conceptId,
    chapterId,
    question,
    answer,
    hint,
    difficulty,
    masteryLevel,
    lastReviewedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flashcards';
  @override
  VerificationContext validateIntegrity(Insertable<Flashcard> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('concept_id')) {
      context.handle(_conceptIdMeta, conceptId.isAcceptableOrUnknown(data['concept_id']!, _conceptIdMeta));
    } else if (isInserting) {
      context.missing(_conceptIdMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(_chapterIdMeta, chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta));
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('question')) {
      context.handle(_questionMeta, question.isAcceptableOrUnknown(data['question']!, _questionMeta));
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('answer')) {
      context.handle(_answerMeta, answer.isAcceptableOrUnknown(data['answer']!, _answerMeta));
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    if (data.containsKey('hint')) {
      context.handle(_hintMeta, hint.isAcceptableOrUnknown(data['hint']!, _hintMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(_difficultyMeta, difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('mastery_level')) {
      context.handle(_masteryLevelMeta, masteryLevel.isAcceptableOrUnknown(data['mastery_level']!, _masteryLevelMeta));
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(_lastReviewedAtMeta, lastReviewedAt.isAcceptableOrUnknown(data['last_reviewed_at']!, _lastReviewedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Flashcard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Flashcard(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      conceptId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}concept_id'])!,
      chapterId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}chapter_id'])!,
      question: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}question'])!,
      answer: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}answer'])!,
      hint: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}hint']),
      difficulty: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}difficulty'])!,
      masteryLevel: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}mastery_level'])!,
      lastReviewedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}last_reviewed_at']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FlashcardsTable createAlias(String alias) {
    return $FlashcardsTable(attachedDatabase, alias);
  }
}

class Flashcard extends DataClass implements Insertable<Flashcard> {
  final String id;
  final String conceptId;
  final String chapterId;
  final String question;
  final String answer;
  final String? hint;
  final int difficulty;
  final int masteryLevel;
  final DateTime? lastReviewedAt;
  final DateTime createdAt;
  const Flashcard({
    required this.id,
    required this.conceptId,
    required this.chapterId,
    required this.question,
    required this.answer,
    this.hint,
    required this.difficulty,
    required this.masteryLevel,
    this.lastReviewedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['concept_id'] = Variable<String>(conceptId);
    map['chapter_id'] = Variable<String>(chapterId);
    map['question'] = Variable<String>(question);
    map['answer'] = Variable<String>(answer);
    if (!nullToAbsent || hint != null) {
      map['hint'] = Variable<String>(hint);
    }
    map['difficulty'] = Variable<int>(difficulty);
    map['mastery_level'] = Variable<int>(masteryLevel);
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FlashcardsCompanion toCompanion(bool nullToAbsent) {
    return FlashcardsCompanion(
      id: Value(id),
      conceptId: Value(conceptId),
      chapterId: Value(chapterId),
      question: Value(question),
      answer: Value(answer),
      hint: hint == null && nullToAbsent ? const Value.absent() : Value(hint),
      difficulty: Value(difficulty),
      masteryLevel: Value(masteryLevel),
      lastReviewedAt: lastReviewedAt == null && nullToAbsent ? const Value.absent() : Value(lastReviewedAt),
      createdAt: Value(createdAt),
    );
  }

  factory Flashcard.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Flashcard(
      id: serializer.fromJson<String>(json['id']),
      conceptId: serializer.fromJson<String>(json['conceptId']),
      chapterId: serializer.fromJson<String>(json['chapterId']),
      question: serializer.fromJson<String>(json['question']),
      answer: serializer.fromJson<String>(json['answer']),
      hint: serializer.fromJson<String?>(json['hint']),
      difficulty: serializer.fromJson<int>(json['difficulty']),
      masteryLevel: serializer.fromJson<int>(json['masteryLevel']),
      lastReviewedAt: serializer.fromJson<DateTime?>(json['lastReviewedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'conceptId': serializer.toJson<String>(conceptId),
      'chapterId': serializer.toJson<String>(chapterId),
      'question': serializer.toJson<String>(question),
      'answer': serializer.toJson<String>(answer),
      'hint': serializer.toJson<String?>(hint),
      'difficulty': serializer.toJson<int>(difficulty),
      'masteryLevel': serializer.toJson<int>(masteryLevel),
      'lastReviewedAt': serializer.toJson<DateTime?>(lastReviewedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Flashcard copyWith({
    String? id,
    String? conceptId,
    String? chapterId,
    String? question,
    String? answer,
    Value<String?> hint = const Value.absent(),
    int? difficulty,
    int? masteryLevel,
    Value<DateTime?> lastReviewedAt = const Value.absent(),
    DateTime? createdAt,
  }) => Flashcard(
    id: id ?? this.id,
    conceptId: conceptId ?? this.conceptId,
    chapterId: chapterId ?? this.chapterId,
    question: question ?? this.question,
    answer: answer ?? this.answer,
    hint: hint.present ? hint.value : this.hint,
    difficulty: difficulty ?? this.difficulty,
    masteryLevel: masteryLevel ?? this.masteryLevel,
    lastReviewedAt: lastReviewedAt.present ? lastReviewedAt.value : this.lastReviewedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Flashcard copyWithCompanion(FlashcardsCompanion data) {
    return Flashcard(
      id: data.id.present ? data.id.value : this.id,
      conceptId: data.conceptId.present ? data.conceptId.value : this.conceptId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      question: data.question.present ? data.question.value : this.question,
      answer: data.answer.present ? data.answer.value : this.answer,
      hint: data.hint.present ? data.hint.value : this.hint,
      difficulty: data.difficulty.present ? data.difficulty.value : this.difficulty,
      masteryLevel: data.masteryLevel.present ? data.masteryLevel.value : this.masteryLevel,
      lastReviewedAt: data.lastReviewedAt.present ? data.lastReviewedAt.value : this.lastReviewedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Flashcard(')
          ..write('id: $id, ')
          ..write('conceptId: $conceptId, ')
          ..write('chapterId: $chapterId, ')
          ..write('question: $question, ')
          ..write('answer: $answer, ')
          ..write('hint: $hint, ')
          ..write('difficulty: $difficulty, ')
          ..write('masteryLevel: $masteryLevel, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, conceptId, chapterId, question, answer, hint, difficulty, masteryLevel, lastReviewedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Flashcard &&
          other.id == this.id &&
          other.conceptId == this.conceptId &&
          other.chapterId == this.chapterId &&
          other.question == this.question &&
          other.answer == this.answer &&
          other.hint == this.hint &&
          other.difficulty == this.difficulty &&
          other.masteryLevel == this.masteryLevel &&
          other.lastReviewedAt == this.lastReviewedAt &&
          other.createdAt == this.createdAt);
}

class FlashcardsCompanion extends UpdateCompanion<Flashcard> {
  final Value<String> id;
  final Value<String> conceptId;
  final Value<String> chapterId;
  final Value<String> question;
  final Value<String> answer;
  final Value<String?> hint;
  final Value<int> difficulty;
  final Value<int> masteryLevel;
  final Value<DateTime?> lastReviewedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FlashcardsCompanion({
    this.id = const Value.absent(),
    this.conceptId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.question = const Value.absent(),
    this.answer = const Value.absent(),
    this.hint = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.masteryLevel = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FlashcardsCompanion.insert({
    required String id,
    required String conceptId,
    required String chapterId,
    required String question,
    required String answer,
    this.hint = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.masteryLevel = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       conceptId = Value(conceptId),
       chapterId = Value(chapterId),
       question = Value(question),
       answer = Value(answer),
       createdAt = Value(createdAt);
  static Insertable<Flashcard> custom({
    Expression<String>? id,
    Expression<String>? conceptId,
    Expression<String>? chapterId,
    Expression<String>? question,
    Expression<String>? answer,
    Expression<String>? hint,
    Expression<int>? difficulty,
    Expression<int>? masteryLevel,
    Expression<DateTime>? lastReviewedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conceptId != null) 'concept_id': conceptId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (question != null) 'question': question,
      if (answer != null) 'answer': answer,
      if (hint != null) 'hint': hint,
      if (difficulty != null) 'difficulty': difficulty,
      if (masteryLevel != null) 'mastery_level': masteryLevel,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FlashcardsCompanion copyWith({
    Value<String>? id,
    Value<String>? conceptId,
    Value<String>? chapterId,
    Value<String>? question,
    Value<String>? answer,
    Value<String?>? hint,
    Value<int>? difficulty,
    Value<int>? masteryLevel,
    Value<DateTime?>? lastReviewedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return FlashcardsCompanion(
      id: id ?? this.id,
      conceptId: conceptId ?? this.conceptId,
      chapterId: chapterId ?? this.chapterId,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      hint: hint ?? this.hint,
      difficulty: difficulty ?? this.difficulty,
      masteryLevel: masteryLevel ?? this.masteryLevel,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (conceptId.present) {
      map['concept_id'] = Variable<String>(conceptId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (hint.present) {
      map['hint'] = Variable<String>(hint.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (masteryLevel.present) {
      map['mastery_level'] = Variable<int>(masteryLevel.value);
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardsCompanion(')
          ..write('id: $id, ')
          ..write('conceptId: $conceptId, ')
          ..write('chapterId: $chapterId, ')
          ..write('question: $question, ')
          ..write('answer: $answer, ')
          ..write('hint: $hint, ')
          ..write('difficulty: $difficulty, ')
          ..write('masteryLevel: $masteryLevel, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuizQuestionsTable extends QuizQuestions with TableInfo<$QuizQuestionsTable, QuizQuestion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizQuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conceptIdMeta = const VerificationMeta('conceptId');
  @override
  late final GeneratedColumn<String> conceptId = GeneratedColumn<String>(
    'concept_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES concepts (id)'),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta('chapterId');
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES chapters (id)'),
  );
  static const VerificationMeta _questionMeta = const VerificationMeta('question');
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _optionAMeta = const VerificationMeta('optionA');
  @override
  late final GeneratedColumn<String> optionA = GeneratedColumn<String>(
    'option_a',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _optionBMeta = const VerificationMeta('optionB');
  @override
  late final GeneratedColumn<String> optionB = GeneratedColumn<String>(
    'option_b',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _optionCMeta = const VerificationMeta('optionC');
  @override
  late final GeneratedColumn<String> optionC = GeneratedColumn<String>(
    'option_c',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _optionDMeta = const VerificationMeta('optionD');
  @override
  late final GeneratedColumn<String> optionD = GeneratedColumn<String>(
    'option_d',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctOptionMeta = const VerificationMeta('correctOption');
  @override
  late final GeneratedColumn<String> correctOption = GeneratedColumn<String>(
    'correct_option',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _explanationMeta = const VerificationMeta('explanation');
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conceptId,
    chapterId,
    question,
    optionA,
    optionB,
    optionC,
    optionD,
    correctOption,
    explanation,
    difficulty,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz_questions';
  @override
  VerificationContext validateIntegrity(Insertable<QuizQuestion> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('concept_id')) {
      context.handle(_conceptIdMeta, conceptId.isAcceptableOrUnknown(data['concept_id']!, _conceptIdMeta));
    } else if (isInserting) {
      context.missing(_conceptIdMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(_chapterIdMeta, chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta));
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('question')) {
      context.handle(_questionMeta, question.isAcceptableOrUnknown(data['question']!, _questionMeta));
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('option_a')) {
      context.handle(_optionAMeta, optionA.isAcceptableOrUnknown(data['option_a']!, _optionAMeta));
    } else if (isInserting) {
      context.missing(_optionAMeta);
    }
    if (data.containsKey('option_b')) {
      context.handle(_optionBMeta, optionB.isAcceptableOrUnknown(data['option_b']!, _optionBMeta));
    } else if (isInserting) {
      context.missing(_optionBMeta);
    }
    if (data.containsKey('option_c')) {
      context.handle(_optionCMeta, optionC.isAcceptableOrUnknown(data['option_c']!, _optionCMeta));
    } else if (isInserting) {
      context.missing(_optionCMeta);
    }
    if (data.containsKey('option_d')) {
      context.handle(_optionDMeta, optionD.isAcceptableOrUnknown(data['option_d']!, _optionDMeta));
    } else if (isInserting) {
      context.missing(_optionDMeta);
    }
    if (data.containsKey('correct_option')) {
      context.handle(_correctOptionMeta, correctOption.isAcceptableOrUnknown(data['correct_option']!, _correctOptionMeta));
    } else if (isInserting) {
      context.missing(_correctOptionMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(_explanationMeta, explanation.isAcceptableOrUnknown(data['explanation']!, _explanationMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(_difficultyMeta, difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizQuestion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizQuestion(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      conceptId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}concept_id'])!,
      chapterId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}chapter_id'])!,
      question: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}question'])!,
      optionA: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}option_a'])!,
      optionB: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}option_b'])!,
      optionC: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}option_c'])!,
      optionD: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}option_d'])!,
      correctOption: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}correct_option'])!,
      explanation: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}explanation']),
      difficulty: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}difficulty'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $QuizQuestionsTable createAlias(String alias) {
    return $QuizQuestionsTable(attachedDatabase, alias);
  }
}

class QuizQuestion extends DataClass implements Insertable<QuizQuestion> {
  final String id;
  final String conceptId;
  final String chapterId;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correctOption;
  final String? explanation;
  final int difficulty;
  final DateTime createdAt;
  const QuizQuestion({
    required this.id,
    required this.conceptId,
    required this.chapterId,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctOption,
    this.explanation,
    required this.difficulty,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['concept_id'] = Variable<String>(conceptId);
    map['chapter_id'] = Variable<String>(chapterId);
    map['question'] = Variable<String>(question);
    map['option_a'] = Variable<String>(optionA);
    map['option_b'] = Variable<String>(optionB);
    map['option_c'] = Variable<String>(optionC);
    map['option_d'] = Variable<String>(optionD);
    map['correct_option'] = Variable<String>(correctOption);
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    map['difficulty'] = Variable<int>(difficulty);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  QuizQuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuizQuestionsCompanion(
      id: Value(id),
      conceptId: Value(conceptId),
      chapterId: Value(chapterId),
      question: Value(question),
      optionA: Value(optionA),
      optionB: Value(optionB),
      optionC: Value(optionC),
      optionD: Value(optionD),
      correctOption: Value(correctOption),
      explanation: explanation == null && nullToAbsent ? const Value.absent() : Value(explanation),
      difficulty: Value(difficulty),
      createdAt: Value(createdAt),
    );
  }

  factory QuizQuestion.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizQuestion(
      id: serializer.fromJson<String>(json['id']),
      conceptId: serializer.fromJson<String>(json['conceptId']),
      chapterId: serializer.fromJson<String>(json['chapterId']),
      question: serializer.fromJson<String>(json['question']),
      optionA: serializer.fromJson<String>(json['optionA']),
      optionB: serializer.fromJson<String>(json['optionB']),
      optionC: serializer.fromJson<String>(json['optionC']),
      optionD: serializer.fromJson<String>(json['optionD']),
      correctOption: serializer.fromJson<String>(json['correctOption']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      difficulty: serializer.fromJson<int>(json['difficulty']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'conceptId': serializer.toJson<String>(conceptId),
      'chapterId': serializer.toJson<String>(chapterId),
      'question': serializer.toJson<String>(question),
      'optionA': serializer.toJson<String>(optionA),
      'optionB': serializer.toJson<String>(optionB),
      'optionC': serializer.toJson<String>(optionC),
      'optionD': serializer.toJson<String>(optionD),
      'correctOption': serializer.toJson<String>(correctOption),
      'explanation': serializer.toJson<String?>(explanation),
      'difficulty': serializer.toJson<int>(difficulty),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  QuizQuestion copyWith({
    String? id,
    String? conceptId,
    String? chapterId,
    String? question,
    String? optionA,
    String? optionB,
    String? optionC,
    String? optionD,
    String? correctOption,
    Value<String?> explanation = const Value.absent(),
    int? difficulty,
    DateTime? createdAt,
  }) => QuizQuestion(
    id: id ?? this.id,
    conceptId: conceptId ?? this.conceptId,
    chapterId: chapterId ?? this.chapterId,
    question: question ?? this.question,
    optionA: optionA ?? this.optionA,
    optionB: optionB ?? this.optionB,
    optionC: optionC ?? this.optionC,
    optionD: optionD ?? this.optionD,
    correctOption: correctOption ?? this.correctOption,
    explanation: explanation.present ? explanation.value : this.explanation,
    difficulty: difficulty ?? this.difficulty,
    createdAt: createdAt ?? this.createdAt,
  );
  QuizQuestion copyWithCompanion(QuizQuestionsCompanion data) {
    return QuizQuestion(
      id: data.id.present ? data.id.value : this.id,
      conceptId: data.conceptId.present ? data.conceptId.value : this.conceptId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      question: data.question.present ? data.question.value : this.question,
      optionA: data.optionA.present ? data.optionA.value : this.optionA,
      optionB: data.optionB.present ? data.optionB.value : this.optionB,
      optionC: data.optionC.present ? data.optionC.value : this.optionC,
      optionD: data.optionD.present ? data.optionD.value : this.optionD,
      correctOption: data.correctOption.present ? data.correctOption.value : this.correctOption,
      explanation: data.explanation.present ? data.explanation.value : this.explanation,
      difficulty: data.difficulty.present ? data.difficulty.value : this.difficulty,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizQuestion(')
          ..write('id: $id, ')
          ..write('conceptId: $conceptId, ')
          ..write('chapterId: $chapterId, ')
          ..write('question: $question, ')
          ..write('optionA: $optionA, ')
          ..write('optionB: $optionB, ')
          ..write('optionC: $optionC, ')
          ..write('optionD: $optionD, ')
          ..write('correctOption: $correctOption, ')
          ..write('explanation: $explanation, ')
          ..write('difficulty: $difficulty, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    conceptId,
    chapterId,
    question,
    optionA,
    optionB,
    optionC,
    optionD,
    correctOption,
    explanation,
    difficulty,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizQuestion &&
          other.id == this.id &&
          other.conceptId == this.conceptId &&
          other.chapterId == this.chapterId &&
          other.question == this.question &&
          other.optionA == this.optionA &&
          other.optionB == this.optionB &&
          other.optionC == this.optionC &&
          other.optionD == this.optionD &&
          other.correctOption == this.correctOption &&
          other.explanation == this.explanation &&
          other.difficulty == this.difficulty &&
          other.createdAt == this.createdAt);
}

class QuizQuestionsCompanion extends UpdateCompanion<QuizQuestion> {
  final Value<String> id;
  final Value<String> conceptId;
  final Value<String> chapterId;
  final Value<String> question;
  final Value<String> optionA;
  final Value<String> optionB;
  final Value<String> optionC;
  final Value<String> optionD;
  final Value<String> correctOption;
  final Value<String?> explanation;
  final Value<int> difficulty;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const QuizQuestionsCompanion({
    this.id = const Value.absent(),
    this.conceptId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.question = const Value.absent(),
    this.optionA = const Value.absent(),
    this.optionB = const Value.absent(),
    this.optionC = const Value.absent(),
    this.optionD = const Value.absent(),
    this.correctOption = const Value.absent(),
    this.explanation = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuizQuestionsCompanion.insert({
    required String id,
    required String conceptId,
    required String chapterId,
    required String question,
    required String optionA,
    required String optionB,
    required String optionC,
    required String optionD,
    required String correctOption,
    this.explanation = const Value.absent(),
    this.difficulty = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       conceptId = Value(conceptId),
       chapterId = Value(chapterId),
       question = Value(question),
       optionA = Value(optionA),
       optionB = Value(optionB),
       optionC = Value(optionC),
       optionD = Value(optionD),
       correctOption = Value(correctOption),
       createdAt = Value(createdAt);
  static Insertable<QuizQuestion> custom({
    Expression<String>? id,
    Expression<String>? conceptId,
    Expression<String>? chapterId,
    Expression<String>? question,
    Expression<String>? optionA,
    Expression<String>? optionB,
    Expression<String>? optionC,
    Expression<String>? optionD,
    Expression<String>? correctOption,
    Expression<String>? explanation,
    Expression<int>? difficulty,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conceptId != null) 'concept_id': conceptId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (question != null) 'question': question,
      if (optionA != null) 'option_a': optionA,
      if (optionB != null) 'option_b': optionB,
      if (optionC != null) 'option_c': optionC,
      if (optionD != null) 'option_d': optionD,
      if (correctOption != null) 'correct_option': correctOption,
      if (explanation != null) 'explanation': explanation,
      if (difficulty != null) 'difficulty': difficulty,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuizQuestionsCompanion copyWith({
    Value<String>? id,
    Value<String>? conceptId,
    Value<String>? chapterId,
    Value<String>? question,
    Value<String>? optionA,
    Value<String>? optionB,
    Value<String>? optionC,
    Value<String>? optionD,
    Value<String>? correctOption,
    Value<String?>? explanation,
    Value<int>? difficulty,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return QuizQuestionsCompanion(
      id: id ?? this.id,
      conceptId: conceptId ?? this.conceptId,
      chapterId: chapterId ?? this.chapterId,
      question: question ?? this.question,
      optionA: optionA ?? this.optionA,
      optionB: optionB ?? this.optionB,
      optionC: optionC ?? this.optionC,
      optionD: optionD ?? this.optionD,
      correctOption: correctOption ?? this.correctOption,
      explanation: explanation ?? this.explanation,
      difficulty: difficulty ?? this.difficulty,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (conceptId.present) {
      map['concept_id'] = Variable<String>(conceptId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (optionA.present) {
      map['option_a'] = Variable<String>(optionA.value);
    }
    if (optionB.present) {
      map['option_b'] = Variable<String>(optionB.value);
    }
    if (optionC.present) {
      map['option_c'] = Variable<String>(optionC.value);
    }
    if (optionD.present) {
      map['option_d'] = Variable<String>(optionD.value);
    }
    if (correctOption.present) {
      map['correct_option'] = Variable<String>(correctOption.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizQuestionsCompanion(')
          ..write('id: $id, ')
          ..write('conceptId: $conceptId, ')
          ..write('chapterId: $chapterId, ')
          ..write('question: $question, ')
          ..write('optionA: $optionA, ')
          ..write('optionB: $optionB, ')
          ..write('optionC: $optionC, ')
          ..write('optionD: $optionD, ')
          ..write('correctOption: $correctOption, ')
          ..write('explanation: $explanation, ')
          ..write('difficulty: $difficulty, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuizAttemptsTable extends QuizAttempts with TableInfo<$QuizAttemptsTable, QuizAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta('chapterId');
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES chapters (id)'),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES subjects (id)'),
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalQuestionsMeta = const VerificationMeta('totalQuestions');
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
    'total_questions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeTakenSecondsMeta = const VerificationMeta('timeTakenSeconds');
  @override
  late final GeneratedColumn<int> timeTakenSeconds = GeneratedColumn<int>(
    'time_taken_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _wrongConceptIdsMeta = const VerificationMeta('wrongConceptIds');
  @override
  late final GeneratedColumn<String> wrongConceptIds = GeneratedColumn<String>(
    'wrong_concept_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attemptedAtMeta = const VerificationMeta('attemptedAt');
  @override
  late final GeneratedColumn<DateTime> attemptedAt = GeneratedColumn<DateTime>(
    'attempted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, chapterId, subjectId, score, totalQuestions, timeTakenSeconds, wrongConceptIds, attemptedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz_attempts';
  @override
  VerificationContext validateIntegrity(Insertable<QuizAttempt> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(_chapterIdMeta, chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta));
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta, subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(_scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('total_questions')) {
      context.handle(_totalQuestionsMeta, totalQuestions.isAcceptableOrUnknown(data['total_questions']!, _totalQuestionsMeta));
    } else if (isInserting) {
      context.missing(_totalQuestionsMeta);
    }
    if (data.containsKey('time_taken_seconds')) {
      context.handle(_timeTakenSecondsMeta, timeTakenSeconds.isAcceptableOrUnknown(data['time_taken_seconds']!, _timeTakenSecondsMeta));
    }
    if (data.containsKey('wrong_concept_ids')) {
      context.handle(_wrongConceptIdsMeta, wrongConceptIds.isAcceptableOrUnknown(data['wrong_concept_ids']!, _wrongConceptIdsMeta));
    }
    if (data.containsKey('attempted_at')) {
      context.handle(_attemptedAtMeta, attemptedAt.isAcceptableOrUnknown(data['attempted_at']!, _attemptedAtMeta));
    } else if (isInserting) {
      context.missing(_attemptedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizAttempt(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      chapterId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}chapter_id'])!,
      subjectId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}subject_id'])!,
      score: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}score'])!,
      totalQuestions: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}total_questions'])!,
      timeTakenSeconds: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}time_taken_seconds'])!,
      wrongConceptIds: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}wrong_concept_ids']),
      attemptedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}attempted_at'])!,
    );
  }

  @override
  $QuizAttemptsTable createAlias(String alias) {
    return $QuizAttemptsTable(attachedDatabase, alias);
  }
}

class QuizAttempt extends DataClass implements Insertable<QuizAttempt> {
  final String id;
  final String chapterId;
  final String subjectId;
  final int score;
  final int totalQuestions;
  final int timeTakenSeconds;
  final String? wrongConceptIds;
  final DateTime attemptedAt;
  const QuizAttempt({
    required this.id,
    required this.chapterId,
    required this.subjectId,
    required this.score,
    required this.totalQuestions,
    required this.timeTakenSeconds,
    this.wrongConceptIds,
    required this.attemptedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['chapter_id'] = Variable<String>(chapterId);
    map['subject_id'] = Variable<String>(subjectId);
    map['score'] = Variable<int>(score);
    map['total_questions'] = Variable<int>(totalQuestions);
    map['time_taken_seconds'] = Variable<int>(timeTakenSeconds);
    if (!nullToAbsent || wrongConceptIds != null) {
      map['wrong_concept_ids'] = Variable<String>(wrongConceptIds);
    }
    map['attempted_at'] = Variable<DateTime>(attemptedAt);
    return map;
  }

  QuizAttemptsCompanion toCompanion(bool nullToAbsent) {
    return QuizAttemptsCompanion(
      id: Value(id),
      chapterId: Value(chapterId),
      subjectId: Value(subjectId),
      score: Value(score),
      totalQuestions: Value(totalQuestions),
      timeTakenSeconds: Value(timeTakenSeconds),
      wrongConceptIds: wrongConceptIds == null && nullToAbsent ? const Value.absent() : Value(wrongConceptIds),
      attemptedAt: Value(attemptedAt),
    );
  }

  factory QuizAttempt.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizAttempt(
      id: serializer.fromJson<String>(json['id']),
      chapterId: serializer.fromJson<String>(json['chapterId']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      score: serializer.fromJson<int>(json['score']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      timeTakenSeconds: serializer.fromJson<int>(json['timeTakenSeconds']),
      wrongConceptIds: serializer.fromJson<String?>(json['wrongConceptIds']),
      attemptedAt: serializer.fromJson<DateTime>(json['attemptedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'chapterId': serializer.toJson<String>(chapterId),
      'subjectId': serializer.toJson<String>(subjectId),
      'score': serializer.toJson<int>(score),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'timeTakenSeconds': serializer.toJson<int>(timeTakenSeconds),
      'wrongConceptIds': serializer.toJson<String?>(wrongConceptIds),
      'attemptedAt': serializer.toJson<DateTime>(attemptedAt),
    };
  }

  QuizAttempt copyWith({
    String? id,
    String? chapterId,
    String? subjectId,
    int? score,
    int? totalQuestions,
    int? timeTakenSeconds,
    Value<String?> wrongConceptIds = const Value.absent(),
    DateTime? attemptedAt,
  }) => QuizAttempt(
    id: id ?? this.id,
    chapterId: chapterId ?? this.chapterId,
    subjectId: subjectId ?? this.subjectId,
    score: score ?? this.score,
    totalQuestions: totalQuestions ?? this.totalQuestions,
    timeTakenSeconds: timeTakenSeconds ?? this.timeTakenSeconds,
    wrongConceptIds: wrongConceptIds.present ? wrongConceptIds.value : this.wrongConceptIds,
    attemptedAt: attemptedAt ?? this.attemptedAt,
  );
  QuizAttempt copyWithCompanion(QuizAttemptsCompanion data) {
    return QuizAttempt(
      id: data.id.present ? data.id.value : this.id,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      score: data.score.present ? data.score.value : this.score,
      totalQuestions: data.totalQuestions.present ? data.totalQuestions.value : this.totalQuestions,
      timeTakenSeconds: data.timeTakenSeconds.present ? data.timeTakenSeconds.value : this.timeTakenSeconds,
      wrongConceptIds: data.wrongConceptIds.present ? data.wrongConceptIds.value : this.wrongConceptIds,
      attemptedAt: data.attemptedAt.present ? data.attemptedAt.value : this.attemptedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizAttempt(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('subjectId: $subjectId, ')
          ..write('score: $score, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('timeTakenSeconds: $timeTakenSeconds, ')
          ..write('wrongConceptIds: $wrongConceptIds, ')
          ..write('attemptedAt: $attemptedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, chapterId, subjectId, score, totalQuestions, timeTakenSeconds, wrongConceptIds, attemptedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizAttempt &&
          other.id == this.id &&
          other.chapterId == this.chapterId &&
          other.subjectId == this.subjectId &&
          other.score == this.score &&
          other.totalQuestions == this.totalQuestions &&
          other.timeTakenSeconds == this.timeTakenSeconds &&
          other.wrongConceptIds == this.wrongConceptIds &&
          other.attemptedAt == this.attemptedAt);
}

class QuizAttemptsCompanion extends UpdateCompanion<QuizAttempt> {
  final Value<String> id;
  final Value<String> chapterId;
  final Value<String> subjectId;
  final Value<int> score;
  final Value<int> totalQuestions;
  final Value<int> timeTakenSeconds;
  final Value<String?> wrongConceptIds;
  final Value<DateTime> attemptedAt;
  final Value<int> rowid;
  const QuizAttemptsCompanion({
    this.id = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.score = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.timeTakenSeconds = const Value.absent(),
    this.wrongConceptIds = const Value.absent(),
    this.attemptedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuizAttemptsCompanion.insert({
    required String id,
    required String chapterId,
    required String subjectId,
    required int score,
    required int totalQuestions,
    this.timeTakenSeconds = const Value.absent(),
    this.wrongConceptIds = const Value.absent(),
    required DateTime attemptedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       chapterId = Value(chapterId),
       subjectId = Value(subjectId),
       score = Value(score),
       totalQuestions = Value(totalQuestions),
       attemptedAt = Value(attemptedAt);
  static Insertable<QuizAttempt> custom({
    Expression<String>? id,
    Expression<String>? chapterId,
    Expression<String>? subjectId,
    Expression<int>? score,
    Expression<int>? totalQuestions,
    Expression<int>? timeTakenSeconds,
    Expression<String>? wrongConceptIds,
    Expression<DateTime>? attemptedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chapterId != null) 'chapter_id': chapterId,
      if (subjectId != null) 'subject_id': subjectId,
      if (score != null) 'score': score,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (timeTakenSeconds != null) 'time_taken_seconds': timeTakenSeconds,
      if (wrongConceptIds != null) 'wrong_concept_ids': wrongConceptIds,
      if (attemptedAt != null) 'attempted_at': attemptedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuizAttemptsCompanion copyWith({
    Value<String>? id,
    Value<String>? chapterId,
    Value<String>? subjectId,
    Value<int>? score,
    Value<int>? totalQuestions,
    Value<int>? timeTakenSeconds,
    Value<String?>? wrongConceptIds,
    Value<DateTime>? attemptedAt,
    Value<int>? rowid,
  }) {
    return QuizAttemptsCompanion(
      id: id ?? this.id,
      chapterId: chapterId ?? this.chapterId,
      subjectId: subjectId ?? this.subjectId,
      score: score ?? this.score,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      timeTakenSeconds: timeTakenSeconds ?? this.timeTakenSeconds,
      wrongConceptIds: wrongConceptIds ?? this.wrongConceptIds,
      attemptedAt: attemptedAt ?? this.attemptedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (timeTakenSeconds.present) {
      map['time_taken_seconds'] = Variable<int>(timeTakenSeconds.value);
    }
    if (wrongConceptIds.present) {
      map['wrong_concept_ids'] = Variable<String>(wrongConceptIds.value);
    }
    if (attemptedAt.present) {
      map['attempted_at'] = Variable<DateTime>(attemptedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('subjectId: $subjectId, ')
          ..write('score: $score, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('timeTakenSeconds: $timeTakenSeconds, ')
          ..write('wrongConceptIds: $wrongConceptIds, ')
          ..write('attemptedAt: $attemptedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RevisionsTable extends Revisions with TableInfo<$RevisionsTable, Revision> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RevisionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conceptIdMeta = const VerificationMeta('conceptId');
  @override
  late final GeneratedColumn<String> conceptId = GeneratedColumn<String>(
    'concept_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES concepts (id)'),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta('chapterId');
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES chapters (id)'),
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta('intervalDays');
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _easeFactorMeta = const VerificationMeta('easeFactor');
  @override
  late final GeneratedColumn<int> easeFactor = GeneratedColumn<int>(
    'ease_factor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(250),
  );
  static const VerificationMeta _repetitionsMeta = const VerificationMeta('repetitions');
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
    'repetitions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextRevisionAtMeta = const VerificationMeta('nextRevisionAt');
  @override
  late final GeneratedColumn<DateTime> nextRevisionAt = GeneratedColumn<DateTime>(
    'next_revision_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastRevisedAtMeta = const VerificationMeta('lastRevisedAt');
  @override
  late final GeneratedColumn<DateTime> lastRevisedAt = GeneratedColumn<DateTime>(
    'last_revised_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, conceptId, chapterId, intervalDays, easeFactor, repetitions, nextRevisionAt, lastRevisedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'revisions';
  @override
  VerificationContext validateIntegrity(Insertable<Revision> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('concept_id')) {
      context.handle(_conceptIdMeta, conceptId.isAcceptableOrUnknown(data['concept_id']!, _conceptIdMeta));
    } else if (isInserting) {
      context.missing(_conceptIdMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(_chapterIdMeta, chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta));
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('interval_days')) {
      context.handle(_intervalDaysMeta, intervalDays.isAcceptableOrUnknown(data['interval_days']!, _intervalDaysMeta));
    }
    if (data.containsKey('ease_factor')) {
      context.handle(_easeFactorMeta, easeFactor.isAcceptableOrUnknown(data['ease_factor']!, _easeFactorMeta));
    }
    if (data.containsKey('repetitions')) {
      context.handle(_repetitionsMeta, repetitions.isAcceptableOrUnknown(data['repetitions']!, _repetitionsMeta));
    }
    if (data.containsKey('next_revision_at')) {
      context.handle(_nextRevisionAtMeta, nextRevisionAt.isAcceptableOrUnknown(data['next_revision_at']!, _nextRevisionAtMeta));
    } else if (isInserting) {
      context.missing(_nextRevisionAtMeta);
    }
    if (data.containsKey('last_revised_at')) {
      context.handle(_lastRevisedAtMeta, lastRevisedAt.isAcceptableOrUnknown(data['last_revised_at']!, _lastRevisedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Revision map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Revision(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      conceptId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}concept_id'])!,
      chapterId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}chapter_id'])!,
      intervalDays: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}interval_days'])!,
      easeFactor: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}ease_factor'])!,
      repetitions: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}repetitions'])!,
      nextRevisionAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}next_revision_at'])!,
      lastRevisedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}last_revised_at']),
    );
  }

  @override
  $RevisionsTable createAlias(String alias) {
    return $RevisionsTable(attachedDatabase, alias);
  }
}

class Revision extends DataClass implements Insertable<Revision> {
  final String id;
  final String conceptId;
  final String chapterId;
  final int intervalDays;
  final int easeFactor;
  final int repetitions;
  final DateTime nextRevisionAt;
  final DateTime? lastRevisedAt;
  const Revision({
    required this.id,
    required this.conceptId,
    required this.chapterId,
    required this.intervalDays,
    required this.easeFactor,
    required this.repetitions,
    required this.nextRevisionAt,
    this.lastRevisedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['concept_id'] = Variable<String>(conceptId);
    map['chapter_id'] = Variable<String>(chapterId);
    map['interval_days'] = Variable<int>(intervalDays);
    map['ease_factor'] = Variable<int>(easeFactor);
    map['repetitions'] = Variable<int>(repetitions);
    map['next_revision_at'] = Variable<DateTime>(nextRevisionAt);
    if (!nullToAbsent || lastRevisedAt != null) {
      map['last_revised_at'] = Variable<DateTime>(lastRevisedAt);
    }
    return map;
  }

  RevisionsCompanion toCompanion(bool nullToAbsent) {
    return RevisionsCompanion(
      id: Value(id),
      conceptId: Value(conceptId),
      chapterId: Value(chapterId),
      intervalDays: Value(intervalDays),
      easeFactor: Value(easeFactor),
      repetitions: Value(repetitions),
      nextRevisionAt: Value(nextRevisionAt),
      lastRevisedAt: lastRevisedAt == null && nullToAbsent ? const Value.absent() : Value(lastRevisedAt),
    );
  }

  factory Revision.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Revision(
      id: serializer.fromJson<String>(json['id']),
      conceptId: serializer.fromJson<String>(json['conceptId']),
      chapterId: serializer.fromJson<String>(json['chapterId']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      easeFactor: serializer.fromJson<int>(json['easeFactor']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      nextRevisionAt: serializer.fromJson<DateTime>(json['nextRevisionAt']),
      lastRevisedAt: serializer.fromJson<DateTime?>(json['lastRevisedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'conceptId': serializer.toJson<String>(conceptId),
      'chapterId': serializer.toJson<String>(chapterId),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'easeFactor': serializer.toJson<int>(easeFactor),
      'repetitions': serializer.toJson<int>(repetitions),
      'nextRevisionAt': serializer.toJson<DateTime>(nextRevisionAt),
      'lastRevisedAt': serializer.toJson<DateTime?>(lastRevisedAt),
    };
  }

  Revision copyWith({
    String? id,
    String? conceptId,
    String? chapterId,
    int? intervalDays,
    int? easeFactor,
    int? repetitions,
    DateTime? nextRevisionAt,
    Value<DateTime?> lastRevisedAt = const Value.absent(),
  }) => Revision(
    id: id ?? this.id,
    conceptId: conceptId ?? this.conceptId,
    chapterId: chapterId ?? this.chapterId,
    intervalDays: intervalDays ?? this.intervalDays,
    easeFactor: easeFactor ?? this.easeFactor,
    repetitions: repetitions ?? this.repetitions,
    nextRevisionAt: nextRevisionAt ?? this.nextRevisionAt,
    lastRevisedAt: lastRevisedAt.present ? lastRevisedAt.value : this.lastRevisedAt,
  );
  Revision copyWithCompanion(RevisionsCompanion data) {
    return Revision(
      id: data.id.present ? data.id.value : this.id,
      conceptId: data.conceptId.present ? data.conceptId.value : this.conceptId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      intervalDays: data.intervalDays.present ? data.intervalDays.value : this.intervalDays,
      easeFactor: data.easeFactor.present ? data.easeFactor.value : this.easeFactor,
      repetitions: data.repetitions.present ? data.repetitions.value : this.repetitions,
      nextRevisionAt: data.nextRevisionAt.present ? data.nextRevisionAt.value : this.nextRevisionAt,
      lastRevisedAt: data.lastRevisedAt.present ? data.lastRevisedAt.value : this.lastRevisedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Revision(')
          ..write('id: $id, ')
          ..write('conceptId: $conceptId, ')
          ..write('chapterId: $chapterId, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('repetitions: $repetitions, ')
          ..write('nextRevisionAt: $nextRevisionAt, ')
          ..write('lastRevisedAt: $lastRevisedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, conceptId, chapterId, intervalDays, easeFactor, repetitions, nextRevisionAt, lastRevisedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Revision &&
          other.id == this.id &&
          other.conceptId == this.conceptId &&
          other.chapterId == this.chapterId &&
          other.intervalDays == this.intervalDays &&
          other.easeFactor == this.easeFactor &&
          other.repetitions == this.repetitions &&
          other.nextRevisionAt == this.nextRevisionAt &&
          other.lastRevisedAt == this.lastRevisedAt);
}

class RevisionsCompanion extends UpdateCompanion<Revision> {
  final Value<String> id;
  final Value<String> conceptId;
  final Value<String> chapterId;
  final Value<int> intervalDays;
  final Value<int> easeFactor;
  final Value<int> repetitions;
  final Value<DateTime> nextRevisionAt;
  final Value<DateTime?> lastRevisedAt;
  final Value<int> rowid;
  const RevisionsCompanion({
    this.id = const Value.absent(),
    this.conceptId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.nextRevisionAt = const Value.absent(),
    this.lastRevisedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RevisionsCompanion.insert({
    required String id,
    required String conceptId,
    required String chapterId,
    this.intervalDays = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.repetitions = const Value.absent(),
    required DateTime nextRevisionAt,
    this.lastRevisedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       conceptId = Value(conceptId),
       chapterId = Value(chapterId),
       nextRevisionAt = Value(nextRevisionAt);
  static Insertable<Revision> custom({
    Expression<String>? id,
    Expression<String>? conceptId,
    Expression<String>? chapterId,
    Expression<int>? intervalDays,
    Expression<int>? easeFactor,
    Expression<int>? repetitions,
    Expression<DateTime>? nextRevisionAt,
    Expression<DateTime>? lastRevisedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conceptId != null) 'concept_id': conceptId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (easeFactor != null) 'ease_factor': easeFactor,
      if (repetitions != null) 'repetitions': repetitions,
      if (nextRevisionAt != null) 'next_revision_at': nextRevisionAt,
      if (lastRevisedAt != null) 'last_revised_at': lastRevisedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RevisionsCompanion copyWith({
    Value<String>? id,
    Value<String>? conceptId,
    Value<String>? chapterId,
    Value<int>? intervalDays,
    Value<int>? easeFactor,
    Value<int>? repetitions,
    Value<DateTime>? nextRevisionAt,
    Value<DateTime?>? lastRevisedAt,
    Value<int>? rowid,
  }) {
    return RevisionsCompanion(
      id: id ?? this.id,
      conceptId: conceptId ?? this.conceptId,
      chapterId: chapterId ?? this.chapterId,
      intervalDays: intervalDays ?? this.intervalDays,
      easeFactor: easeFactor ?? this.easeFactor,
      repetitions: repetitions ?? this.repetitions,
      nextRevisionAt: nextRevisionAt ?? this.nextRevisionAt,
      lastRevisedAt: lastRevisedAt ?? this.lastRevisedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (conceptId.present) {
      map['concept_id'] = Variable<String>(conceptId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (easeFactor.present) {
      map['ease_factor'] = Variable<int>(easeFactor.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (nextRevisionAt.present) {
      map['next_revision_at'] = Variable<DateTime>(nextRevisionAt.value);
    }
    if (lastRevisedAt.present) {
      map['last_revised_at'] = Variable<DateTime>(lastRevisedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RevisionsCompanion(')
          ..write('id: $id, ')
          ..write('conceptId: $conceptId, ')
          ..write('chapterId: $chapterId, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('repetitions: $repetitions, ')
          ..write('nextRevisionAt: $nextRevisionAt, ')
          ..write('lastRevisedAt: $lastRevisedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearningStreaksTable extends LearningStreaks with TableInfo<$LearningStreaksTable, LearningStreak> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningStreaksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentStreakMeta = const VerificationMeta('currentStreak');
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _longestStreakMeta = const VerificationMeta('longestStreak');
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
    'longest_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastActiveDateMeta = const VerificationMeta('lastActiveDate');
  @override
  late final GeneratedColumn<DateTime> lastActiveDate = GeneratedColumn<DateTime>(
    'last_active_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeDatesMeta = const VerificationMeta('activeDates');
  @override
  late final GeneratedColumn<String> activeDates = GeneratedColumn<String>(
    'active_dates',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, currentStreak, longestStreak, lastActiveDate, activeDates];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_streaks';
  @override
  VerificationContext validateIntegrity(Insertable<LearningStreak> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('current_streak')) {
      context.handle(_currentStreakMeta, currentStreak.isAcceptableOrUnknown(data['current_streak']!, _currentStreakMeta));
    }
    if (data.containsKey('longest_streak')) {
      context.handle(_longestStreakMeta, longestStreak.isAcceptableOrUnknown(data['longest_streak']!, _longestStreakMeta));
    }
    if (data.containsKey('last_active_date')) {
      context.handle(_lastActiveDateMeta, lastActiveDate.isAcceptableOrUnknown(data['last_active_date']!, _lastActiveDateMeta));
    } else if (isInserting) {
      context.missing(_lastActiveDateMeta);
    }
    if (data.containsKey('active_dates')) {
      context.handle(_activeDatesMeta, activeDates.isAcceptableOrUnknown(data['active_dates']!, _activeDatesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningStreak map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningStreak(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      currentStreak: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}current_streak'])!,
      longestStreak: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}longest_streak'])!,
      lastActiveDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}last_active_date'])!,
      activeDates: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}active_dates'])!,
    );
  }

  @override
  $LearningStreaksTable createAlias(String alias) {
    return $LearningStreaksTable(attachedDatabase, alias);
  }
}

class LearningStreak extends DataClass implements Insertable<LearningStreak> {
  final String id;
  final int currentStreak;
  final int longestStreak;
  final DateTime lastActiveDate;
  final String activeDates;
  const LearningStreak({
    required this.id,
    required this.currentStreak,
    required this.longestStreak,
    required this.lastActiveDate,
    required this.activeDates,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    map['last_active_date'] = Variable<DateTime>(lastActiveDate);
    map['active_dates'] = Variable<String>(activeDates);
    return map;
  }

  LearningStreaksCompanion toCompanion(bool nullToAbsent) {
    return LearningStreaksCompanion(
      id: Value(id),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      lastActiveDate: Value(lastActiveDate),
      activeDates: Value(activeDates),
    );
  }

  factory LearningStreak.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningStreak(
      id: serializer.fromJson<String>(json['id']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      lastActiveDate: serializer.fromJson<DateTime>(json['lastActiveDate']),
      activeDates: serializer.fromJson<String>(json['activeDates']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'lastActiveDate': serializer.toJson<DateTime>(lastActiveDate),
      'activeDates': serializer.toJson<String>(activeDates),
    };
  }

  LearningStreak copyWith({String? id, int? currentStreak, int? longestStreak, DateTime? lastActiveDate, String? activeDates}) =>
      LearningStreak(
        id: id ?? this.id,
        currentStreak: currentStreak ?? this.currentStreak,
        longestStreak: longestStreak ?? this.longestStreak,
        lastActiveDate: lastActiveDate ?? this.lastActiveDate,
        activeDates: activeDates ?? this.activeDates,
      );
  LearningStreak copyWithCompanion(LearningStreaksCompanion data) {
    return LearningStreak(
      id: data.id.present ? data.id.value : this.id,
      currentStreak: data.currentStreak.present ? data.currentStreak.value : this.currentStreak,
      longestStreak: data.longestStreak.present ? data.longestStreak.value : this.longestStreak,
      lastActiveDate: data.lastActiveDate.present ? data.lastActiveDate.value : this.lastActiveDate,
      activeDates: data.activeDates.present ? data.activeDates.value : this.activeDates,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningStreak(')
          ..write('id: $id, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastActiveDate: $lastActiveDate, ')
          ..write('activeDates: $activeDates')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, currentStreak, longestStreak, lastActiveDate, activeDates);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningStreak &&
          other.id == this.id &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.lastActiveDate == this.lastActiveDate &&
          other.activeDates == this.activeDates);
}

class LearningStreaksCompanion extends UpdateCompanion<LearningStreak> {
  final Value<String> id;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<DateTime> lastActiveDate;
  final Value<String> activeDates;
  final Value<int> rowid;
  const LearningStreaksCompanion({
    this.id = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastActiveDate = const Value.absent(),
    this.activeDates = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearningStreaksCompanion.insert({
    required String id,
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    required DateTime lastActiveDate,
    this.activeDates = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       lastActiveDate = Value(lastActiveDate);
  static Insertable<LearningStreak> custom({
    Expression<String>? id,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<DateTime>? lastActiveDate,
    Expression<String>? activeDates,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (lastActiveDate != null) 'last_active_date': lastActiveDate,
      if (activeDates != null) 'active_dates': activeDates,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearningStreaksCompanion copyWith({
    Value<String>? id,
    Value<int>? currentStreak,
    Value<int>? longestStreak,
    Value<DateTime>? lastActiveDate,
    Value<String>? activeDates,
    Value<int>? rowid,
  }) {
    return LearningStreaksCompanion(
      id: id ?? this.id,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      activeDates: activeDates ?? this.activeDates,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (lastActiveDate.present) {
      map['last_active_date'] = Variable<DateTime>(lastActiveDate.value);
    }
    if (activeDates.present) {
      map['active_dates'] = Variable<String>(activeDates.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningStreaksCompanion(')
          ..write('id: $id, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastActiveDate: $lastActiveDate, ')
          ..write('activeDates: $activeDates, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications with TableInfo<$NotificationsTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_read" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta('scheduledAt');
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, body, type, isRead, scheduledAt, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(Insertable<Notification> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(_titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(_bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('type')) {
      context.handle(_typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(_isReadMeta, isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta));
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(_scheduledAtMeta, scheduledAt.isAcceptableOrUnknown(data['scheduled_at']!, _scheduledAtMeta));
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      type: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      isRead: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_read'])!,
      scheduledAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}scheduled_at'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final String id;
  final String title;
  final String body;
  final String type;
  final bool isRead;
  final DateTime scheduledAt;
  final DateTime createdAt;
  const Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.scheduledAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['type'] = Variable<String>(type);
    map['is_read'] = Variable<bool>(isRead);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      title: Value(title),
      body: Value(body),
      type: Value(type),
      isRead: Value(isRead),
      scheduledAt: Value(scheduledAt),
      createdAt: Value(createdAt),
    );
  }

  factory Notification.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      type: serializer.fromJson<String>(json['type']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'type': serializer.toJson<String>(type),
      'isRead': serializer.toJson<bool>(isRead),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Notification copyWith({
    String? id,
    String? title,
    String? body,
    String? type,
    bool? isRead,
    DateTime? scheduledAt,
    DateTime? createdAt,
  }) => Notification(
    id: id ?? this.id,
    title: title ?? this.title,
    body: body ?? this.body,
    type: type ?? this.type,
    isRead: isRead ?? this.isRead,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Notification copyWithCompanion(NotificationsCompanion data) {
    return Notification(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      type: data.type.present ? data.type.value : this.type,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      scheduledAt: data.scheduledAt.present ? data.scheduledAt.value : this.scheduledAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('type: $type, ')
          ..write('isRead: $isRead, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, body, type, isRead, scheduledAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.title == this.title &&
          other.body == this.body &&
          other.type == this.type &&
          other.isRead == this.isRead &&
          other.scheduledAt == this.scheduledAt &&
          other.createdAt == this.createdAt);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> body;
  final Value<String> type;
  final Value<bool> isRead;
  final Value<DateTime> scheduledAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.type = const Value.absent(),
    this.isRead = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationsCompanion.insert({
    required String id,
    required String title,
    required String body,
    required String type,
    this.isRead = const Value.absent(),
    required DateTime scheduledAt,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       body = Value(body),
       type = Value(type),
       scheduledAt = Value(scheduledAt),
       createdAt = Value(createdAt);
  static Insertable<Notification> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? type,
    Expression<bool>? isRead,
    Expression<DateTime>? scheduledAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (type != null) 'type': type,
      if (isRead != null) 'is_read': isRead,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? body,
    Value<String>? type,
    Value<bool>? isRead,
    Value<DateTime>? scheduledAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return NotificationsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      createdAt: createdAt ?? this.createdAt,
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
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('type: $type, ')
          ..write('isRead: $isRead, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScanHistoryEntriesTable extends ScanHistoryEntries with TableInfo<$ScanHistoryEntriesTable, ScanHistoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanHistoryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta('chapterId');
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
    'subject_id',
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
  static const VerificationMeta _summarySnippetMeta = const VerificationMeta('summarySnippet');
  @override
  late final GeneratedColumn<String> summarySnippet = GeneratedColumn<String>(
    'summary_snippet',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _conceptCountMeta = const VerificationMeta('conceptCount');
  @override
  late final GeneratedColumn<int> conceptCount = GeneratedColumn<int>(
    'concept_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _flashcardCountMeta = const VerificationMeta('flashcardCount');
  @override
  late final GeneratedColumn<int> flashcardCount = GeneratedColumn<int>(
    'flashcard_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _quizCountMeta = const VerificationMeta('quizCount');
  @override
  late final GeneratedColumn<int> quizCount = GeneratedColumn<int>(
    'quiz_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _pageCountMeta = const VerificationMeta('pageCount');
  @override
  late final GeneratedColumn<int> pageCount = GeneratedColumn<int>(
    'page_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _scannedAtMeta = const VerificationMeta('scannedAt');
  @override
  late final GeneratedColumn<DateTime> scannedAt = GeneratedColumn<DateTime>(
    'scanned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    chapterId,
    subjectId,
    title,
    summarySnippet,
    conceptCount,
    flashcardCount,
    quizCount,
    pageCount,
    scannedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_history_entries';
  @override
  VerificationContext validateIntegrity(Insertable<ScanHistoryEntry> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(_chapterIdMeta, chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta));
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta, subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(_titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('summary_snippet')) {
      context.handle(_summarySnippetMeta, summarySnippet.isAcceptableOrUnknown(data['summary_snippet']!, _summarySnippetMeta));
    }
    if (data.containsKey('concept_count')) {
      context.handle(_conceptCountMeta, conceptCount.isAcceptableOrUnknown(data['concept_count']!, _conceptCountMeta));
    }
    if (data.containsKey('flashcard_count')) {
      context.handle(_flashcardCountMeta, flashcardCount.isAcceptableOrUnknown(data['flashcard_count']!, _flashcardCountMeta));
    }
    if (data.containsKey('quiz_count')) {
      context.handle(_quizCountMeta, quizCount.isAcceptableOrUnknown(data['quiz_count']!, _quizCountMeta));
    }
    if (data.containsKey('page_count')) {
      context.handle(_pageCountMeta, pageCount.isAcceptableOrUnknown(data['page_count']!, _pageCountMeta));
    }
    if (data.containsKey('scanned_at')) {
      context.handle(_scannedAtMeta, scannedAt.isAcceptableOrUnknown(data['scanned_at']!, _scannedAtMeta));
    } else if (isInserting) {
      context.missing(_scannedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanHistoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanHistoryEntry(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      chapterId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}chapter_id'])!,
      subjectId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}subject_id'])!,
      title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      summarySnippet: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}summary_snippet'])!,
      conceptCount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}concept_count'])!,
      flashcardCount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}flashcard_count'])!,
      quizCount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}quiz_count'])!,
      pageCount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}page_count'])!,
      scannedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}scanned_at'])!,
    );
  }

  @override
  $ScanHistoryEntriesTable createAlias(String alias) {
    return $ScanHistoryEntriesTable(attachedDatabase, alias);
  }
}

class ScanHistoryEntry extends DataClass implements Insertable<ScanHistoryEntry> {
  final String id;
  final String chapterId;
  final String subjectId;
  final String title;
  final String summarySnippet;
  final int conceptCount;
  final int flashcardCount;
  final int quizCount;
  final int pageCount;
  final DateTime scannedAt;
  const ScanHistoryEntry({
    required this.id,
    required this.chapterId,
    required this.subjectId,
    required this.title,
    required this.summarySnippet,
    required this.conceptCount,
    required this.flashcardCount,
    required this.quizCount,
    required this.pageCount,
    required this.scannedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['chapter_id'] = Variable<String>(chapterId);
    map['subject_id'] = Variable<String>(subjectId);
    map['title'] = Variable<String>(title);
    map['summary_snippet'] = Variable<String>(summarySnippet);
    map['concept_count'] = Variable<int>(conceptCount);
    map['flashcard_count'] = Variable<int>(flashcardCount);
    map['quiz_count'] = Variable<int>(quizCount);
    map['page_count'] = Variable<int>(pageCount);
    map['scanned_at'] = Variable<DateTime>(scannedAt);
    return map;
  }

  ScanHistoryEntriesCompanion toCompanion(bool nullToAbsent) {
    return ScanHistoryEntriesCompanion(
      id: Value(id),
      chapterId: Value(chapterId),
      subjectId: Value(subjectId),
      title: Value(title),
      summarySnippet: Value(summarySnippet),
      conceptCount: Value(conceptCount),
      flashcardCount: Value(flashcardCount),
      quizCount: Value(quizCount),
      pageCount: Value(pageCount),
      scannedAt: Value(scannedAt),
    );
  }

  factory ScanHistoryEntry.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanHistoryEntry(
      id: serializer.fromJson<String>(json['id']),
      chapterId: serializer.fromJson<String>(json['chapterId']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      title: serializer.fromJson<String>(json['title']),
      summarySnippet: serializer.fromJson<String>(json['summarySnippet']),
      conceptCount: serializer.fromJson<int>(json['conceptCount']),
      flashcardCount: serializer.fromJson<int>(json['flashcardCount']),
      quizCount: serializer.fromJson<int>(json['quizCount']),
      pageCount: serializer.fromJson<int>(json['pageCount']),
      scannedAt: serializer.fromJson<DateTime>(json['scannedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'chapterId': serializer.toJson<String>(chapterId),
      'subjectId': serializer.toJson<String>(subjectId),
      'title': serializer.toJson<String>(title),
      'summarySnippet': serializer.toJson<String>(summarySnippet),
      'conceptCount': serializer.toJson<int>(conceptCount),
      'flashcardCount': serializer.toJson<int>(flashcardCount),
      'quizCount': serializer.toJson<int>(quizCount),
      'pageCount': serializer.toJson<int>(pageCount),
      'scannedAt': serializer.toJson<DateTime>(scannedAt),
    };
  }

  ScanHistoryEntry copyWith({
    String? id,
    String? chapterId,
    String? subjectId,
    String? title,
    String? summarySnippet,
    int? conceptCount,
    int? flashcardCount,
    int? quizCount,
    int? pageCount,
    DateTime? scannedAt,
  }) => ScanHistoryEntry(
    id: id ?? this.id,
    chapterId: chapterId ?? this.chapterId,
    subjectId: subjectId ?? this.subjectId,
    title: title ?? this.title,
    summarySnippet: summarySnippet ?? this.summarySnippet,
    conceptCount: conceptCount ?? this.conceptCount,
    flashcardCount: flashcardCount ?? this.flashcardCount,
    quizCount: quizCount ?? this.quizCount,
    pageCount: pageCount ?? this.pageCount,
    scannedAt: scannedAt ?? this.scannedAt,
  );
  ScanHistoryEntry copyWithCompanion(ScanHistoryEntriesCompanion data) {
    return ScanHistoryEntry(
      id: data.id.present ? data.id.value : this.id,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      title: data.title.present ? data.title.value : this.title,
      summarySnippet: data.summarySnippet.present ? data.summarySnippet.value : this.summarySnippet,
      conceptCount: data.conceptCount.present ? data.conceptCount.value : this.conceptCount,
      flashcardCount: data.flashcardCount.present ? data.flashcardCount.value : this.flashcardCount,
      quizCount: data.quizCount.present ? data.quizCount.value : this.quizCount,
      pageCount: data.pageCount.present ? data.pageCount.value : this.pageCount,
      scannedAt: data.scannedAt.present ? data.scannedAt.value : this.scannedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanHistoryEntry(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('summarySnippet: $summarySnippet, ')
          ..write('conceptCount: $conceptCount, ')
          ..write('flashcardCount: $flashcardCount, ')
          ..write('quizCount: $quizCount, ')
          ..write('pageCount: $pageCount, ')
          ..write('scannedAt: $scannedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, chapterId, subjectId, title, summarySnippet, conceptCount, flashcardCount, quizCount, pageCount, scannedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanHistoryEntry &&
          other.id == this.id &&
          other.chapterId == this.chapterId &&
          other.subjectId == this.subjectId &&
          other.title == this.title &&
          other.summarySnippet == this.summarySnippet &&
          other.conceptCount == this.conceptCount &&
          other.flashcardCount == this.flashcardCount &&
          other.quizCount == this.quizCount &&
          other.pageCount == this.pageCount &&
          other.scannedAt == this.scannedAt);
}

class ScanHistoryEntriesCompanion extends UpdateCompanion<ScanHistoryEntry> {
  final Value<String> id;
  final Value<String> chapterId;
  final Value<String> subjectId;
  final Value<String> title;
  final Value<String> summarySnippet;
  final Value<int> conceptCount;
  final Value<int> flashcardCount;
  final Value<int> quizCount;
  final Value<int> pageCount;
  final Value<DateTime> scannedAt;
  final Value<int> rowid;
  const ScanHistoryEntriesCompanion({
    this.id = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.title = const Value.absent(),
    this.summarySnippet = const Value.absent(),
    this.conceptCount = const Value.absent(),
    this.flashcardCount = const Value.absent(),
    this.quizCount = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.scannedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScanHistoryEntriesCompanion.insert({
    required String id,
    required String chapterId,
    required String subjectId,
    required String title,
    this.summarySnippet = const Value.absent(),
    this.conceptCount = const Value.absent(),
    this.flashcardCount = const Value.absent(),
    this.quizCount = const Value.absent(),
    this.pageCount = const Value.absent(),
    required DateTime scannedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       chapterId = Value(chapterId),
       subjectId = Value(subjectId),
       title = Value(title),
       scannedAt = Value(scannedAt);
  static Insertable<ScanHistoryEntry> custom({
    Expression<String>? id,
    Expression<String>? chapterId,
    Expression<String>? subjectId,
    Expression<String>? title,
    Expression<String>? summarySnippet,
    Expression<int>? conceptCount,
    Expression<int>? flashcardCount,
    Expression<int>? quizCount,
    Expression<int>? pageCount,
    Expression<DateTime>? scannedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chapterId != null) 'chapter_id': chapterId,
      if (subjectId != null) 'subject_id': subjectId,
      if (title != null) 'title': title,
      if (summarySnippet != null) 'summary_snippet': summarySnippet,
      if (conceptCount != null) 'concept_count': conceptCount,
      if (flashcardCount != null) 'flashcard_count': flashcardCount,
      if (quizCount != null) 'quiz_count': quizCount,
      if (pageCount != null) 'page_count': pageCount,
      if (scannedAt != null) 'scanned_at': scannedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScanHistoryEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? chapterId,
    Value<String>? subjectId,
    Value<String>? title,
    Value<String>? summarySnippet,
    Value<int>? conceptCount,
    Value<int>? flashcardCount,
    Value<int>? quizCount,
    Value<int>? pageCount,
    Value<DateTime>? scannedAt,
    Value<int>? rowid,
  }) {
    return ScanHistoryEntriesCompanion(
      id: id ?? this.id,
      chapterId: chapterId ?? this.chapterId,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      summarySnippet: summarySnippet ?? this.summarySnippet,
      conceptCount: conceptCount ?? this.conceptCount,
      flashcardCount: flashcardCount ?? this.flashcardCount,
      quizCount: quizCount ?? this.quizCount,
      pageCount: pageCount ?? this.pageCount,
      scannedAt: scannedAt ?? this.scannedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (summarySnippet.present) {
      map['summary_snippet'] = Variable<String>(summarySnippet.value);
    }
    if (conceptCount.present) {
      map['concept_count'] = Variable<int>(conceptCount.value);
    }
    if (flashcardCount.present) {
      map['flashcard_count'] = Variable<int>(flashcardCount.value);
    }
    if (quizCount.present) {
      map['quiz_count'] = Variable<int>(quizCount.value);
    }
    if (pageCount.present) {
      map['page_count'] = Variable<int>(pageCount.value);
    }
    if (scannedAt.present) {
      map['scanned_at'] = Variable<DateTime>(scannedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanHistoryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('summarySnippet: $summarySnippet, ')
          ..write('conceptCount: $conceptCount, ')
          ..write('flashcardCount: $flashcardCount, ')
          ..write('quizCount: $quizCount, ')
          ..write('pageCount: $pageCount, ')
          ..write('scannedAt: $scannedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StudentProfilesTable studentProfiles = $StudentProfilesTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $ChaptersTable chapters = $ChaptersTable(this);
  late final $ConceptsTable concepts = $ConceptsTable(this);
  late final $FlashcardsTable flashcards = $FlashcardsTable(this);
  late final $QuizQuestionsTable quizQuestions = $QuizQuestionsTable(this);
  late final $QuizAttemptsTable quizAttempts = $QuizAttemptsTable(this);
  late final $RevisionsTable revisions = $RevisionsTable(this);
  late final $LearningStreaksTable learningStreaks = $LearningStreaksTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  late final $ScanHistoryEntriesTable scanHistoryEntries = $ScanHistoryEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    studentProfiles,
    subjects,
    chapters,
    concepts,
    flashcards,
    quizQuestions,
    quizAttempts,
    revisions,
    learningStreaks,
    notifications,
    scanHistoryEntries,
  ];
}

typedef $$StudentProfilesTableCreateCompanionBuilder =
    StudentProfilesCompanion Function({
      required String id,
      required String name,
      Value<String?> email,
      Value<String?> avatarUrl,
      Value<String?> examTarget,
      Value<int> dailyGoalMinutes,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$StudentProfilesTableUpdateCompanionBuilder =
    StudentProfilesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> email,
      Value<String?> avatarUrl,
      Value<String?> examTarget,
      Value<int> dailyGoalMinutes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$StudentProfilesTableFilterComposer extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarUrl => $composableBuilder(column: $table.avatarUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get examTarget => $composableBuilder(column: $table.examTarget, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailyGoalMinutes =>
      $composableBuilder(column: $table.dailyGoalMinutes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$StudentProfilesTableOrderingComposer extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarUrl => $composableBuilder(column: $table.avatarUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get examTarget => $composableBuilder(column: $table.examTarget, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailyGoalMinutes =>
      $composableBuilder(column: $table.dailyGoalMinutes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$StudentProfilesTableAnnotationComposer extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email => $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl => $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get examTarget => $composableBuilder(column: $table.examTarget, builder: (column) => column);

  GeneratedColumn<int> get dailyGoalMinutes => $composableBuilder(column: $table.dailyGoalMinutes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$StudentProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentProfilesTable,
          StudentProfile,
          $$StudentProfilesTableFilterComposer,
          $$StudentProfilesTableOrderingComposer,
          $$StudentProfilesTableAnnotationComposer,
          $$StudentProfilesTableCreateCompanionBuilder,
          $$StudentProfilesTableUpdateCompanionBuilder,
          (StudentProfile, BaseReferences<_$AppDatabase, $StudentProfilesTable, StudentProfile>),
          StudentProfile,
          PrefetchHooks Function()
        > {
  $$StudentProfilesTableTableManager(_$AppDatabase db, $StudentProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$StudentProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$StudentProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$StudentProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> examTarget = const Value.absent(),
                Value<int> dailyGoalMinutes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudentProfilesCompanion(
                id: id,
                name: name,
                email: email,
                avatarUrl: avatarUrl,
                examTarget: examTarget,
                dailyGoalMinutes: dailyGoalMinutes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> examTarget = const Value.absent(),
                Value<int> dailyGoalMinutes = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => StudentProfilesCompanion.insert(
                id: id,
                name: name,
                email: email,
                avatarUrl: avatarUrl,
                examTarget: examTarget,
                dailyGoalMinutes: dailyGoalMinutes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudentProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentProfilesTable,
      StudentProfile,
      $$StudentProfilesTableFilterComposer,
      $$StudentProfilesTableOrderingComposer,
      $$StudentProfilesTableAnnotationComposer,
      $$StudentProfilesTableCreateCompanionBuilder,
      $$StudentProfilesTableUpdateCompanionBuilder,
      (StudentProfile, BaseReferences<_$AppDatabase, $StudentProfilesTable, StudentProfile>),
      StudentProfile,
      PrefetchHooks Function()
    >;
typedef $$SubjectsTableCreateCompanionBuilder =
    SubjectsCompanion Function({
      required String id,
      required String name,
      Value<String> colorHex,
      Value<String> iconName,
      Value<int> totalChapters,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SubjectsTableUpdateCompanionBuilder =
    SubjectsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> colorHex,
      Value<String> iconName,
      Value<int> totalChapters,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$SubjectsTableReferences extends BaseReferences<_$AppDatabase, $SubjectsTable, Subject> {
  $$SubjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChaptersTable, List<Chapter>> _chaptersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.chapters, aliasName: $_aliasNameGenerator(db.subjects.id, db.chapters.subjectId));

  $$ChaptersTableProcessedTableManager get chaptersRefs {
    final manager = $$ChaptersTableTableManager($_db, $_db.chapters).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chaptersRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ConceptsTable, List<Concept>> _conceptsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.concepts, aliasName: $_aliasNameGenerator(db.subjects.id, db.concepts.subjectId));

  $$ConceptsTableProcessedTableManager get conceptsRefs {
    final manager = $$ConceptsTableTableManager($_db, $_db.concepts).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_conceptsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QuizAttemptsTable, List<QuizAttempt>> _quizAttemptsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.quizAttempts, aliasName: $_aliasNameGenerator(db.subjects.id, db.quizAttempts.subjectId));

  $$QuizAttemptsTableProcessedTableManager get quizAttemptsRefs {
    final manager = $$QuizAttemptsTableTableManager(
      $_db,
      $_db.quizAttempts,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_quizAttemptsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SubjectsTableFilterComposer extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconName => $composableBuilder(column: $table.iconName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalChapters => $composableBuilder(column: $table.totalChapters, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> chaptersRefs(Expression<bool> Function($$ChaptersTableFilterComposer f) f) {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> conceptsRefs(Expression<bool> Function($$ConceptsTableFilterComposer f) f) {
    final $$ConceptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableFilterComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> quizAttemptsRefs(Expression<bool> Function($$QuizAttemptsTableFilterComposer f) f) {
    final $$QuizAttemptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizAttempts,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$QuizAttemptsTableFilterComposer(
            $db: $db,
            $table: $db.quizAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableOrderingComposer extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconName => $composableBuilder(column: $table.iconName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalChapters => $composableBuilder(column: $table.totalChapters, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SubjectsTableAnnotationComposer extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get colorHex => $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<String> get iconName => $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<int> get totalChapters => $composableBuilder(column: $table.totalChapters, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> chaptersRefs<T extends Object>(Expression<T> Function($$ChaptersTableAnnotationComposer a) f) {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> conceptsRefs<T extends Object>(Expression<T> Function($$ConceptsTableAnnotationComposer a) f) {
    final $$ConceptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableAnnotationComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> quizAttemptsRefs<T extends Object>(Expression<T> Function($$QuizAttemptsTableAnnotationComposer a) f) {
    final $$QuizAttemptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizAttempts,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$QuizAttemptsTableAnnotationComposer(
            $db: $db,
            $table: $db.quizAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubjectsTable,
          Subject,
          $$SubjectsTableFilterComposer,
          $$SubjectsTableOrderingComposer,
          $$SubjectsTableAnnotationComposer,
          $$SubjectsTableCreateCompanionBuilder,
          $$SubjectsTableUpdateCompanionBuilder,
          (Subject, $$SubjectsTableReferences),
          Subject,
          PrefetchHooks Function({bool chaptersRefs, bool conceptsRefs, bool quizAttemptsRefs})
        > {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<int> totalChapters = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubjectsCompanion(
                id: id,
                name: name,
                colorHex: colorHex,
                iconName: iconName,
                totalChapters: totalChapters,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> colorHex = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<int> totalChapters = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SubjectsCompanion.insert(
                id: id,
                name: name,
                colorHex: colorHex,
                iconName: iconName,
                totalChapters: totalChapters,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), $$SubjectsTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({chaptersRefs = false, conceptsRefs = false, quizAttemptsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (chaptersRefs) db.chapters,
                if (conceptsRefs) db.concepts,
                if (quizAttemptsRefs) db.quizAttempts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chaptersRefs)
                    await $_getPrefetchedData<Subject, $SubjectsTable, Chapter>(
                      currentTable: table,
                      referencedTable: $$SubjectsTableReferences._chaptersRefsTable(db),
                      managerFromTypedResult: (p0) => $$SubjectsTableReferences(db, table, p0).chaptersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.subjectId == item.id),
                      typedResults: items,
                    ),
                  if (conceptsRefs)
                    await $_getPrefetchedData<Subject, $SubjectsTable, Concept>(
                      currentTable: table,
                      referencedTable: $$SubjectsTableReferences._conceptsRefsTable(db),
                      managerFromTypedResult: (p0) => $$SubjectsTableReferences(db, table, p0).conceptsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.subjectId == item.id),
                      typedResults: items,
                    ),
                  if (quizAttemptsRefs)
                    await $_getPrefetchedData<Subject, $SubjectsTable, QuizAttempt>(
                      currentTable: table,
                      referencedTable: $$SubjectsTableReferences._quizAttemptsRefsTable(db),
                      managerFromTypedResult: (p0) => $$SubjectsTableReferences(db, table, p0).quizAttemptsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.subjectId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubjectsTable,
      Subject,
      $$SubjectsTableFilterComposer,
      $$SubjectsTableOrderingComposer,
      $$SubjectsTableAnnotationComposer,
      $$SubjectsTableCreateCompanionBuilder,
      $$SubjectsTableUpdateCompanionBuilder,
      (Subject, $$SubjectsTableReferences),
      Subject,
      PrefetchHooks Function({bool chaptersRefs, bool conceptsRefs, bool quizAttemptsRefs})
    >;
typedef $$ChaptersTableCreateCompanionBuilder =
    ChaptersCompanion Function({
      required String id,
      required String subjectId,
      required String title,
      Value<String?> description,
      Value<int> orderIndex,
      Value<int> masteryLevel,
      Value<bool> isCompleted,
      Value<DateTime?> lastStudiedAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ChaptersTableUpdateCompanionBuilder =
    ChaptersCompanion Function({
      Value<String> id,
      Value<String> subjectId,
      Value<String> title,
      Value<String?> description,
      Value<int> orderIndex,
      Value<int> masteryLevel,
      Value<bool> isCompleted,
      Value<DateTime?> lastStudiedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ChaptersTableReferences extends BaseReferences<_$AppDatabase, $ChaptersTable, Chapter> {
  $$ChaptersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias($_aliasNameGenerator(db.chapters.subjectId, db.subjects.id));

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager($_db, $_db.subjects).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ConceptsTable, List<Concept>> _conceptsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.concepts, aliasName: $_aliasNameGenerator(db.chapters.id, db.concepts.chapterId));

  $$ConceptsTableProcessedTableManager get conceptsRefs {
    final manager = $$ConceptsTableTableManager($_db, $_db.concepts).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_conceptsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FlashcardsTable, List<Flashcard>> _flashcardsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.flashcards, aliasName: $_aliasNameGenerator(db.chapters.id, db.flashcards.chapterId));

  $$FlashcardsTableProcessedTableManager get flashcardsRefs {
    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QuizQuestionsTable, List<QuizQuestion>> _quizQuestionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.quizQuestions, aliasName: $_aliasNameGenerator(db.chapters.id, db.quizQuestions.chapterId));

  $$QuizQuestionsTableProcessedTableManager get quizQuestionsRefs {
    final manager = $$QuizQuestionsTableTableManager(
      $_db,
      $_db.quizQuestions,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_quizQuestionsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QuizAttemptsTable, List<QuizAttempt>> _quizAttemptsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.quizAttempts, aliasName: $_aliasNameGenerator(db.chapters.id, db.quizAttempts.chapterId));

  $$QuizAttemptsTableProcessedTableManager get quizAttemptsRefs {
    final manager = $$QuizAttemptsTableTableManager(
      $_db,
      $_db.quizAttempts,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_quizAttemptsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RevisionsTable, List<Revision>> _revisionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.revisions, aliasName: $_aliasNameGenerator(db.chapters.id, db.revisions.chapterId));

  $$RevisionsTableProcessedTableManager get revisionsRefs {
    final manager = $$RevisionsTableTableManager($_db, $_db.revisions).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_revisionsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ChaptersTableFilterComposer extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(column: $table.orderIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get masteryLevel => $composableBuilder(column: $table.masteryLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastStudiedAt => $composableBuilder(column: $table.lastStudiedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> conceptsRefs(Expression<bool> Function($$ConceptsTableFilterComposer f) f) {
    final $$ConceptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableFilterComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> flashcardsRefs(Expression<bool> Function($$FlashcardsTableFilterComposer f) f) {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> quizQuestionsRefs(Expression<bool> Function($$QuizQuestionsTableFilterComposer f) f) {
    final $$QuizQuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizQuestions,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$QuizQuestionsTableFilterComposer(
            $db: $db,
            $table: $db.quizQuestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> quizAttemptsRefs(Expression<bool> Function($$QuizAttemptsTableFilterComposer f) f) {
    final $$QuizAttemptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizAttempts,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$QuizAttemptsTableFilterComposer(
            $db: $db,
            $table: $db.quizAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> revisionsRefs(Expression<bool> Function($$RevisionsTableFilterComposer f) f) {
    final $$RevisionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.revisions,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$RevisionsTableFilterComposer(
            $db: $db,
            $table: $db.revisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChaptersTableOrderingComposer extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(column: $table.orderIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get masteryLevel => $composableBuilder(column: $table.masteryLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastStudiedAt =>
      $composableBuilder(column: $table.lastStudiedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChaptersTableAnnotationComposer extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title => $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(column: $table.orderIndex, builder: (column) => column);

  GeneratedColumn<int> get masteryLevel => $composableBuilder(column: $table.masteryLevel, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<DateTime> get lastStudiedAt => $composableBuilder(column: $table.lastStudiedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> conceptsRefs<T extends Object>(Expression<T> Function($$ConceptsTableAnnotationComposer a) f) {
    final $$ConceptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableAnnotationComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> flashcardsRefs<T extends Object>(Expression<T> Function($$FlashcardsTableAnnotationComposer a) f) {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> quizQuestionsRefs<T extends Object>(Expression<T> Function($$QuizQuestionsTableAnnotationComposer a) f) {
    final $$QuizQuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizQuestions,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$QuizQuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.quizQuestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> quizAttemptsRefs<T extends Object>(Expression<T> Function($$QuizAttemptsTableAnnotationComposer a) f) {
    final $$QuizAttemptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizAttempts,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$QuizAttemptsTableAnnotationComposer(
            $db: $db,
            $table: $db.quizAttempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> revisionsRefs<T extends Object>(Expression<T> Function($$RevisionsTableAnnotationComposer a) f) {
    final $$RevisionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.revisions,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$RevisionsTableAnnotationComposer(
            $db: $db,
            $table: $db.revisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChaptersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChaptersTable,
          Chapter,
          $$ChaptersTableFilterComposer,
          $$ChaptersTableOrderingComposer,
          $$ChaptersTableAnnotationComposer,
          $$ChaptersTableCreateCompanionBuilder,
          $$ChaptersTableUpdateCompanionBuilder,
          (Chapter, $$ChaptersTableReferences),
          Chapter,
          PrefetchHooks Function({
            bool subjectId,
            bool conceptsRefs,
            bool flashcardsRefs,
            bool quizQuestionsRefs,
            bool quizAttemptsRefs,
            bool revisionsRefs,
          })
        > {
  $$ChaptersTableTableManager(_$AppDatabase db, $ChaptersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ChaptersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ChaptersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ChaptersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<int> masteryLevel = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> lastStudiedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChaptersCompanion(
                id: id,
                subjectId: subjectId,
                title: title,
                description: description,
                orderIndex: orderIndex,
                masteryLevel: masteryLevel,
                isCompleted: isCompleted,
                lastStudiedAt: lastStudiedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String subjectId,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<int> masteryLevel = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> lastStudiedAt = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ChaptersCompanion.insert(
                id: id,
                subjectId: subjectId,
                title: title,
                description: description,
                orderIndex: orderIndex,
                masteryLevel: masteryLevel,
                isCompleted: isCompleted,
                lastStudiedAt: lastStudiedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), $$ChaptersTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({
            subjectId = false,
            conceptsRefs = false,
            flashcardsRefs = false,
            quizQuestionsRefs = false,
            quizAttemptsRefs = false,
            revisionsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (conceptsRefs) db.concepts,
                if (flashcardsRefs) db.flashcards,
                if (quizQuestionsRefs) db.quizQuestions,
                if (quizAttemptsRefs) db.quizAttempts,
                if (revisionsRefs) db.revisions,
              ],
              addJoins: <
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
                if (subjectId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$ChaptersTableReferences._subjectIdTable(db),
                            referencedColumn: $$ChaptersTableReferences._subjectIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (conceptsRefs)
                    await $_getPrefetchedData<Chapter, $ChaptersTable, Concept>(
                      currentTable: table,
                      referencedTable: $$ChaptersTableReferences._conceptsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ChaptersTableReferences(db, table, p0).conceptsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.chapterId == item.id),
                      typedResults: items,
                    ),
                  if (flashcardsRefs)
                    await $_getPrefetchedData<Chapter, $ChaptersTable, Flashcard>(
                      currentTable: table,
                      referencedTable: $$ChaptersTableReferences._flashcardsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ChaptersTableReferences(db, table, p0).flashcardsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.chapterId == item.id),
                      typedResults: items,
                    ),
                  if (quizQuestionsRefs)
                    await $_getPrefetchedData<Chapter, $ChaptersTable, QuizQuestion>(
                      currentTable: table,
                      referencedTable: $$ChaptersTableReferences._quizQuestionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ChaptersTableReferences(db, table, p0).quizQuestionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.chapterId == item.id),
                      typedResults: items,
                    ),
                  if (quizAttemptsRefs)
                    await $_getPrefetchedData<Chapter, $ChaptersTable, QuizAttempt>(
                      currentTable: table,
                      referencedTable: $$ChaptersTableReferences._quizAttemptsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ChaptersTableReferences(db, table, p0).quizAttemptsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.chapterId == item.id),
                      typedResults: items,
                    ),
                  if (revisionsRefs)
                    await $_getPrefetchedData<Chapter, $ChaptersTable, Revision>(
                      currentTable: table,
                      referencedTable: $$ChaptersTableReferences._revisionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ChaptersTableReferences(db, table, p0).revisionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.chapterId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ChaptersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChaptersTable,
      Chapter,
      $$ChaptersTableFilterComposer,
      $$ChaptersTableOrderingComposer,
      $$ChaptersTableAnnotationComposer,
      $$ChaptersTableCreateCompanionBuilder,
      $$ChaptersTableUpdateCompanionBuilder,
      (Chapter, $$ChaptersTableReferences),
      Chapter,
      PrefetchHooks Function({
        bool subjectId,
        bool conceptsRefs,
        bool flashcardsRefs,
        bool quizQuestionsRefs,
        bool quizAttemptsRefs,
        bool revisionsRefs,
      })
    >;
typedef $$ConceptsTableCreateCompanionBuilder =
    ConceptsCompanion Function({
      required String id,
      required String chapterId,
      required String subjectId,
      required String title,
      required String summary,
      Value<String?> detailedExplanation,
      Value<String?> keyPoints,
      Value<String?> relatedConceptIds,
      Value<String?> tags,
      Value<int> masteryLevel,
      Value<int> importanceScore,
      Value<bool> isInterviewRelevant,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ConceptsTableUpdateCompanionBuilder =
    ConceptsCompanion Function({
      Value<String> id,
      Value<String> chapterId,
      Value<String> subjectId,
      Value<String> title,
      Value<String> summary,
      Value<String?> detailedExplanation,
      Value<String?> keyPoints,
      Value<String?> relatedConceptIds,
      Value<String?> tags,
      Value<int> masteryLevel,
      Value<int> importanceScore,
      Value<bool> isInterviewRelevant,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ConceptsTableReferences extends BaseReferences<_$AppDatabase, $ConceptsTable, Concept> {
  $$ConceptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias($_aliasNameGenerator(db.concepts.chapterId, db.chapters.id));

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<String>('chapter_id')!;

    final manager = $$ChaptersTableTableManager($_db, $_db.chapters).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias($_aliasNameGenerator(db.concepts.subjectId, db.subjects.id));

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager($_db, $_db.subjects).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$FlashcardsTable, List<Flashcard>> _flashcardsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.flashcards, aliasName: $_aliasNameGenerator(db.concepts.id, db.flashcards.conceptId));

  $$FlashcardsTableProcessedTableManager get flashcardsRefs {
    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.conceptId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QuizQuestionsTable, List<QuizQuestion>> _quizQuestionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.quizQuestions, aliasName: $_aliasNameGenerator(db.concepts.id, db.quizQuestions.conceptId));

  $$QuizQuestionsTableProcessedTableManager get quizQuestionsRefs {
    final manager = $$QuizQuestionsTableTableManager(
      $_db,
      $_db.quizQuestions,
    ).filter((f) => f.conceptId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_quizQuestionsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RevisionsTable, List<Revision>> _revisionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.revisions, aliasName: $_aliasNameGenerator(db.concepts.id, db.revisions.conceptId));

  $$RevisionsTableProcessedTableManager get revisionsRefs {
    final manager = $$RevisionsTableTableManager($_db, $_db.revisions).filter((f) => f.conceptId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_revisionsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ConceptsTableFilterComposer extends Composer<_$AppDatabase, $ConceptsTable> {
  $$ConceptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summary => $composableBuilder(column: $table.summary, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get detailedExplanation =>
      $composableBuilder(column: $table.detailedExplanation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get keyPoints => $composableBuilder(column: $table.keyPoints, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relatedConceptIds =>
      $composableBuilder(column: $table.relatedConceptIds, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get masteryLevel => $composableBuilder(column: $table.masteryLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get importanceScore => $composableBuilder(column: $table.importanceScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isInterviewRelevant =>
      $composableBuilder(column: $table.isInterviewRelevant, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> flashcardsRefs(Expression<bool> Function($$FlashcardsTableFilterComposer f) f) {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.conceptId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> quizQuestionsRefs(Expression<bool> Function($$QuizQuestionsTableFilterComposer f) f) {
    final $$QuizQuestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizQuestions,
      getReferencedColumn: (t) => t.conceptId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$QuizQuestionsTableFilterComposer(
            $db: $db,
            $table: $db.quizQuestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> revisionsRefs(Expression<bool> Function($$RevisionsTableFilterComposer f) f) {
    final $$RevisionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.revisions,
      getReferencedColumn: (t) => t.conceptId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$RevisionsTableFilterComposer(
            $db: $db,
            $table: $db.revisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ConceptsTableOrderingComposer extends Composer<_$AppDatabase, $ConceptsTable> {
  $$ConceptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summary => $composableBuilder(column: $table.summary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get detailedExplanation =>
      $composableBuilder(column: $table.detailedExplanation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get keyPoints => $composableBuilder(column: $table.keyPoints, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relatedConceptIds =>
      $composableBuilder(column: $table.relatedConceptIds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get masteryLevel => $composableBuilder(column: $table.masteryLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get importanceScore =>
      $composableBuilder(column: $table.importanceScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isInterviewRelevant =>
      $composableBuilder(column: $table.isInterviewRelevant, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConceptsTableAnnotationComposer extends Composer<_$AppDatabase, $ConceptsTable> {
  $$ConceptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title => $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get summary => $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get detailedExplanation => $composableBuilder(column: $table.detailedExplanation, builder: (column) => column);

  GeneratedColumn<String> get keyPoints => $composableBuilder(column: $table.keyPoints, builder: (column) => column);

  GeneratedColumn<String> get relatedConceptIds => $composableBuilder(column: $table.relatedConceptIds, builder: (column) => column);

  GeneratedColumn<String> get tags => $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<int> get masteryLevel => $composableBuilder(column: $table.masteryLevel, builder: (column) => column);

  GeneratedColumn<int> get importanceScore => $composableBuilder(column: $table.importanceScore, builder: (column) => column);

  GeneratedColumn<bool> get isInterviewRelevant => $composableBuilder(column: $table.isInterviewRelevant, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> flashcardsRefs<T extends Object>(Expression<T> Function($$FlashcardsTableAnnotationComposer a) f) {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.conceptId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> quizQuestionsRefs<T extends Object>(Expression<T> Function($$QuizQuestionsTableAnnotationComposer a) f) {
    final $$QuizQuestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizQuestions,
      getReferencedColumn: (t) => t.conceptId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$QuizQuestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.quizQuestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> revisionsRefs<T extends Object>(Expression<T> Function($$RevisionsTableAnnotationComposer a) f) {
    final $$RevisionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.revisions,
      getReferencedColumn: (t) => t.conceptId,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$RevisionsTableAnnotationComposer(
            $db: $db,
            $table: $db.revisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ConceptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConceptsTable,
          Concept,
          $$ConceptsTableFilterComposer,
          $$ConceptsTableOrderingComposer,
          $$ConceptsTableAnnotationComposer,
          $$ConceptsTableCreateCompanionBuilder,
          $$ConceptsTableUpdateCompanionBuilder,
          (Concept, $$ConceptsTableReferences),
          Concept,
          PrefetchHooks Function({bool chapterId, bool subjectId, bool flashcardsRefs, bool quizQuestionsRefs, bool revisionsRefs})
        > {
  $$ConceptsTableTableManager(_$AppDatabase db, $ConceptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ConceptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ConceptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ConceptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> chapterId = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<String?> detailedExplanation = const Value.absent(),
                Value<String?> keyPoints = const Value.absent(),
                Value<String?> relatedConceptIds = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<int> masteryLevel = const Value.absent(),
                Value<int> importanceScore = const Value.absent(),
                Value<bool> isInterviewRelevant = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConceptsCompanion(
                id: id,
                chapterId: chapterId,
                subjectId: subjectId,
                title: title,
                summary: summary,
                detailedExplanation: detailedExplanation,
                keyPoints: keyPoints,
                relatedConceptIds: relatedConceptIds,
                tags: tags,
                masteryLevel: masteryLevel,
                importanceScore: importanceScore,
                isInterviewRelevant: isInterviewRelevant,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String chapterId,
                required String subjectId,
                required String title,
                required String summary,
                Value<String?> detailedExplanation = const Value.absent(),
                Value<String?> keyPoints = const Value.absent(),
                Value<String?> relatedConceptIds = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<int> masteryLevel = const Value.absent(),
                Value<int> importanceScore = const Value.absent(),
                Value<bool> isInterviewRelevant = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ConceptsCompanion.insert(
                id: id,
                chapterId: chapterId,
                subjectId: subjectId,
                title: title,
                summary: summary,
                detailedExplanation: detailedExplanation,
                keyPoints: keyPoints,
                relatedConceptIds: relatedConceptIds,
                tags: tags,
                masteryLevel: masteryLevel,
                importanceScore: importanceScore,
                isInterviewRelevant: isInterviewRelevant,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), $$ConceptsTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({
            chapterId = false,
            subjectId = false,
            flashcardsRefs = false,
            quizQuestionsRefs = false,
            revisionsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (flashcardsRefs) db.flashcards,
                if (quizQuestionsRefs) db.quizQuestions,
                if (revisionsRefs) db.revisions,
              ],
              addJoins: <
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
                if (chapterId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.chapterId,
                            referencedTable: $$ConceptsTableReferences._chapterIdTable(db),
                            referencedColumn: $$ConceptsTableReferences._chapterIdTable(db).id,
                          )
                          as T;
                }
                if (subjectId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$ConceptsTableReferences._subjectIdTable(db),
                            referencedColumn: $$ConceptsTableReferences._subjectIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (flashcardsRefs)
                    await $_getPrefetchedData<Concept, $ConceptsTable, Flashcard>(
                      currentTable: table,
                      referencedTable: $$ConceptsTableReferences._flashcardsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ConceptsTableReferences(db, table, p0).flashcardsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.conceptId == item.id),
                      typedResults: items,
                    ),
                  if (quizQuestionsRefs)
                    await $_getPrefetchedData<Concept, $ConceptsTable, QuizQuestion>(
                      currentTable: table,
                      referencedTable: $$ConceptsTableReferences._quizQuestionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ConceptsTableReferences(db, table, p0).quizQuestionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.conceptId == item.id),
                      typedResults: items,
                    ),
                  if (revisionsRefs)
                    await $_getPrefetchedData<Concept, $ConceptsTable, Revision>(
                      currentTable: table,
                      referencedTable: $$ConceptsTableReferences._revisionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ConceptsTableReferences(db, table, p0).revisionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where((e) => e.conceptId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ConceptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConceptsTable,
      Concept,
      $$ConceptsTableFilterComposer,
      $$ConceptsTableOrderingComposer,
      $$ConceptsTableAnnotationComposer,
      $$ConceptsTableCreateCompanionBuilder,
      $$ConceptsTableUpdateCompanionBuilder,
      (Concept, $$ConceptsTableReferences),
      Concept,
      PrefetchHooks Function({bool chapterId, bool subjectId, bool flashcardsRefs, bool quizQuestionsRefs, bool revisionsRefs})
    >;
typedef $$FlashcardsTableCreateCompanionBuilder =
    FlashcardsCompanion Function({
      required String id,
      required String conceptId,
      required String chapterId,
      required String question,
      required String answer,
      Value<String?> hint,
      Value<int> difficulty,
      Value<int> masteryLevel,
      Value<DateTime?> lastReviewedAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$FlashcardsTableUpdateCompanionBuilder =
    FlashcardsCompanion Function({
      Value<String> id,
      Value<String> conceptId,
      Value<String> chapterId,
      Value<String> question,
      Value<String> answer,
      Value<String?> hint,
      Value<int> difficulty,
      Value<int> masteryLevel,
      Value<DateTime?> lastReviewedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$FlashcardsTableReferences extends BaseReferences<_$AppDatabase, $FlashcardsTable, Flashcard> {
  $$FlashcardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ConceptsTable _conceptIdTable(_$AppDatabase db) =>
      db.concepts.createAlias($_aliasNameGenerator(db.flashcards.conceptId, db.concepts.id));

  $$ConceptsTableProcessedTableManager get conceptId {
    final $_column = $_itemColumn<String>('concept_id')!;

    final manager = $$ConceptsTableTableManager($_db, $_db.concepts).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conceptIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias($_aliasNameGenerator(db.flashcards.chapterId, db.chapters.id));

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<String>('chapter_id')!;

    final manager = $$ChaptersTableTableManager($_db, $_db.chapters).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FlashcardsTableFilterComposer extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get question => $composableBuilder(column: $table.question, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answer => $composableBuilder(column: $table.answer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hint => $composableBuilder(column: $table.hint, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get difficulty => $composableBuilder(column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get masteryLevel => $composableBuilder(column: $table.masteryLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastReviewedAt =>
      $composableBuilder(column: $table.lastReviewedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ConceptsTableFilterComposer get conceptId {
    final $$ConceptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conceptId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableFilterComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardsTableOrderingComposer extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get question => $composableBuilder(column: $table.question, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answer => $composableBuilder(column: $table.answer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hint => $composableBuilder(column: $table.hint, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get difficulty => $composableBuilder(column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get masteryLevel => $composableBuilder(column: $table.masteryLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastReviewedAt =>
      $composableBuilder(column: $table.lastReviewedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ConceptsTableOrderingComposer get conceptId {
    final $$ConceptsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conceptId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableOrderingComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardsTableAnnotationComposer extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get question => $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get answer => $composableBuilder(column: $table.answer, builder: (column) => column);

  GeneratedColumn<String> get hint => $composableBuilder(column: $table.hint, builder: (column) => column);

  GeneratedColumn<int> get difficulty => $composableBuilder(column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<int> get masteryLevel => $composableBuilder(column: $table.masteryLevel, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReviewedAt => $composableBuilder(column: $table.lastReviewedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ConceptsTableAnnotationComposer get conceptId {
    final $$ConceptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conceptId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableAnnotationComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlashcardsTable,
          Flashcard,
          $$FlashcardsTableFilterComposer,
          $$FlashcardsTableOrderingComposer,
          $$FlashcardsTableAnnotationComposer,
          $$FlashcardsTableCreateCompanionBuilder,
          $$FlashcardsTableUpdateCompanionBuilder,
          (Flashcard, $$FlashcardsTableReferences),
          Flashcard,
          PrefetchHooks Function({bool conceptId, bool chapterId})
        > {
  $$FlashcardsTableTableManager(_$AppDatabase db, $FlashcardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$FlashcardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$FlashcardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$FlashcardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> conceptId = const Value.absent(),
                Value<String> chapterId = const Value.absent(),
                Value<String> question = const Value.absent(),
                Value<String> answer = const Value.absent(),
                Value<String?> hint = const Value.absent(),
                Value<int> difficulty = const Value.absent(),
                Value<int> masteryLevel = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FlashcardsCompanion(
                id: id,
                conceptId: conceptId,
                chapterId: chapterId,
                question: question,
                answer: answer,
                hint: hint,
                difficulty: difficulty,
                masteryLevel: masteryLevel,
                lastReviewedAt: lastReviewedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String conceptId,
                required String chapterId,
                required String question,
                required String answer,
                Value<String?> hint = const Value.absent(),
                Value<int> difficulty = const Value.absent(),
                Value<int> masteryLevel = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => FlashcardsCompanion.insert(
                id: id,
                conceptId: conceptId,
                chapterId: chapterId,
                question: question,
                answer: answer,
                hint: hint,
                difficulty: difficulty,
                masteryLevel: masteryLevel,
                lastReviewedAt: lastReviewedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), $$FlashcardsTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({conceptId = false, chapterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (conceptId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.conceptId,
                            referencedTable: $$FlashcardsTableReferences._conceptIdTable(db),
                            referencedColumn: $$FlashcardsTableReferences._conceptIdTable(db).id,
                          )
                          as T;
                }
                if (chapterId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.chapterId,
                            referencedTable: $$FlashcardsTableReferences._chapterIdTable(db),
                            referencedColumn: $$FlashcardsTableReferences._chapterIdTable(db).id,
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

typedef $$FlashcardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlashcardsTable,
      Flashcard,
      $$FlashcardsTableFilterComposer,
      $$FlashcardsTableOrderingComposer,
      $$FlashcardsTableAnnotationComposer,
      $$FlashcardsTableCreateCompanionBuilder,
      $$FlashcardsTableUpdateCompanionBuilder,
      (Flashcard, $$FlashcardsTableReferences),
      Flashcard,
      PrefetchHooks Function({bool conceptId, bool chapterId})
    >;
typedef $$QuizQuestionsTableCreateCompanionBuilder =
    QuizQuestionsCompanion Function({
      required String id,
      required String conceptId,
      required String chapterId,
      required String question,
      required String optionA,
      required String optionB,
      required String optionC,
      required String optionD,
      required String correctOption,
      Value<String?> explanation,
      Value<int> difficulty,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$QuizQuestionsTableUpdateCompanionBuilder =
    QuizQuestionsCompanion Function({
      Value<String> id,
      Value<String> conceptId,
      Value<String> chapterId,
      Value<String> question,
      Value<String> optionA,
      Value<String> optionB,
      Value<String> optionC,
      Value<String> optionD,
      Value<String> correctOption,
      Value<String?> explanation,
      Value<int> difficulty,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$QuizQuestionsTableReferences extends BaseReferences<_$AppDatabase, $QuizQuestionsTable, QuizQuestion> {
  $$QuizQuestionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ConceptsTable _conceptIdTable(_$AppDatabase db) =>
      db.concepts.createAlias($_aliasNameGenerator(db.quizQuestions.conceptId, db.concepts.id));

  $$ConceptsTableProcessedTableManager get conceptId {
    final $_column = $_itemColumn<String>('concept_id')!;

    final manager = $$ConceptsTableTableManager($_db, $_db.concepts).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conceptIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias($_aliasNameGenerator(db.quizQuestions.chapterId, db.chapters.id));

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<String>('chapter_id')!;

    final manager = $$ChaptersTableTableManager($_db, $_db.chapters).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$QuizQuestionsTableFilterComposer extends Composer<_$AppDatabase, $QuizQuestionsTable> {
  $$QuizQuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get question => $composableBuilder(column: $table.question, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get optionA => $composableBuilder(column: $table.optionA, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get optionB => $composableBuilder(column: $table.optionB, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get optionC => $composableBuilder(column: $table.optionC, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get optionD => $composableBuilder(column: $table.optionD, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get correctOption => $composableBuilder(column: $table.correctOption, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get explanation => $composableBuilder(column: $table.explanation, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get difficulty => $composableBuilder(column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ConceptsTableFilterComposer get conceptId {
    final $$ConceptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conceptId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableFilterComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizQuestionsTableOrderingComposer extends Composer<_$AppDatabase, $QuizQuestionsTable> {
  $$QuizQuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get question => $composableBuilder(column: $table.question, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get optionA => $composableBuilder(column: $table.optionA, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get optionB => $composableBuilder(column: $table.optionB, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get optionC => $composableBuilder(column: $table.optionC, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get optionD => $composableBuilder(column: $table.optionD, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get correctOption =>
      $composableBuilder(column: $table.correctOption, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get explanation => $composableBuilder(column: $table.explanation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get difficulty => $composableBuilder(column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ConceptsTableOrderingComposer get conceptId {
    final $$ConceptsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conceptId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableOrderingComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizQuestionsTableAnnotationComposer extends Composer<_$AppDatabase, $QuizQuestionsTable> {
  $$QuizQuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get question => $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get optionA => $composableBuilder(column: $table.optionA, builder: (column) => column);

  GeneratedColumn<String> get optionB => $composableBuilder(column: $table.optionB, builder: (column) => column);

  GeneratedColumn<String> get optionC => $composableBuilder(column: $table.optionC, builder: (column) => column);

  GeneratedColumn<String> get optionD => $composableBuilder(column: $table.optionD, builder: (column) => column);

  GeneratedColumn<String> get correctOption => $composableBuilder(column: $table.correctOption, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(column: $table.explanation, builder: (column) => column);

  GeneratedColumn<int> get difficulty => $composableBuilder(column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ConceptsTableAnnotationComposer get conceptId {
    final $$ConceptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conceptId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableAnnotationComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizQuestionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuizQuestionsTable,
          QuizQuestion,
          $$QuizQuestionsTableFilterComposer,
          $$QuizQuestionsTableOrderingComposer,
          $$QuizQuestionsTableAnnotationComposer,
          $$QuizQuestionsTableCreateCompanionBuilder,
          $$QuizQuestionsTableUpdateCompanionBuilder,
          (QuizQuestion, $$QuizQuestionsTableReferences),
          QuizQuestion,
          PrefetchHooks Function({bool conceptId, bool chapterId})
        > {
  $$QuizQuestionsTableTableManager(_$AppDatabase db, $QuizQuestionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$QuizQuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$QuizQuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$QuizQuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> conceptId = const Value.absent(),
                Value<String> chapterId = const Value.absent(),
                Value<String> question = const Value.absent(),
                Value<String> optionA = const Value.absent(),
                Value<String> optionB = const Value.absent(),
                Value<String> optionC = const Value.absent(),
                Value<String> optionD = const Value.absent(),
                Value<String> correctOption = const Value.absent(),
                Value<String?> explanation = const Value.absent(),
                Value<int> difficulty = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuizQuestionsCompanion(
                id: id,
                conceptId: conceptId,
                chapterId: chapterId,
                question: question,
                optionA: optionA,
                optionB: optionB,
                optionC: optionC,
                optionD: optionD,
                correctOption: correctOption,
                explanation: explanation,
                difficulty: difficulty,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String conceptId,
                required String chapterId,
                required String question,
                required String optionA,
                required String optionB,
                required String optionC,
                required String optionD,
                required String correctOption,
                Value<String?> explanation = const Value.absent(),
                Value<int> difficulty = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => QuizQuestionsCompanion.insert(
                id: id,
                conceptId: conceptId,
                chapterId: chapterId,
                question: question,
                optionA: optionA,
                optionB: optionB,
                optionC: optionC,
                optionD: optionD,
                correctOption: correctOption,
                explanation: explanation,
                difficulty: difficulty,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), $$QuizQuestionsTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({conceptId = false, chapterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (conceptId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.conceptId,
                            referencedTable: $$QuizQuestionsTableReferences._conceptIdTable(db),
                            referencedColumn: $$QuizQuestionsTableReferences._conceptIdTable(db).id,
                          )
                          as T;
                }
                if (chapterId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.chapterId,
                            referencedTable: $$QuizQuestionsTableReferences._chapterIdTable(db),
                            referencedColumn: $$QuizQuestionsTableReferences._chapterIdTable(db).id,
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

typedef $$QuizQuestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuizQuestionsTable,
      QuizQuestion,
      $$QuizQuestionsTableFilterComposer,
      $$QuizQuestionsTableOrderingComposer,
      $$QuizQuestionsTableAnnotationComposer,
      $$QuizQuestionsTableCreateCompanionBuilder,
      $$QuizQuestionsTableUpdateCompanionBuilder,
      (QuizQuestion, $$QuizQuestionsTableReferences),
      QuizQuestion,
      PrefetchHooks Function({bool conceptId, bool chapterId})
    >;
typedef $$QuizAttemptsTableCreateCompanionBuilder =
    QuizAttemptsCompanion Function({
      required String id,
      required String chapterId,
      required String subjectId,
      required int score,
      required int totalQuestions,
      Value<int> timeTakenSeconds,
      Value<String?> wrongConceptIds,
      required DateTime attemptedAt,
      Value<int> rowid,
    });
typedef $$QuizAttemptsTableUpdateCompanionBuilder =
    QuizAttemptsCompanion Function({
      Value<String> id,
      Value<String> chapterId,
      Value<String> subjectId,
      Value<int> score,
      Value<int> totalQuestions,
      Value<int> timeTakenSeconds,
      Value<String?> wrongConceptIds,
      Value<DateTime> attemptedAt,
      Value<int> rowid,
    });

final class $$QuizAttemptsTableReferences extends BaseReferences<_$AppDatabase, $QuizAttemptsTable, QuizAttempt> {
  $$QuizAttemptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias($_aliasNameGenerator(db.quizAttempts.chapterId, db.chapters.id));

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<String>('chapter_id')!;

    final manager = $$ChaptersTableTableManager($_db, $_db.chapters).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias($_aliasNameGenerator(db.quizAttempts.subjectId, db.subjects.id));

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager($_db, $_db.subjects).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$QuizAttemptsTableFilterComposer extends Composer<_$AppDatabase, $QuizAttemptsTable> {
  $$QuizAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get score => $composableBuilder(column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalQuestions => $composableBuilder(column: $table.totalQuestions, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeTakenSeconds =>
      $composableBuilder(column: $table.timeTakenSeconds, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wrongConceptIds =>
      $composableBuilder(column: $table.wrongConceptIds, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get attemptedAt => $composableBuilder(column: $table.attemptedAt, builder: (column) => ColumnFilters(column));

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizAttemptsTableOrderingComposer extends Composer<_$AppDatabase, $QuizAttemptsTable> {
  $$QuizAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get score => $composableBuilder(column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalQuestions =>
      $composableBuilder(column: $table.totalQuestions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeTakenSeconds =>
      $composableBuilder(column: $table.timeTakenSeconds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wrongConceptIds =>
      $composableBuilder(column: $table.wrongConceptIds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get attemptedAt => $composableBuilder(column: $table.attemptedAt, builder: (column) => ColumnOrderings(column));

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizAttemptsTableAnnotationComposer extends Composer<_$AppDatabase, $QuizAttemptsTable> {
  $$QuizAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get score => $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get totalQuestions => $composableBuilder(column: $table.totalQuestions, builder: (column) => column);

  GeneratedColumn<int> get timeTakenSeconds => $composableBuilder(column: $table.timeTakenSeconds, builder: (column) => column);

  GeneratedColumn<String> get wrongConceptIds => $composableBuilder(column: $table.wrongConceptIds, builder: (column) => column);

  GeneratedColumn<DateTime> get attemptedAt => $composableBuilder(column: $table.attemptedAt, builder: (column) => column);

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizAttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuizAttemptsTable,
          QuizAttempt,
          $$QuizAttemptsTableFilterComposer,
          $$QuizAttemptsTableOrderingComposer,
          $$QuizAttemptsTableAnnotationComposer,
          $$QuizAttemptsTableCreateCompanionBuilder,
          $$QuizAttemptsTableUpdateCompanionBuilder,
          (QuizAttempt, $$QuizAttemptsTableReferences),
          QuizAttempt,
          PrefetchHooks Function({bool chapterId, bool subjectId})
        > {
  $$QuizAttemptsTableTableManager(_$AppDatabase db, $QuizAttemptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$QuizAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$QuizAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$QuizAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> chapterId = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<int> totalQuestions = const Value.absent(),
                Value<int> timeTakenSeconds = const Value.absent(),
                Value<String?> wrongConceptIds = const Value.absent(),
                Value<DateTime> attemptedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuizAttemptsCompanion(
                id: id,
                chapterId: chapterId,
                subjectId: subjectId,
                score: score,
                totalQuestions: totalQuestions,
                timeTakenSeconds: timeTakenSeconds,
                wrongConceptIds: wrongConceptIds,
                attemptedAt: attemptedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String chapterId,
                required String subjectId,
                required int score,
                required int totalQuestions,
                Value<int> timeTakenSeconds = const Value.absent(),
                Value<String?> wrongConceptIds = const Value.absent(),
                required DateTime attemptedAt,
                Value<int> rowid = const Value.absent(),
              }) => QuizAttemptsCompanion.insert(
                id: id,
                chapterId: chapterId,
                subjectId: subjectId,
                score: score,
                totalQuestions: totalQuestions,
                timeTakenSeconds: timeTakenSeconds,
                wrongConceptIds: wrongConceptIds,
                attemptedAt: attemptedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), $$QuizAttemptsTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({chapterId = false, subjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (chapterId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.chapterId,
                            referencedTable: $$QuizAttemptsTableReferences._chapterIdTable(db),
                            referencedColumn: $$QuizAttemptsTableReferences._chapterIdTable(db).id,
                          )
                          as T;
                }
                if (subjectId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.subjectId,
                            referencedTable: $$QuizAttemptsTableReferences._subjectIdTable(db),
                            referencedColumn: $$QuizAttemptsTableReferences._subjectIdTable(db).id,
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

typedef $$QuizAttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuizAttemptsTable,
      QuizAttempt,
      $$QuizAttemptsTableFilterComposer,
      $$QuizAttemptsTableOrderingComposer,
      $$QuizAttemptsTableAnnotationComposer,
      $$QuizAttemptsTableCreateCompanionBuilder,
      $$QuizAttemptsTableUpdateCompanionBuilder,
      (QuizAttempt, $$QuizAttemptsTableReferences),
      QuizAttempt,
      PrefetchHooks Function({bool chapterId, bool subjectId})
    >;
typedef $$RevisionsTableCreateCompanionBuilder =
    RevisionsCompanion Function({
      required String id,
      required String conceptId,
      required String chapterId,
      Value<int> intervalDays,
      Value<int> easeFactor,
      Value<int> repetitions,
      required DateTime nextRevisionAt,
      Value<DateTime?> lastRevisedAt,
      Value<int> rowid,
    });
typedef $$RevisionsTableUpdateCompanionBuilder =
    RevisionsCompanion Function({
      Value<String> id,
      Value<String> conceptId,
      Value<String> chapterId,
      Value<int> intervalDays,
      Value<int> easeFactor,
      Value<int> repetitions,
      Value<DateTime> nextRevisionAt,
      Value<DateTime?> lastRevisedAt,
      Value<int> rowid,
    });

final class $$RevisionsTableReferences extends BaseReferences<_$AppDatabase, $RevisionsTable, Revision> {
  $$RevisionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ConceptsTable _conceptIdTable(_$AppDatabase db) =>
      db.concepts.createAlias($_aliasNameGenerator(db.revisions.conceptId, db.concepts.id));

  $$ConceptsTableProcessedTableManager get conceptId {
    final $_column = $_itemColumn<String>('concept_id')!;

    final manager = $$ConceptsTableTableManager($_db, $_db.concepts).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conceptIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias($_aliasNameGenerator(db.revisions.chapterId, db.chapters.id));

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<String>('chapter_id')!;

    final manager = $$ChaptersTableTableManager($_db, $_db.chapters).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RevisionsTableFilterComposer extends Composer<_$AppDatabase, $RevisionsTable> {
  $$RevisionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intervalDays => $composableBuilder(column: $table.intervalDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get easeFactor => $composableBuilder(column: $table.easeFactor, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get repetitions => $composableBuilder(column: $table.repetitions, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextRevisionAt =>
      $composableBuilder(column: $table.nextRevisionAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastRevisedAt => $composableBuilder(column: $table.lastRevisedAt, builder: (column) => ColumnFilters(column));

  $$ConceptsTableFilterComposer get conceptId {
    final $$ConceptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conceptId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableFilterComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RevisionsTableOrderingComposer extends Composer<_$AppDatabase, $RevisionsTable> {
  $$RevisionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intervalDays => $composableBuilder(column: $table.intervalDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get easeFactor => $composableBuilder(column: $table.easeFactor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get repetitions => $composableBuilder(column: $table.repetitions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextRevisionAt =>
      $composableBuilder(column: $table.nextRevisionAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastRevisedAt =>
      $composableBuilder(column: $table.lastRevisedAt, builder: (column) => ColumnOrderings(column));

  $$ConceptsTableOrderingComposer get conceptId {
    final $$ConceptsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conceptId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableOrderingComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RevisionsTableAnnotationComposer extends Composer<_$AppDatabase, $RevisionsTable> {
  $$RevisionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get intervalDays => $composableBuilder(column: $table.intervalDays, builder: (column) => column);

  GeneratedColumn<int> get easeFactor => $composableBuilder(column: $table.easeFactor, builder: (column) => column);

  GeneratedColumn<int> get repetitions => $composableBuilder(column: $table.repetitions, builder: (column) => column);

  GeneratedColumn<DateTime> get nextRevisionAt => $composableBuilder(column: $table.nextRevisionAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRevisedAt => $composableBuilder(column: $table.lastRevisedAt, builder: (column) => column);

  $$ConceptsTableAnnotationComposer get conceptId {
    final $$ConceptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conceptId,
      referencedTable: $db.concepts,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ConceptsTableAnnotationComposer(
            $db: $db,
            $table: $db.concepts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RevisionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RevisionsTable,
          Revision,
          $$RevisionsTableFilterComposer,
          $$RevisionsTableOrderingComposer,
          $$RevisionsTableAnnotationComposer,
          $$RevisionsTableCreateCompanionBuilder,
          $$RevisionsTableUpdateCompanionBuilder,
          (Revision, $$RevisionsTableReferences),
          Revision,
          PrefetchHooks Function({bool conceptId, bool chapterId})
        > {
  $$RevisionsTableTableManager(_$AppDatabase db, $RevisionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$RevisionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$RevisionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$RevisionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> conceptId = const Value.absent(),
                Value<String> chapterId = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<int> easeFactor = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<DateTime> nextRevisionAt = const Value.absent(),
                Value<DateTime?> lastRevisedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RevisionsCompanion(
                id: id,
                conceptId: conceptId,
                chapterId: chapterId,
                intervalDays: intervalDays,
                easeFactor: easeFactor,
                repetitions: repetitions,
                nextRevisionAt: nextRevisionAt,
                lastRevisedAt: lastRevisedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String conceptId,
                required String chapterId,
                Value<int> intervalDays = const Value.absent(),
                Value<int> easeFactor = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                required DateTime nextRevisionAt,
                Value<DateTime?> lastRevisedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RevisionsCompanion.insert(
                id: id,
                conceptId: conceptId,
                chapterId: chapterId,
                intervalDays: intervalDays,
                easeFactor: easeFactor,
                repetitions: repetitions,
                nextRevisionAt: nextRevisionAt,
                lastRevisedAt: lastRevisedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), $$RevisionsTableReferences(db, table, e))).toList(),
          prefetchHooksCallback: ({conceptId = false, chapterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (conceptId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.conceptId,
                            referencedTable: $$RevisionsTableReferences._conceptIdTable(db),
                            referencedColumn: $$RevisionsTableReferences._conceptIdTable(db).id,
                          )
                          as T;
                }
                if (chapterId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.chapterId,
                            referencedTable: $$RevisionsTableReferences._chapterIdTable(db),
                            referencedColumn: $$RevisionsTableReferences._chapterIdTable(db).id,
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

typedef $$RevisionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RevisionsTable,
      Revision,
      $$RevisionsTableFilterComposer,
      $$RevisionsTableOrderingComposer,
      $$RevisionsTableAnnotationComposer,
      $$RevisionsTableCreateCompanionBuilder,
      $$RevisionsTableUpdateCompanionBuilder,
      (Revision, $$RevisionsTableReferences),
      Revision,
      PrefetchHooks Function({bool conceptId, bool chapterId})
    >;
typedef $$LearningStreaksTableCreateCompanionBuilder =
    LearningStreaksCompanion Function({
      required String id,
      Value<int> currentStreak,
      Value<int> longestStreak,
      required DateTime lastActiveDate,
      Value<String> activeDates,
      Value<int> rowid,
    });
typedef $$LearningStreaksTableUpdateCompanionBuilder =
    LearningStreaksCompanion Function({
      Value<String> id,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<DateTime> lastActiveDate,
      Value<String> activeDates,
      Value<int> rowid,
    });

class $$LearningStreaksTableFilterComposer extends Composer<_$AppDatabase, $LearningStreaksTable> {
  $$LearningStreaksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentStreak => $composableBuilder(column: $table.currentStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get longestStreak => $composableBuilder(column: $table.longestStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastActiveDate =>
      $composableBuilder(column: $table.lastActiveDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get activeDates => $composableBuilder(column: $table.activeDates, builder: (column) => ColumnFilters(column));
}

class $$LearningStreaksTableOrderingComposer extends Composer<_$AppDatabase, $LearningStreaksTable> {
  $$LearningStreaksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentStreak => $composableBuilder(column: $table.currentStreak, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get longestStreak => $composableBuilder(column: $table.longestStreak, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastActiveDate =>
      $composableBuilder(column: $table.lastActiveDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get activeDates => $composableBuilder(column: $table.activeDates, builder: (column) => ColumnOrderings(column));
}

class $$LearningStreaksTableAnnotationComposer extends Composer<_$AppDatabase, $LearningStreaksTable> {
  $$LearningStreaksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(column: $table.currentStreak, builder: (column) => column);

  GeneratedColumn<int> get longestStreak => $composableBuilder(column: $table.longestStreak, builder: (column) => column);

  GeneratedColumn<DateTime> get lastActiveDate => $composableBuilder(column: $table.lastActiveDate, builder: (column) => column);

  GeneratedColumn<String> get activeDates => $composableBuilder(column: $table.activeDates, builder: (column) => column);
}

class $$LearningStreaksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningStreaksTable,
          LearningStreak,
          $$LearningStreaksTableFilterComposer,
          $$LearningStreaksTableOrderingComposer,
          $$LearningStreaksTableAnnotationComposer,
          $$LearningStreaksTableCreateCompanionBuilder,
          $$LearningStreaksTableUpdateCompanionBuilder,
          (LearningStreak, BaseReferences<_$AppDatabase, $LearningStreaksTable, LearningStreak>),
          LearningStreak,
          PrefetchHooks Function()
        > {
  $$LearningStreaksTableTableManager(_$AppDatabase db, $LearningStreaksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$LearningStreaksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$LearningStreaksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$LearningStreaksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<DateTime> lastActiveDate = const Value.absent(),
                Value<String> activeDates = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningStreaksCompanion(
                id: id,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                lastActiveDate: lastActiveDate,
                activeDates: activeDates,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                required DateTime lastActiveDate,
                Value<String> activeDates = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningStreaksCompanion.insert(
                id: id,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                lastActiveDate: lastActiveDate,
                activeDates: activeDates,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LearningStreaksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningStreaksTable,
      LearningStreak,
      $$LearningStreaksTableFilterComposer,
      $$LearningStreaksTableOrderingComposer,
      $$LearningStreaksTableAnnotationComposer,
      $$LearningStreaksTableCreateCompanionBuilder,
      $$LearningStreaksTableUpdateCompanionBuilder,
      (LearningStreak, BaseReferences<_$AppDatabase, $LearningStreaksTable, LearningStreak>),
      LearningStreak,
      PrefetchHooks Function()
    >;
typedef $$NotificationsTableCreateCompanionBuilder =
    NotificationsCompanion Function({
      required String id,
      required String title,
      required String body,
      required String type,
      Value<bool> isRead,
      required DateTime scheduledAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$NotificationsTableUpdateCompanionBuilder =
    NotificationsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> body,
      Value<String> type,
      Value<bool> isRead,
      Value<DateTime> scheduledAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$NotificationsTableFilterComposer extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRead => $composableBuilder(column: $table.isRead, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(column: $table.scheduledAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$NotificationsTableOrderingComposer extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body => $composableBuilder(column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRead => $composableBuilder(column: $table.isRead, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(column: $table.scheduledAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$NotificationsTableAnnotationComposer extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title => $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body => $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get type => $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isRead => $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(column: $table.scheduledAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$NotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationsTable,
          Notification,
          $$NotificationsTableFilterComposer,
          $$NotificationsTableOrderingComposer,
          $$NotificationsTableAnnotationComposer,
          $$NotificationsTableCreateCompanionBuilder,
          $$NotificationsTableUpdateCompanionBuilder,
          (Notification, BaseReferences<_$AppDatabase, $NotificationsTable, Notification>),
          Notification,
          PrefetchHooks Function()
        > {
  $$NotificationsTableTableManager(_$AppDatabase db, $NotificationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$NotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$NotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$NotificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationsCompanion(
                id: id,
                title: title,
                body: body,
                type: type,
                isRead: isRead,
                scheduledAt: scheduledAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String body,
                required String type,
                Value<bool> isRead = const Value.absent(),
                required DateTime scheduledAt,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationsCompanion.insert(
                id: id,
                title: title,
                body: body,
                type: type,
                isRead: isRead,
                scheduledAt: scheduledAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationsTable,
      Notification,
      $$NotificationsTableFilterComposer,
      $$NotificationsTableOrderingComposer,
      $$NotificationsTableAnnotationComposer,
      $$NotificationsTableCreateCompanionBuilder,
      $$NotificationsTableUpdateCompanionBuilder,
      (Notification, BaseReferences<_$AppDatabase, $NotificationsTable, Notification>),
      Notification,
      PrefetchHooks Function()
    >;
typedef $$ScanHistoryEntriesTableCreateCompanionBuilder =
    ScanHistoryEntriesCompanion Function({
      required String id,
      required String chapterId,
      required String subjectId,
      required String title,
      Value<String> summarySnippet,
      Value<int> conceptCount,
      Value<int> flashcardCount,
      Value<int> quizCount,
      Value<int> pageCount,
      required DateTime scannedAt,
      Value<int> rowid,
    });
typedef $$ScanHistoryEntriesTableUpdateCompanionBuilder =
    ScanHistoryEntriesCompanion Function({
      Value<String> id,
      Value<String> chapterId,
      Value<String> subjectId,
      Value<String> title,
      Value<String> summarySnippet,
      Value<int> conceptCount,
      Value<int> flashcardCount,
      Value<int> quizCount,
      Value<int> pageCount,
      Value<DateTime> scannedAt,
      Value<int> rowid,
    });

class $$ScanHistoryEntriesTableFilterComposer extends Composer<_$AppDatabase, $ScanHistoryEntriesTable> {
  $$ScanHistoryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get chapterId => $composableBuilder(column: $table.chapterId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subjectId => $composableBuilder(column: $table.subjectId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summarySnippet => $composableBuilder(column: $table.summarySnippet, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get conceptCount => $composableBuilder(column: $table.conceptCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get flashcardCount => $composableBuilder(column: $table.flashcardCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quizCount => $composableBuilder(column: $table.quizCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pageCount => $composableBuilder(column: $table.pageCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scannedAt => $composableBuilder(column: $table.scannedAt, builder: (column) => ColumnFilters(column));
}

class $$ScanHistoryEntriesTableOrderingComposer extends Composer<_$AppDatabase, $ScanHistoryEntriesTable> {
  $$ScanHistoryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get chapterId => $composableBuilder(column: $table.chapterId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subjectId => $composableBuilder(column: $table.subjectId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summarySnippet =>
      $composableBuilder(column: $table.summarySnippet, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get conceptCount => $composableBuilder(column: $table.conceptCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get flashcardCount =>
      $composableBuilder(column: $table.flashcardCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quizCount => $composableBuilder(column: $table.quizCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pageCount => $composableBuilder(column: $table.pageCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scannedAt => $composableBuilder(column: $table.scannedAt, builder: (column) => ColumnOrderings(column));
}

class $$ScanHistoryEntriesTableAnnotationComposer extends Composer<_$AppDatabase, $ScanHistoryEntriesTable> {
  $$ScanHistoryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get chapterId => $composableBuilder(column: $table.chapterId, builder: (column) => column);

  GeneratedColumn<String> get subjectId => $composableBuilder(column: $table.subjectId, builder: (column) => column);

  GeneratedColumn<String> get title => $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get summarySnippet => $composableBuilder(column: $table.summarySnippet, builder: (column) => column);

  GeneratedColumn<int> get conceptCount => $composableBuilder(column: $table.conceptCount, builder: (column) => column);

  GeneratedColumn<int> get flashcardCount => $composableBuilder(column: $table.flashcardCount, builder: (column) => column);

  GeneratedColumn<int> get quizCount => $composableBuilder(column: $table.quizCount, builder: (column) => column);

  GeneratedColumn<int> get pageCount => $composableBuilder(column: $table.pageCount, builder: (column) => column);

  GeneratedColumn<DateTime> get scannedAt => $composableBuilder(column: $table.scannedAt, builder: (column) => column);
}

class $$ScanHistoryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScanHistoryEntriesTable,
          ScanHistoryEntry,
          $$ScanHistoryEntriesTableFilterComposer,
          $$ScanHistoryEntriesTableOrderingComposer,
          $$ScanHistoryEntriesTableAnnotationComposer,
          $$ScanHistoryEntriesTableCreateCompanionBuilder,
          $$ScanHistoryEntriesTableUpdateCompanionBuilder,
          (ScanHistoryEntry, BaseReferences<_$AppDatabase, $ScanHistoryEntriesTable, ScanHistoryEntry>),
          ScanHistoryEntry,
          PrefetchHooks Function()
        > {
  $$ScanHistoryEntriesTableTableManager(_$AppDatabase db, $ScanHistoryEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ScanHistoryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ScanHistoryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ScanHistoryEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> chapterId = const Value.absent(),
                Value<String> subjectId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> summarySnippet = const Value.absent(),
                Value<int> conceptCount = const Value.absent(),
                Value<int> flashcardCount = const Value.absent(),
                Value<int> quizCount = const Value.absent(),
                Value<int> pageCount = const Value.absent(),
                Value<DateTime> scannedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScanHistoryEntriesCompanion(
                id: id,
                chapterId: chapterId,
                subjectId: subjectId,
                title: title,
                summarySnippet: summarySnippet,
                conceptCount: conceptCount,
                flashcardCount: flashcardCount,
                quizCount: quizCount,
                pageCount: pageCount,
                scannedAt: scannedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String chapterId,
                required String subjectId,
                required String title,
                Value<String> summarySnippet = const Value.absent(),
                Value<int> conceptCount = const Value.absent(),
                Value<int> flashcardCount = const Value.absent(),
                Value<int> quizCount = const Value.absent(),
                Value<int> pageCount = const Value.absent(),
                required DateTime scannedAt,
                Value<int> rowid = const Value.absent(),
              }) => ScanHistoryEntriesCompanion.insert(
                id: id,
                chapterId: chapterId,
                subjectId: subjectId,
                title: title,
                summarySnippet: summarySnippet,
                conceptCount: conceptCount,
                flashcardCount: flashcardCount,
                quizCount: quizCount,
                pageCount: pageCount,
                scannedAt: scannedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScanHistoryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScanHistoryEntriesTable,
      ScanHistoryEntry,
      $$ScanHistoryEntriesTableFilterComposer,
      $$ScanHistoryEntriesTableOrderingComposer,
      $$ScanHistoryEntriesTableAnnotationComposer,
      $$ScanHistoryEntriesTableCreateCompanionBuilder,
      $$ScanHistoryEntriesTableUpdateCompanionBuilder,
      (ScanHistoryEntry, BaseReferences<_$AppDatabase, $ScanHistoryEntriesTable, ScanHistoryEntry>),
      ScanHistoryEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StudentProfilesTableTableManager get studentProfiles => $$StudentProfilesTableTableManager(_db, _db.studentProfiles);
  $$SubjectsTableTableManager get subjects => $$SubjectsTableTableManager(_db, _db.subjects);
  $$ChaptersTableTableManager get chapters => $$ChaptersTableTableManager(_db, _db.chapters);
  $$ConceptsTableTableManager get concepts => $$ConceptsTableTableManager(_db, _db.concepts);
  $$FlashcardsTableTableManager get flashcards => $$FlashcardsTableTableManager(_db, _db.flashcards);
  $$QuizQuestionsTableTableManager get quizQuestions => $$QuizQuestionsTableTableManager(_db, _db.quizQuestions);
  $$QuizAttemptsTableTableManager get quizAttempts => $$QuizAttemptsTableTableManager(_db, _db.quizAttempts);
  $$RevisionsTableTableManager get revisions => $$RevisionsTableTableManager(_db, _db.revisions);
  $$LearningStreaksTableTableManager get learningStreaks => $$LearningStreaksTableTableManager(_db, _db.learningStreaks);
  $$NotificationsTableTableManager get notifications => $$NotificationsTableTableManager(_db, _db.notifications);
  $$ScanHistoryEntriesTableTableManager get scanHistoryEntries => $$ScanHistoryEntriesTableTableManager(_db, _db.scanHistoryEntries);
}
