import 'package:drift/drift.dart';
import 'package:yaad_hai/core/database/app_database.dart';

abstract class FlashcardsRepo {
  Stream<List<Flashcard>> watchFlashcardsByChapter(String chapterId);
  Future<void> addFlashcard({
    required String id,
    required String conceptId,
    required String chapterId,
    required String question,
    required String answer,
    String? hint,
    int difficulty,
  });
  Future<void> updateMastery(String id, int level);
}

class FlashcardsRepoImpl implements FlashcardsRepo {
  final AppDatabase _db;
  FlashcardsRepoImpl(this._db);

  @override
  Stream<List<Flashcard>> watchFlashcardsByChapter(String chapterId) => _db.watchFlashcardsByChapter(chapterId);

  @override
  Future<void> addFlashcard({
    required String id,
    required String conceptId,
    required String chapterId,
    required String question,
    required String answer,
    String? hint,
    int difficulty = 2,
  }) => _db.upsertFlashcard(
    FlashcardsCompanion.insert(
      id: id,
      conceptId: conceptId,
      chapterId: chapterId,
      question: question,
      answer: answer,
      hint: Value(hint),
      difficulty: Value(difficulty),
      createdAt: DateTime.now(),
    ),
  );

  @override
  Future<void> updateMastery(String id, int level) async {
    await (_db.update(_db.flashcards)..where((f) => f.id.equals(id))).write(FlashcardsCompanion(masteryLevel: Value(level)));
  }
}
