import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:uuid/uuid.dart';
import 'package:yaad_hai/core/ai/ai_config.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/core/ai/gemini_service.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/chapters/repos/chapters_repo.dart';
import 'package:yaad_hai/modules/concepts/repos/concepts_repo.dart';
import 'package:yaad_hai/modules/flashcards/repos/flashcards_repo.dart';
import 'package:yaad_hai/modules/quiz/repos/quiz_repo.dart';
import 'package:yaad_hai/modules/revision/repos/revision_repo.dart';
import 'package:yaad_hai/modules/scan_history/repos/scan_history_repo.dart';
import 'package:yaad_hai/modules/scanner/models/scanner_save_result.dart';
import 'package:yaad_hai/modules/subjects/repos/subjects_repo.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';

abstract class ScannerRepo {
  Future<String> extractTextFromImage(File imageFile);
  Future<StudyPackResult> generateStudyPack({required String text, required String chapterTitle});
  Future<StudyPackResult?> loadStudyPack(String chapterId);
  Future<List<Subject>> getSubjects();
  Future<Subject> ensureDefaultSubject();
  Future<ScannerSaveResult> saveStudyPack({
    required StudyPackResult studyPack,
    required String chapterTitle,
    String? chapterId,
    String? subjectId,
    int pageCount = 0,
  });
  Future<void> toggleBookmark(String chapterId, bool isBookmarked);
}

class ScannerRepoImpl implements ScannerRepo {
  ScannerRepoImpl({
    required ChaptersRepo chaptersRepository,
    required ConceptsRepo conceptsRepository,
    required FlashcardsRepo flashcardsRepository,
    required QuizRepo quizRepository,
    required SubjectsRepo subjectsRepository,
    required RevisionRepo revisionRepository,
    required ScanHistoryRepo scanHistoryRepository,
    TextRecognizer? textRecognizer,
  }) : _chaptersRepository = chaptersRepository,
       _conceptsRepository = conceptsRepository,
       _flashcardsRepository = flashcardsRepository,
       _quizRepository = quizRepository,
       _subjectsRepository = subjectsRepository,
       _revisionRepository = revisionRepository,
       _scanHistoryRepository = scanHistoryRepository,
       _textRecognizer = textRecognizer ?? TextRecognizer(script: TextRecognitionScript.latin);

  final ChaptersRepo _chaptersRepository;
  final ConceptsRepo _conceptsRepository;
  final FlashcardsRepo _flashcardsRepository;
  final QuizRepo _quizRepository;
  final SubjectsRepo _subjectsRepository;
  final RevisionRepo _revisionRepository;
  final ScanHistoryRepo _scanHistoryRepository;
  final TextRecognizer _textRecognizer;
  final Uuid _uuid = const Uuid();

  @override
  Future<String> extractTextFromImage(File imageFile) async {
    try {
      final InputImage inputImage = InputImage.fromFile(imageFile);
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage).timeout(const Duration(seconds: 2));
      if (recognizedText.text.trim().isNotEmpty) {
        return recognizedText.text;
      }
    } catch (error) {
      debugPrint('ScannerRepo ML Kit OCR failed: $error');
    }

    if (!AiConfig.isAiEnabled) return '';

    try {
      return await GeminiService.instance.extractTextFromImage(imageFile);
    } catch (error) {
      debugPrint('ScannerRepo Gemini OCR failed: $error');
      return '';
    }
  }

  @override
  Future<void> toggleBookmark(String chapterId, bool isBookmarked) {
    return _chaptersRepository.toggleBookmark(chapterId, isBookmarked);
  }

  @override
  Future<StudyPackResult> generateStudyPack({required String text, required String chapterTitle}) async {
    try {
      final String textToSend = text.length > AiConfig.maxTextChunkSize ? text.substring(0, AiConfig.maxTextChunkSize) : text;

      return await GeminiService.instance.generateStudyPack(
        text: textToSend,
        chapterTitle: chapterTitle,
        flashcardCount: AiConfig.defaultFlashcardCount,
        quizCount: AiConfig.defaultQuizCount,
      );
    } catch (error, stackTrace) {
      debugPrint('ScannerRepo generateStudyPack failed: $error');
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }

  @override
  Future<StudyPackResult?> loadStudyPack(String chapterId) async {
    try {
      final Chapter? chapter = await _chaptersRepository.getChapterById(chapterId);
      if (chapter == null) return null;

      final List<Concept> concepts = await _conceptsRepository.watchConceptsByChapter(chapterId).first;
      final List<Flashcard> flashcards = await _flashcardsRepository.watchFlashcardsByChapter(chapterId).first;
      final List<QuizQuestion> quizQuestions = await _quizRepository.getQuestionsByChapter(chapterId);

      return StudyPackResult(
        summary: chapter.description ?? '',
        keyPoints: const [],
        concepts: concepts.map(_mapConcept).toList(),
        flashcards: flashcards.map(_mapFlashcard).toList(),
        quizQuestions: quizQuestions.map(_mapQuizQuestion).toList(),
      );
    } catch (error, stackTrace) {
      debugPrint('ScannerRepo loadStudyPack failed: $error');
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }

  @override
  Future<List<Subject>> getSubjects() async {
    try {
      return await _subjectsRepository.watchSubjects().first;
    } catch (error) {
      debugPrint('ScannerRepo getSubjects failed: $error');
      return [];
    }
  }

  @override
  Future<Subject> ensureDefaultSubject() async {
    final List<Subject> subjects = await getSubjects();
    if (subjects.isNotEmpty) return subjects.first;

    final String defaultSubjectId = _uuid.v4();
    await _subjectsRepository.addSubject(
      id: defaultSubjectId,
      name: AppStrings.scannedMaterialsSubject,
      colorHex: AppStrings.scannedMaterialsColorHex,
      iconName: AppStrings.scannedMaterialsIcon,
    );

    return Subject(
      id: defaultSubjectId,
      name: AppStrings.scannedMaterialsSubject,
      colorHex: AppStrings.scannedMaterialsColorHex,
      iconName: AppStrings.scannedMaterialsIcon,
      createdAt: DateTime.now(),
      totalChapters: 0,
    );
  }

  @override
  Future<ScannerSaveResult> saveStudyPack({
    required StudyPackResult studyPack,
    required String chapterTitle,
    String? chapterId,
    String? subjectId,
    int pageCount = 0,
  }) async {
    try {
      final String resolvedSubjectId = subjectId ?? (await ensureDefaultSubject()).id;
      final String resolvedChapterId = chapterId ?? _uuid.v4();

      if (chapterId == null) {
        await _chaptersRepository.addChapter(
          id: resolvedChapterId,
          subjectId: resolvedSubjectId,
          title: chapterTitle,
          description: studyPack.summary,
          orderIndex: 0,
        );
      } else if (studyPack.summary.isNotEmpty) {
        await _chaptersRepository.updateDescription(resolvedChapterId, studyPack.summary);
      }

      final List<String> savedConceptIds = [];

      for (final ConceptData concept in studyPack.concepts) {
        final String conceptId = _uuid.v4();
        savedConceptIds.add(conceptId);
        await _conceptsRepository.addConcept(
          id: conceptId,
          chapterId: resolvedChapterId,
          subjectId: resolvedSubjectId,
          title: concept.title,
          summary: concept.summary,
          detailedExplanation: concept.detailedExplanation,
          keyPoints: jsonEncode(concept.keyPoints),
          isInterviewRelevant: concept.isInterviewRelevant,
          importanceScore: concept.importanceScore,
        );
        await _revisionRepository.ensureScheduled(conceptId: conceptId, chapterId: resolvedChapterId);
      }

      final String defaultConceptId = savedConceptIds.isNotEmpty ? savedConceptIds.first : resolvedChapterId;

      for (var index = 0; index < studyPack.flashcards.length; index++) {
        final FlashcardData flashcard = studyPack.flashcards[index];
        final String conceptId = index < savedConceptIds.length ? savedConceptIds[index] : defaultConceptId;
        await _flashcardsRepository.addFlashcard(
          id: _uuid.v4(),
          conceptId: conceptId,
          chapterId: resolvedChapterId,
          question: flashcard.question,
          answer: flashcard.answer,
          hint: flashcard.hint,
          difficulty: flashcard.difficulty,
        );
      }

      for (var index = 0; index < studyPack.quizQuestions.length; index++) {
        final QuizQuestionData quizQuestion = studyPack.quizQuestions[index];
        final String conceptId = index < savedConceptIds.length ? savedConceptIds[index] : defaultConceptId;
        await _quizRepository.addQuestion(
          conceptId: conceptId,
          chapterId: resolvedChapterId,
          question: quizQuestion.question,
          optionA: quizQuestion.optionA,
          optionB: quizQuestion.optionB,
          optionC: quizQuestion.optionC,
          optionD: quizQuestion.optionD,
          correctOption: quizQuestion.correctOption,
          explanation: quizQuestion.explanation,
          difficulty: quizQuestion.difficulty,
        );
      }

      // ── Record in scan history ──────────────────────────────────────────
      final String snippet = studyPack.summary.length > 120 ? '${studyPack.summary.substring(0, 120)}…' : studyPack.summary;
      await _scanHistoryRepository.add(
        id: _uuid.v4(),
        chapterId: resolvedChapterId,
        subjectId: resolvedSubjectId,
        title: chapterTitle,
        summarySnippet: snippet,
        conceptCount: studyPack.concepts.length,
        flashcardCount: studyPack.flashcards.length,
        quizCount: studyPack.quizQuestions.length,
        pageCount: pageCount,
      );

      return ScannerSaveResult(
        chapterId: resolvedChapterId,
        subjectId: resolvedSubjectId,
        conceptCount: studyPack.concepts.length,
        flashcardCount: studyPack.flashcards.length,
        quizCount: studyPack.quizQuestions.length,
      );
    } catch (error, stackTrace) {
      debugPrint('ScannerRepo saveStudyPack failed: $error');
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }

  ConceptData _mapConcept(Concept concept) {
    List<String> conceptKeyPoints = [];
    if (concept.keyPoints != null && concept.keyPoints!.isNotEmpty) {
      try {
        conceptKeyPoints = List<String>.from(jsonDecode(concept.keyPoints!));
      } catch (_) {}
    }

    return ConceptData(
      title: concept.title,
      summary: concept.summary,
      detailedExplanation: concept.detailedExplanation,
      keyPoints: conceptKeyPoints,
      isInterviewRelevant: concept.isInterviewRelevant,
      importanceScore: concept.importanceScore,
    );
  }

  FlashcardData _mapFlashcard(Flashcard flashcard) =>
      FlashcardData(question: flashcard.question, answer: flashcard.answer, hint: flashcard.hint, difficulty: flashcard.difficulty);

  QuizQuestionData _mapQuizQuestion(QuizQuestion quizQuestion) => QuizQuestionData(
    question: quizQuestion.question,
    optionA: quizQuestion.optionA,
    optionB: quizQuestion.optionB,
    optionC: quizQuestion.optionC,
    optionD: quizQuestion.optionD,
    correctOption: quizQuestion.correctOption,
    explanation: quizQuestion.explanation,
    difficulty: quizQuestion.difficulty,
  );
}
