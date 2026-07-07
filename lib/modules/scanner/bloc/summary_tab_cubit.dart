import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryTabState {
  final bool showAllKeyPoints;
  final Set<int> revealedQuizQuestions;
  final Set<int> flippedFlashcards;

  const SummaryTabState({this.showAllKeyPoints = false, this.revealedQuizQuestions = const {}, this.flippedFlashcards = const {}});

  SummaryTabState copyWith({bool? showAllKeyPoints, Set<int>? revealedQuizQuestions, Set<int>? flippedFlashcards}) {
    return SummaryTabState(
      showAllKeyPoints: showAllKeyPoints ?? this.showAllKeyPoints,
      revealedQuizQuestions: revealedQuizQuestions ?? this.revealedQuizQuestions,
      flippedFlashcards: flippedFlashcards ?? this.flippedFlashcards,
    );
  }
}

class SummaryTabCubit extends Cubit<SummaryTabState> {
  SummaryTabCubit() : super(const SummaryTabState());

  void toggleShowAllKeyPoints() {
    emit(state.copyWith(showAllKeyPoints: !state.showAllKeyPoints));
  }

  void toggleQuizQuestion(int index) {
    final newSet = Set<int>.from(state.revealedQuizQuestions);
    if (newSet.contains(index)) {
      newSet.remove(index);
    } else {
      newSet.add(index);
    }
    emit(state.copyWith(revealedQuizQuestions: newSet));
  }

  void toggleFlashcard(int index) {
    final newSet = Set<int>.from(state.flippedFlashcards);
    if (newSet.contains(index)) {
      newSet.remove(index);
    } else {
      newSet.add(index);
    }
    emit(state.copyWith(flippedFlashcards: newSet));
  }
}
