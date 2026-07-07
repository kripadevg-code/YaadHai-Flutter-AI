import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

// ─── Tables ──────────────────────────────────────────────────────────────────

class StudentProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get examTarget => text().nullable()();
  IntColumn get dailyGoalMinutes => integer().withDefault(const Constant(30))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Subjects extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get colorHex => text().withDefault(const Constant('6C5CE7'))();
  TextColumn get iconName => text().withDefault(const Constant('menu_book'))();
  IntColumn get totalChapters => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Chapters extends Table {
  TextColumn get id => text()();
  TextColumn get subjectId => text().references(Subjects, #id)();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();
  IntColumn get masteryLevel => integer().withDefault(const Constant(0))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastStudiedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isBookmarked => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class Concepts extends Table {
  TextColumn get id => text()();
  TextColumn get chapterId => text().references(Chapters, #id)();
  TextColumn get subjectId => text().references(Subjects, #id)();
  TextColumn get title => text()();
  TextColumn get summary => text()();
  TextColumn get detailedExplanation => text().nullable()();
  TextColumn get keyPoints => text().nullable()(); // JSON array string
  TextColumn get relatedConceptIds => text().nullable()(); // JSON array string
  TextColumn get tags => text().nullable()(); // JSON array string
  IntColumn get masteryLevel => integer().withDefault(const Constant(0))();
  IntColumn get importanceScore => integer().withDefault(const Constant(5))();
  BoolColumn get isInterviewRelevant => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Flashcards extends Table {
  TextColumn get id => text()();
  TextColumn get conceptId => text().references(Concepts, #id)();
  TextColumn get chapterId => text().references(Chapters, #id)();
  TextColumn get question => text()();
  TextColumn get answer => text()();
  TextColumn get hint => text().nullable()();
  IntColumn get difficulty => integer().withDefault(const Constant(2))(); // 1-5
  IntColumn get masteryLevel => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastReviewedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class QuizQuestions extends Table {
  TextColumn get id => text()();
  TextColumn get conceptId => text().references(Concepts, #id)();
  TextColumn get chapterId => text().references(Chapters, #id)();
  TextColumn get question => text()();
  TextColumn get optionA => text()();
  TextColumn get optionB => text()();
  TextColumn get optionC => text()();
  TextColumn get optionD => text()();
  TextColumn get correctOption => text()(); // 'A','B','C','D'
  TextColumn get explanation => text().nullable()();
  IntColumn get difficulty => integer().withDefault(const Constant(2))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class QuizAttempts extends Table {
  TextColumn get id => text()();
  TextColumn get chapterId => text().references(Chapters, #id)();
  TextColumn get subjectId => text().references(Subjects, #id)();
  IntColumn get score => integer()();
  IntColumn get totalQuestions => integer()();
  IntColumn get timeTakenSeconds => integer().withDefault(const Constant(0))();
  TextColumn get wrongConceptIds => text().nullable()(); // JSON array string
  DateTimeColumn get attemptedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Revisions extends Table {
  TextColumn get id => text()();
  TextColumn get conceptId => text().references(Concepts, #id)();
  TextColumn get chapterId => text().references(Chapters, #id)();
  IntColumn get intervalDays => integer().withDefault(const Constant(1))();
  IntColumn get easeFactor => integer().withDefault(const Constant(250))();
  IntColumn get repetitions => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextRevisionAt => dateTime()();
  DateTimeColumn get lastRevisedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class LearningStreaks extends Table {
  TextColumn get id => text()();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastActiveDate => dateTime()();
  TextColumn get activeDates => text().withDefault(const Constant('[]'))(); // JSON

  @override
  Set<Column> get primaryKey => {id};
}

class Notifications extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get type => text()(); // 'revision','quiz','streak','mastery'
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  DateTimeColumn get scheduledAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ScanHistoryEntries extends Table {
  TextColumn get id => text()();
  TextColumn get chapterId => text()();
  TextColumn get subjectId => text()();
  TextColumn get title => text()();
  TextColumn get summarySnippet => text().withDefault(const Constant(''))();
  IntColumn get conceptCount => integer().withDefault(const Constant(0))();
  IntColumn get flashcardCount => integer().withDefault(const Constant(0))();
  IntColumn get quizCount => integer().withDefault(const Constant(0))();
  IntColumn get pageCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get scannedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── Database ─────────────────────────────────────────────────────────────────

@DriftDatabase(
  tables: [
    StudentProfiles,
    Subjects,
    Chapters,
    Concepts,
    Flashcards,
    QuizQuestions,
    QuizAttempts,
    Revisions,
    LearningStreaks,
    Notifications,
    ScanHistoryEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 4) {
        await m.createTable(scanHistoryEntries);
      }
      if (from < 5) {
        await m.addColumn(chapters, chapters.isBookmarked as GeneratedColumn);
      }
    },
  );

  // ─── Student Profile ──────────────────────────────────────────────────────

  Future<StudentProfile?> getProfile() => select(studentProfiles).getSingleOrNull();

  Future<void> upsertProfile(StudentProfilesCompanion entry) => into(studentProfiles).insertOnConflictUpdate(entry);

  // ─── Subjects ─────────────────────────────────────────────────────────────

  Stream<List<Subject>> watchSubjects() => select(subjects).watch();

  Future<void> upsertSubject(SubjectsCompanion entry) => into(subjects).insertOnConflictUpdate(entry);

  Future<void> deleteSubject(String id) => (delete(subjects)..where((s) => s.id.equals(id))).go();

  // ─── Chapters ─────────────────────────────────────────────────────────────

  Stream<List<Chapter>> watchChaptersBySubject(String subjectId) =>
      (select(chapters)
            ..where((c) => c.subjectId.equals(subjectId))
            ..orderBy([(c) => OrderingTerm.asc(c.orderIndex)]))
          .watch();

  Future<Chapter?> getChapterById(String id) => (select(chapters)..where((c) => c.id.equals(id))).getSingleOrNull();

  Future<void> upsertChapter(ChaptersCompanion entry) => into(chapters).insertOnConflictUpdate(entry);

  Future<void> deleteChapter(String id) => (delete(chapters)..where((c) => c.id.equals(id))).go();

  // ─── Concepts ─────────────────────────────────────────────────────────────

  Stream<List<Concept>> watchConceptsByChapter(String chapterId) =>
      (select(concepts)
            ..where((c) => c.chapterId.equals(chapterId))
            ..orderBy([(c) => OrderingTerm.desc(c.importanceScore)]))
          .watch();

  Future<Concept?> getConceptById(String id) => (select(concepts)..where((c) => c.id.equals(id))).getSingleOrNull();

  Future<List<Concept>> getConceptsByChapter(String chapterId) => (select(concepts)..where((c) => c.chapterId.equals(chapterId))).get();

  Future<List<Concept>> getInterviewConcepts() => (select(concepts)..where((c) => c.isInterviewRelevant.equals(true))).get();

  Future<void> upsertConcept(ConceptsCompanion entry) => into(concepts).insertOnConflictUpdate(entry);

  Future<void> updateConceptMastery(String id, int level) async {
    await (update(concepts)..where((c) => c.id.equals(id))).write(ConceptsCompanion(masteryLevel: Value(level)));
  }

  // ─── Flashcards ───────────────────────────────────────────────────────────

  Stream<List<Flashcard>> watchFlashcardsByChapter(String chapterId) =>
      (select(flashcards)..where((f) => f.chapterId.equals(chapterId))).watch();

  Future<void> upsertFlashcard(FlashcardsCompanion entry) => into(flashcards).insertOnConflictUpdate(entry);

  // ─── Quiz ─────────────────────────────────────────────────────────────────

  Future<List<QuizQuestion>> getQuizQuestionsByChapter(String chapterId) =>
      (select(quizQuestions)..where((q) => q.chapterId.equals(chapterId))).get();

  Future<void> upsertQuizQuestion(QuizQuestionsCompanion entry) => into(quizQuestions).insertOnConflictUpdate(entry);

  Future<void> insertQuizAttempt(QuizAttemptsCompanion entry) => into(quizAttempts).insert(entry);

  Future<List<QuizAttempt>> getAttemptsByChapter(String chapterId) =>
      (select(quizAttempts)
            ..where((a) => a.chapterId.equals(chapterId))
            ..orderBy([(a) => OrderingTerm.desc(a.attemptedAt)]))
          .get();

  // ─── Revisions ────────────────────────────────────────────────────────────

  Stream<List<Revision>> watchDueRevisions() {
    final now = DateTime.now();
    return (select(revisions)
          ..where((r) => r.nextRevisionAt.isSmallerOrEqualValue(now))
          ..orderBy([(r) => OrderingTerm.asc(r.nextRevisionAt)]))
        .watch();
  }

  Future<Revision?> getRevisionById(String id) => (select(revisions)..where((r) => r.id.equals(id))).getSingleOrNull();

  Future<Revision?> getRevisionByConceptId(String conceptId) =>
      (select(revisions)..where((r) => r.conceptId.equals(conceptId))).getSingleOrNull();

  Future<void> upsertRevision(RevisionsCompanion entry) => into(revisions).insertOnConflictUpdate(entry);

  Future<List<Revision>> getRevisionsByChapter(String chapterId) => (select(revisions)..where((r) => r.chapterId.equals(chapterId))).get();

  Future<void> deleteRevisionByConceptId(String conceptId) async {
    await (delete(revisions)..where((r) => r.conceptId.equals(conceptId))).go();
  }

  // ─── Streaks ──────────────────────────────────────────────────────────────

  Future<LearningStreak?> getStreak() => select(learningStreaks).getSingleOrNull();

  Future<void> upsertStreak(LearningStreaksCompanion entry) => into(learningStreaks).insertOnConflictUpdate(entry);

  // ─── Notifications ────────────────────────────────────────────────────────

  Stream<List<Notification>> watchUnreadNotifications() => (select(notifications)..where((n) => n.isRead.equals(false))).watch();

  Future<void> insertNotification(NotificationsCompanion entry) => into(notifications).insert(entry);

  Future<void> markNotificationRead(String id) async {
    await (update(notifications)..where((n) => n.id.equals(id))).write(const NotificationsCompanion(isRead: Value(true)));
  }

  // ─── Scan History ─────────────────────────────────────────────────────────

  Stream<List<ScanHistoryEntry>> watchScanHistory() =>
      (select(scanHistoryEntries)..orderBy([(s) => OrderingTerm.desc(s.scannedAt)])).watch();

  Future<void> insertScanHistory(ScanHistoryEntriesCompanion entry) => into(scanHistoryEntries).insertOnConflictUpdate(entry);

  Future<void> deleteScanHistoryEntry(String id) => (delete(scanHistoryEntries)..where((s) => s.id.equals(id))).go();

  // ─── Analytics Helpers ────────────────────────────────────────────────────

  Future<int> getTotalConceptsCount() async {
    final count = countAll();
    final query = selectOnly(concepts)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  Future<int> getMasteredConceptsCount() async {
    final count = countAll();
    final query =
        selectOnly(concepts)
          ..addColumns([count])
          ..where(concepts.masteryLevel.isBiggerOrEqualValue(4));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  Future<List<Concept>> getWeakConcepts() =>
      (select(concepts)
            ..where((c) => c.masteryLevel.isSmallerOrEqualValue(2))
            ..orderBy([(c) => OrderingTerm.asc(c.masteryLevel)])
            ..limit(10))
          .get();
}

LazyDatabase _openConnection() => LazyDatabase(() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'yaadhai.db'));
  return NativeDatabase.createInBackground(file);
});
