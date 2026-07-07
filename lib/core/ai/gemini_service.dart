import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yaad_hai/core/ai/ai_config.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';

/// Central AI service — delegates all requests to Supabase Edge Functions.
/// The `google_generative_ai` SDK is fully removed from the client to eliminate
/// deprecated dependencies and securely proxy all API calls.
class GeminiService {
  GeminiService._internal();
  static final GeminiService instance = GeminiService._internal();

  final _functions = Supabase.instance.client.functions;

  /// AI is ready as long as the user is authenticated.
  static bool get isReady => Supabase.instance.client.auth.currentSession != null;

  // ── OCR ─────────────────────────────────────────────────────────────────────

  Future<String> extractTextFromImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final res = await _functions.invoke('gemini-vision', body: {'base64Image': base64Image, 'mimeType': 'image/jpeg'});
      return res.data['text'] as String? ?? '';
    } catch (e) {
      throw AiException('OCR failed via Edge Function: $e');
    }
  }

  // ── Study Pack ───────────────────────────────────────────────────────────────

  Future<StudyPackResult> generateStudyPack({
    required String text,
    required String chapterTitle,
    int? flashcardCount,
    int? quizCount,
  }) async {
    if (text.trim().isEmpty) return StudyPackResult.empty();
    try {
      final res = await _functions.invoke(
        'gemini-generate',
        body: {
          'action': 'generateStudyPack',
          'text': text,
          'chapterTitle': chapterTitle,
          'flashcardCount': flashcardCount ?? AiConfig.defaultFlashcardCount,
          'quizCount': quizCount ?? AiConfig.defaultQuizCount,
        },
      );

      final rawData = res.data;
      if (rawData is! Map<String, dynamic>) {
        return _parseStudyPack(jsonEncode(rawData));
      }
      return _parseStudyPackFromMap(rawData);
    } catch (e) {
      throw AiException('Study pack generation failed: $e');
    }
  }

  // ── Flashcards ───────────────────────────────────────────────────────────────

  Future<List<FlashcardData>> generateFlashcards({required String text, int? count}) async {
    if (text.trim().isEmpty) return [];
    try {
      final res = await _functions.invoke(
        'gemini-generate',
        body: {'action': 'generateFlashcards', 'text': text, 'flashcardCount': count ?? AiConfig.defaultFlashcardCount},
      );

      final rawData = res.data;
      final parsedList = rawData is List ? rawData : jsonDecode(rawData as String) as List;
      return parsedList.map((e) => FlashcardData.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw AiException('Flashcard generation failed: $e');
    }
  }

  // ── Quiz ─────────────────────────────────────────────────────────────────────

  Future<List<QuizQuestionData>> generateQuiz({required String text, int? count}) async {
    if (text.trim().isEmpty) return [];
    try {
      final res = await _functions.invoke(
        'gemini-generate',
        body: {'action': 'generateQuiz', 'text': text, 'quizCount': count ?? AiConfig.defaultQuizCount},
      );

      final rawData = res.data;
      final parsedList = rawData is List ? rawData : jsonDecode(rawData as String) as List;
      return parsedList.map((e) => QuizQuestionData.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw AiException('Quiz generation failed: $e');
    }
  }

  // ── Explain Concept ───────────────────────────────────────────────────────────

  Future<String> explainConcept({required String conceptTitle, required String context}) async {
    try {
      final res = await _functions.invoke(
        'gemini-generate',
        body: {'action': 'explainConcept', 'conceptTitle': conceptTitle, 'text': context},
      );
      return res.data['text'] as String? ?? '';
    } catch (e) {
      throw AiException('Concept explanation failed: $e');
    }
  }

  // ── Translate to Hindi ────────────────────────────────────────────────────────

  /// Translates the given [text] to simple, student-friendly Hindi.
  /// Returns the original [text] on failure so the UI never breaks.
  Future<String> translateToHindi(String text) async {
    if (text.trim().isEmpty) return text;
    try {
      final res = await _functions.invoke('gemini-generate', body: {'action': 'translateToHindi', 'text': text});
      return res.data['text'] as String? ?? text;
    } catch (e) {
      return text; // silent fallback — English stays visible
    }
  }

  // ── Parsing Helpers ───────────────────────────────────────────────────────────

  StudyPackResult _parseStudyPackFromMap(Map<String, dynamic> data) {
    try {
      return StudyPackResult(
        summary: data['summary'] as String? ?? '',
        keyPoints: (data['keyPoints'] as List? ?? []).map((e) => e.toString()).toList(),
        concepts: (data['concepts'] as List? ?? []).map((e) => ConceptData.fromJson(e as Map<String, dynamic>)).toList(),
        flashcards: (data['flashcards'] as List? ?? []).map((e) => FlashcardData.fromJson(e as Map<String, dynamic>)).toList(),
        quizQuestions: (data['quiz'] as List? ?? []).map((e) => QuizQuestionData.fromJson(e as Map<String, dynamic>)).toList(),
      );
    } catch (e, st) {
      debugPrint('StudyPack Parsing Error: $e\n$st');
      return StudyPackResult.empty();
    }
  }

  StudyPackResult _parseStudyPack(String jsonText) {
    try {
      final data = jsonDecode(jsonText) as Map<String, dynamic>;
      return _parseStudyPackFromMap(data);
    } catch (_) {
      return StudyPackResult.empty();
    }
  }
}

class AiException implements Exception {
  const AiException(this.message);
  final String message;
  @override
  String toString() => 'AiException: $message';
}
