import 'package:drift/drift.dart';
import 'package:yaad_hai/core/database/app_database.dart';

abstract class ConceptsRepo {
  Stream<List<Concept>> watchConceptsByChapter(String chapterId);
  Future<List<Concept>> getWeakConcepts();
  Future<void> addConcept({
    required String id,
    required String chapterId,
    required String subjectId,
    required String title,
    required String summary,
    String? detailedExplanation,
    String? keyPoints,
    bool isInterviewRelevant,
    int importanceScore,
  });
  Future<void> updateMastery(String id, int level);
  Future<void> deleteConcept(String id);
}

class ConceptsRepoImpl implements ConceptsRepo {
  final AppDatabase _db;
  ConceptsRepoImpl(this._db);

  @override
  Stream<List<Concept>> watchConceptsByChapter(String chapterId) => _db.watchConceptsByChapter(chapterId);

  @override
  Future<List<Concept>> getWeakConcepts() => _db.getWeakConcepts();

  @override
  Future<void> addConcept({
    required String id,
    required String chapterId,
    required String subjectId,
    required String title,
    required String summary,
    String? detailedExplanation,
    String? keyPoints,
    bool isInterviewRelevant = false,
    int importanceScore = 5,
  }) => _db.upsertConcept(
    ConceptsCompanion.insert(
      id: id,
      chapterId: chapterId,
      subjectId: subjectId,
      title: title,
      summary: summary,
      detailedExplanation: Value(detailedExplanation),
      keyPoints: Value(keyPoints),
      isInterviewRelevant: Value(isInterviewRelevant),
      importanceScore: Value(importanceScore),
      createdAt: DateTime.now(),
    ),
  );

  @override
  Future<void> updateMastery(String id, int level) => _db.updateConceptMastery(id, level);

  @override
  Future<void> deleteConcept(String id) async {
    await (_db.delete(_db.concepts)..where((c) => c.id.equals(id))).go();
  }
}
