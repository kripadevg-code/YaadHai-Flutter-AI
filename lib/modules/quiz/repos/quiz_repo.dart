import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:yaad_hai/core/database/app_database.dart';

abstract class QuizRepo {
  Future<List<QuizQuestion>> getQuestionsByChapter(String chapterId);
  Future<void> addQuestion({
    required String conceptId,
    required String chapterId,
    required String question,
    required String optionA,
    required String optionB,
    required String optionC,
    required String optionD,
    required String correctOption,
    String? explanation,
    int difficulty,
  });
  Future<void> saveAttempt({
    required String chapterId,
    required String subjectId,
    required int score,
    required int totalQuestions,
    required int timeTakenSeconds,
    required List<String> wrongConceptIds,
  });
  Future<List<QuizAttempt>> getAttemptsByChapter(String chapterId);
}

class QuizRepoImpl implements QuizRepo {
  final AppDatabase _db;
  QuizRepoImpl(this._db);

  @override
  Future<List<QuizQuestion>> getQuestionsByChapter(String chapterId) => _db.getQuizQuestionsByChapter(chapterId);

  @override
  Future<void> addQuestion({
    required String conceptId,
    required String chapterId,
    required String question,
    required String optionA,
    required String optionB,
    required String optionC,
    required String optionD,
    required String correctOption,
    String? explanation,
    int difficulty = 2,
  }) => _db.upsertQuizQuestion(
    QuizQuestionsCompanion.insert(
      id: const Uuid().v4(),
      conceptId: conceptId,
      chapterId: chapterId,
      question: question,
      optionA: optionA,
      optionB: optionB,
      optionC: optionC,
      optionD: optionD,
      correctOption: correctOption,
      explanation: Value(explanation),
      difficulty: Value(difficulty),
      createdAt: DateTime.now(),
    ),
  );

  @override
  Future<void> saveAttempt({
    required String chapterId,
    required String subjectId,
    required int score,
    required int totalQuestions,
    required int timeTakenSeconds,
    required List<String> wrongConceptIds,
  }) => _db.insertQuizAttempt(
    QuizAttemptsCompanion.insert(
      id: const Uuid().v4(),
      chapterId: chapterId,
      subjectId: subjectId,
      score: score,
      totalQuestions: totalQuestions,
      timeTakenSeconds: Value(timeTakenSeconds),
      wrongConceptIds: Value(jsonEncode(wrongConceptIds)),
      attemptedAt: DateTime.now(),
    ),
  );

  @override
  Future<List<QuizAttempt>> getAttemptsByChapter(String chapterId) => _db.getAttemptsByChapter(chapterId);
}
