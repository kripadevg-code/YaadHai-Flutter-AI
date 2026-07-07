import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/mastery/models/subject_with_progress.dart';

abstract class MasteryRepo {
  Future<int> getTotalConceptsCount();
  Future<int> getMasteredConceptsCount();
  Future<List<Concept>> getWeakConcepts();
  Future<LearningStreak?> getStreak();
  Future<List<SubjectWithProgress>> getAllSubjectsWithProgress();
  Future<void> recordStudyActivity();
}

class MasteryRepoImpl implements MasteryRepo {
  final AppDatabase _database;
  MasteryRepoImpl(this._database);

  @override
  Future<int> getTotalConceptsCount() => _database.getTotalConceptsCount();

  @override
  Future<int> getMasteredConceptsCount() => _database.getMasteredConceptsCount();

  @override
  Future<List<Concept>> getWeakConcepts() => _database.getWeakConcepts();

  @override
  Future<LearningStreak?> getStreak() => _database.getStreak();

  @override
  Future<List<SubjectWithProgress>> getAllSubjectsWithProgress() async {
    final subjects = await _database.select(_database.subjects).get();
    final concepts = await _database.select(_database.concepts).get();

    final Map<String, List<Concept>> conceptsBySubject = {};
    for (final concept in concepts) {
      conceptsBySubject.putIfAbsent(concept.subjectId, () => []).add(concept);
    }

    final List<SubjectWithProgress> results = [];
    for (final subject in subjects) {
      final subjectConcepts = conceptsBySubject[subject.id] ?? const [];
      final totalConcepts = subjectConcepts.length;
      final masteredConcepts = subjectConcepts.where((concept) => concept.masteryLevel >= 4).length;
      final masteryPercent = totalConcepts == 0 ? 0.0 : masteredConcepts / totalConcepts;

      results.add(SubjectWithProgress(subject: subject, masteryPercent: masteryPercent));
    }
    return results;
  }

  @override
  Future<void> recordStudyActivity() async {
    try {
      const String streakId = 'default';
      final DateTime today = DateTime.now();
      final DateTime todayDate = DateTime(today.year, today.month, today.day);
      final LearningStreak? existing = await _database.getStreak();

      if (existing == null) {
        await _database.upsertStreak(
          LearningStreaksCompanion.insert(
            id: streakId,
            currentStreak: const Value(1),
            longestStreak: const Value(1),
            lastActiveDate: todayDate,
            activeDates: Value(jsonEncode([todayDate.toIso8601String()])),
          ),
        );
        return;
      }

      final DateTime lastActiveDate = DateTime(existing.lastActiveDate.year, existing.lastActiveDate.month, existing.lastActiveDate.day);
      final int dayGap = todayDate.difference(lastActiveDate).inDays;
      if (dayGap == 0) return;

      final int currentStreak = dayGap == 1 ? existing.currentStreak + 1 : 1;
      final int longestStreak = currentStreak > existing.longestStreak ? currentStreak : existing.longestStreak;

      final List<String> activeDates = _decodeActiveDates(existing.activeDates);
      activeDates.add(todayDate.toIso8601String());

      await _database.upsertStreak(
        LearningStreaksCompanion(
          id: const Value(streakId),
          currentStreak: Value(currentStreak),
          longestStreak: Value(longestStreak),
          lastActiveDate: Value(todayDate),
          activeDates: Value(jsonEncode(activeDates)),
        ),
      );
    } catch (error) {
      debugPrint('MasteryRepo recordStudyActivity failed: $error');
      rethrow;
    }
  }

  List<String> _decodeActiveDates(String raw) {
    try {
      return List<String>.from(jsonDecode(raw) as List);
    } catch (_) {
      return [];
    }
  }
}
