part of 'quiz_bloc.dart';

enum QuizStatus { initial, loading, active, completed, empty, error }

class QuizState {
  final List<QuizQuestion> questions;
  final Map<int, String> answers;
  final int currentIndex;
  final QuizStatus status;
  final String? chapterId;
  final String? subjectId;
  final int score;
  final List<String> wrongConceptIds;
  final int timeTakenSeconds;
  final DateTime? startTime;
  final String? errorMessage;

  const QuizState({
    this.questions = const [],
    this.answers = const {},
    this.currentIndex = 0,
    this.status = QuizStatus.initial,
    this.chapterId,
    this.subjectId,
    this.score = 0,
    this.wrongConceptIds = const [],
    this.timeTakenSeconds = 0,
    this.startTime,
    this.errorMessage,
  });

  bool get hasData => questions.isNotEmpty;
  bool get isLastQuestion => currentIndex >= questions.length - 1;
  QuizQuestion? get currentQuestion => questions.isEmpty ? null : questions[currentIndex];
  String? get selectedAnswer => answers[currentIndex];
  double get scorePercent => questions.isEmpty ? 0 : score / questions.length;

  QuizState copyWith({
    List<QuizQuestion>? questions,
    Map<int, String>? answers,
    int? currentIndex,
    QuizStatus? status,
    String? chapterId,
    String? subjectId,
    int? score,
    List<String>? wrongConceptIds,
    int? timeTakenSeconds,
    DateTime? startTime,
    String? errorMessage,
  }) => QuizState(
    questions: questions ?? this.questions,
    answers: answers ?? this.answers,
    currentIndex: currentIndex ?? this.currentIndex,
    status: status ?? this.status,
    chapterId: chapterId ?? this.chapterId,
    subjectId: subjectId ?? this.subjectId,
    score: score ?? this.score,
    wrongConceptIds: wrongConceptIds ?? this.wrongConceptIds,
    timeTakenSeconds: timeTakenSeconds ?? this.timeTakenSeconds,
    startTime: startTime ?? this.startTime,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
