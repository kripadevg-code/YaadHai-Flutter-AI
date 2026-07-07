// Plain Dart model classes for AI-generated study content.
// These are the structured outputs from Gemini API calls.

class StudyPackResult {
  final String summary;
  final List<String> keyPoints;
  final List<ConceptData> concepts;
  final List<FlashcardData> flashcards;
  final List<QuizQuestionData> quizQuestions;

  const StudyPackResult({
    this.summary = '',
    this.keyPoints = const [],
    this.concepts = const [],
    this.flashcards = const [],
    this.quizQuestions = const [],
  });

  factory StudyPackResult.empty() => const StudyPackResult();
}

class ConceptData {
  final String title;
  final String summary;
  final String? detailedExplanation;
  final List<String> keyPoints;
  final bool isInterviewRelevant;
  final int importanceScore;

  const ConceptData({
    required this.title,
    required this.summary,
    this.detailedExplanation,
    this.keyPoints = const [],
    this.isInterviewRelevant = false,
    this.importanceScore = 5,
  });

  factory ConceptData.fromJson(Map<String, dynamic> json) => ConceptData(
    title: json['title'] as String? ?? 'Untitled',
    summary: json['summary'] as String? ?? '',
    detailedExplanation: json['explanation'] as String?,
    keyPoints: (json['keyPoints'] as List?)?.map((e) => e.toString()).toList() ?? [],
    isInterviewRelevant: json['isInterviewRelevant'] as bool? ?? false,
    importanceScore: (json['importanceScore'] as num?)?.toInt() ?? 5,
  );
}

class FlashcardData {
  final String question;
  final String answer;
  final String? hint;
  final int difficulty;

  const FlashcardData({required this.question, required this.answer, this.hint, this.difficulty = 2});

  factory FlashcardData.fromJson(Map<String, dynamic> json) => FlashcardData(
    question: json['question'] as String? ?? '',
    answer: json['answer'] as String? ?? '',
    hint: json['hint'] as String?,
    difficulty: (json['difficulty'] as num?)?.toInt() ?? 2,
  );
}

class QuizQuestionData {
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correctOption;
  final String? explanation;
  final int difficulty;

  const QuizQuestionData({
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctOption,
    this.explanation,
    this.difficulty = 2,
  });

  factory QuizQuestionData.fromJson(Map<String, dynamic> json) => QuizQuestionData(
    question: json['question'] as String? ?? '',
    optionA: json['optionA'] as String? ?? '',
    optionB: json['optionB'] as String? ?? '',
    optionC: json['optionC'] as String? ?? '',
    optionD: json['optionD'] as String? ?? '',
    correctOption: json['correctOption'] as String? ?? 'A',
    explanation: json['explanation'] as String?,
    difficulty: (json['difficulty'] as num?)?.toInt() ?? 2,
  );
}
