part of 'quiz_bloc.dart';

abstract class QuizEvent {}

class QuizEventLoad extends QuizEvent {
  final String chapterId;
  final String subjectId;
  QuizEventLoad({required this.chapterId, required this.subjectId});
}

class QuizEventAnswer extends QuizEvent {
  final String selectedOption;
  QuizEventAnswer(this.selectedOption);
}

class QuizEventNext extends QuizEvent {}

class QuizEventSubmit extends QuizEvent {}

class QuizEventReset extends QuizEvent {}
