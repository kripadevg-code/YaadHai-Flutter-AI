import 'package:drift/drift.dart';
import 'package:yaad_hai/core/database/app_database.dart';

abstract class ScanHistoryRepo {
  Stream<List<ScanHistoryEntry>> watchAll();
  Future<void> add({
    required String id,
    required String chapterId,
    required String subjectId,
    required String title,
    required String summarySnippet,
    required int conceptCount,
    required int flashcardCount,
    required int quizCount,
    required int pageCount,
  });
  Future<void> delete(String id);
}

class ScanHistoryRepoImpl implements ScanHistoryRepo {
  ScanHistoryRepoImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<ScanHistoryEntry>> watchAll() => _db.watchScanHistory();

  @override
  Future<void> add({
    required String id,
    required String chapterId,
    required String subjectId,
    required String title,
    required String summarySnippet,
    required int conceptCount,
    required int flashcardCount,
    required int quizCount,
    required int pageCount,
  }) => _db.insertScanHistory(
    ScanHistoryEntriesCompanion.insert(
      id: id,
      chapterId: chapterId,
      subjectId: subjectId,
      title: title,
      summarySnippet: Value(summarySnippet),
      conceptCount: Value(conceptCount),
      flashcardCount: Value(flashcardCount),
      quizCount: Value(quizCount),
      pageCount: Value(pageCount),
      scannedAt: DateTime.now(),
    ),
  );

  @override
  Future<void> delete(String id) => _db.deleteScanHistoryEntry(id);
}
