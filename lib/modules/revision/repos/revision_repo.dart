import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/mastery/repos/mastery_repo.dart';
import 'package:yaad_hai/modules/revision/models/revision_item.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';

abstract class RevisionRepo {
  Stream<List<RevisionItem>> watchDueRevisionItems();
  Future<List<Revision>> getRevisionsByChapter(String chapterId);
  Future<void> ensureScheduled({required String conceptId, required String chapterId});
  Future<void> ensureDueNow({required String conceptId, required String chapterId});
  Future<void> scheduleRevisionsForChapter(String chapterId);
  Future<void> markRevised(String revisionId, int quality);
}

class RevisionRepoImpl implements RevisionRepo {
  RevisionRepoImpl({required AppDatabase database, required MasteryRepo masteryRepository})
    : _database = database,
      _masteryRepository = masteryRepository;

  final AppDatabase _database;
  final MasteryRepo _masteryRepository;
  final Uuid _uuid = const Uuid();

  @override
  Stream<List<RevisionItem>> watchDueRevisionItems() {
    return _database.watchDueRevisions().asyncMap(_mapRevisionItems);
  }

  @override
  Future<List<Revision>> getRevisionsByChapter(String chapterId) => _database.getRevisionsByChapter(chapterId);

  @override
  Future<void> ensureScheduled({required String conceptId, required String chapterId}) async {
    try {
      final Revision? existing = await _database.getRevisionByConceptId(conceptId);
      if (existing != null) return;

      await _database.upsertRevision(
        RevisionsCompanion.insert(id: _uuid.v4(), conceptId: conceptId, chapterId: chapterId, nextRevisionAt: DateTime.now()),
      );
    } catch (error) {
      debugPrint('RevisionRepo ensureScheduled failed: $error');
      rethrow;
    }
  }

  @override
  Future<void> ensureDueNow({required String conceptId, required String chapterId}) async {
    try {
      final Revision? existing = await _database.getRevisionByConceptId(conceptId);
      if (existing != null) {
        await _database.upsertRevision(
          RevisionsCompanion(
            id: Value(existing.id),
            conceptId: Value(existing.conceptId),
            chapterId: Value(existing.chapterId),
            intervalDays: Value(existing.intervalDays),
            easeFactor: Value(existing.easeFactor),
            repetitions: Value(existing.repetitions),
            nextRevisionAt: Value(DateTime.now()),
            lastRevisedAt: Value(existing.lastRevisedAt),
          ),
        );
        return;
      }

      await ensureScheduled(conceptId: conceptId, chapterId: chapterId);
    } catch (error) {
      debugPrint('RevisionRepo ensureDueNow failed: $error');
      rethrow;
    }
  }

  @override
  Future<void> scheduleRevisionsForChapter(String chapterId) async {
    try {
      final List<Concept> concepts = await _database.getConceptsByChapter(chapterId);
      for (final Concept concept in concepts) {
        await ensureScheduled(conceptId: concept.id, chapterId: chapterId);
      }
    } catch (error) {
      debugPrint('RevisionRepo scheduleRevisionsForChapter failed: $error');
      rethrow;
    }
  }

  /// SM-2 algorithm: quality 0–5 (0–2 = fail, 3–5 = pass)
  @override
  Future<void> markRevised(String revisionId, int quality) async {
    try {
      final Revision? revision = await _database.getRevisionById(revisionId);
      if (revision == null) return;

      int repetitions = revision.repetitions;
      int easeFactor = revision.easeFactor;
      int intervalDays;

      if (quality >= 3) {
        intervalDays = switch (repetitions) {
          0 => 1,
          1 => 6,
          _ => (revision.intervalDays * (easeFactor / 100)).round(),
        };
        repetitions++;
        easeFactor = (easeFactor + (5 - quality) * 8 - (5 - quality) * 2).clamp(130, 400);
      } else {
        intervalDays = 1;
        repetitions = 0;
      }

      await _database.upsertRevision(
        RevisionsCompanion(
          id: Value(revisionId),
          conceptId: Value(revision.conceptId),
          chapterId: Value(revision.chapterId),
          intervalDays: Value(intervalDays),
          easeFactor: Value(easeFactor),
          repetitions: Value(repetitions),
          nextRevisionAt: Value(DateTime.now().add(Duration(days: intervalDays))),
          lastRevisedAt: Value(DateTime.now()),
        ),
      );

      await _masteryRepository.recordStudyActivity();

      if (quality >= 3) {
        final int masteryLevel = switch (quality) {
          3 => 2,
          4 => 3,
          _ => 4,
        };
        await _database.updateConceptMastery(revision.conceptId, masteryLevel);
      } else {
        await _database.updateConceptMastery(revision.conceptId, 1);
      }
    } catch (error) {
      debugPrint('RevisionRepo markRevised failed: $error');
      rethrow;
    }
  }

  Future<List<RevisionItem>> _mapRevisionItems(List<Revision> revisions) async {
    if (revisions.isEmpty) return const [];

    // ── Batch load all needed concepts and chapters in 2 queries ──────────
    final conceptIds = revisions.map((r) => r.conceptId).toSet().toList();
    final chapterIds = revisions.map((r) => r.chapterId).toSet().toList();

    final List<Concept?> conceptList = await Future.wait(conceptIds.map((id) => _database.getConceptById(id)));
    final List<Chapter?> chapterList = await Future.wait(chapterIds.map((id) => _database.getChapterById(id)));

    final Map<String, Concept> conceptMap = {for (final c in conceptList.whereType<Concept>()) c.id: c};
    final Map<String, Chapter> chapterMap = {for (final c in chapterList.whereType<Chapter>()) c.id: c};

    return revisions.map((revision) {
      final concept = conceptMap[revision.conceptId];
      final chapter = chapterMap[revision.chapterId];
      return RevisionItem(
        revision: revision,
        conceptTitle: concept?.title ?? AppStrings.unknownConcept,
        chapterTitle: chapter?.title ?? AppStrings.unknownChapter,
        conceptSummary: concept?.summary,
      );
    }).toList();
  }
}
