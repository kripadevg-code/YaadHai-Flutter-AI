part of 'flashcards_bloc.dart';

enum FlashcardsStatus { initial, loading, success, error }

class FlashcardsState {
  final List<Flashcard> flashcards;
  final FlashcardsStatus status;
  final String? errorMessage;
  final int currentIndex;
  final bool isFlipped;

  const FlashcardsState({
    this.flashcards = const [],
    this.status = FlashcardsStatus.initial,
    this.errorMessage,
    this.currentIndex = 0,
    this.isFlipped = false,
  });

  bool get hasData => flashcards.isNotEmpty;

  FlashcardsState copyWith({
    List<Flashcard>? flashcards,
    FlashcardsStatus? status,
    String? errorMessage,
    int? currentIndex,
    bool? isFlipped,
  }) => FlashcardsState(
    flashcards: flashcards ?? this.flashcards,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    currentIndex: currentIndex ?? this.currentIndex,
    isFlipped: isFlipped ?? this.isFlipped,
  );
}
