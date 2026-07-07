import 'package:drift/drift.dart';
import 'package:yaad_hai/core/database/app_database.dart';

abstract class ChaptersRepo {
  Stream<List<Chapter>> watchChaptersBySubject(String subjectId);
  Future<void> addChapter({
    required String id,
    required String subjectId,
    required String title,
    String? description,
    required int orderIndex,
  });
  Future<void> updateMastery(String id, int level);
  Future<void> updateDescription(String id, String description);
  Future<void> toggleBookmark(String id, bool isBookmarked);
  Future<Chapter?> getChapterById(String id);
  Future<void> deleteChapter(String id);
}

class ChaptersRepoImpl implements ChaptersRepo {
  final AppDatabase _db;
  ChaptersRepoImpl(this._db);

  @override
  Stream<List<Chapter>> watchChaptersBySubject(String subjectId) => _db.watchChaptersBySubject(subjectId);

  @override
  Future<Chapter?> getChapterById(String id) => _db.getChapterById(id);

  @override
  Future<void> addChapter({
    required String id,
    required String subjectId,
    required String title,
    String? description,
    required int orderIndex,
  }) => _db.upsertChapter(
    ChaptersCompanion.insert(
      id: id,
      subjectId: subjectId,
      title: title,
      description: Value(description),
      orderIndex: Value(orderIndex),
      createdAt: DateTime.now(),
    ),
  );

  @override
  Future<void> updateDescription(String id, String description) async {
    final chapter = await _db.getChapterById(id);
    if (chapter == null) return;
    await _db.upsertChapter(chapter.toCompanion(true).copyWith(description: Value(description)));
  }

  @override
  Future<void> updateMastery(String id, int level) async {
    final chapter = await _db.getChapterById(id);
    if (chapter == null) return;
    await _db.upsertChapter(chapter.toCompanion(true).copyWith(masteryLevel: Value(level)));
  }

  @override
  Future<void> toggleBookmark(String id, bool isBookmarked) async {
    // TODO: Uncomment once build_runner regenerates the schema with isBookmarked column
    // final chapter = await _db.getChapterById(id);
    // if (chapter == null) return;
    // await _db.upsertChapter(
    //   chapter.toCompanion(true).copyWith(isBookmarked: Value(isBookmarked)),
    // );
  }

  @override
  Future<void> deleteChapter(String id) => _db.deleteChapter(id);
}
