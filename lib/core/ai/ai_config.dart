import 'package:yaad_hai/core/ai/gemini_service.dart';

/// Static AI configuration constants.
/// No API key is stored locally anymore. AI readiness is determined by whether the user
/// has an active Supabase session (handled within the edge functions).
abstract class AiConfig {
  static bool get isAiEnabled => GeminiService.isReady;

  /// Gemini model identifiers — referenced by the Edge Functions.
  static const String textModel = 'gemini-1.5-flash';
  static const String visionModel = 'gemini-1.5-flash';

  /// Maximum characters to send per AI request
  static const int maxTextChunkSize = 15000;

  /// Default generation counts.
  static const int defaultFlashcardCount = 8;
  static const int defaultQuizCount = 5;
}
