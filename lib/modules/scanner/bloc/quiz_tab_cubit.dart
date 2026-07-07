import 'package:flutter_bloc/flutter_bloc.dart';

class QuizTabState {
  final int current;
  final String? selectedAnswer;
  final bool answered;
  final int score;
  final bool completed;

  const QuizTabState({this.current = 0, this.selectedAnswer, this.answered = false, this.score = 0, this.completed = false});

  QuizTabState copyWith({int? current, String? selectedAnswer, bool? answered, int? score, bool? completed}) {
    return QuizTabState(
      current: current ?? this.current,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      answered: answered ?? this.answered,
      score: score ?? this.score,
      completed: completed ?? this.completed,
    );
  }
}

class QuizTabCubit extends Cubit<QuizTabState> {
  QuizTabCubit() : super(const QuizTabState());

  void selectAnswer(String option) {
    if (!state.answered) {
      emit(state.copyWith(selectedAnswer: option));
    }
  }

  void checkAnswer(bool isCorrect) {
    emit(state.copyWith(answered: true, score: isCorrect ? state.score + 1 : state.score));
  }

  void nextQuestion(int totalQuestions) {
    if (state.current < totalQuestions - 1) {
      emit(state.copyWith(current: state.current + 1, selectedAnswer: null, answered: false));
    } else {
      emit(state.copyWith(completed: true));
    }
  }
}
