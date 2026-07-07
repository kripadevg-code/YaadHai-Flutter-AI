part of 'flashcards_bloc.dart';

abstract class FlashcardsEvent {}

class FlashcardsEventWatch extends FlashcardsEvent {
  final String chapterId;
  FlashcardsEventWatch(this.chapterId);
}

class FlashcardsEventAdd extends FlashcardsEvent {
  final String conceptId;
  final String chapterId;
  final String question;
  final String answer;
  final String? hint;
  final int difficulty;
  FlashcardsEventAdd({
    required this.conceptId,
    required this.chapterId,
    required this.question,
    required this.answer,
    this.hint,
    this.difficulty = 2,
  });
}

class FlashcardsEventUpdateMastery extends FlashcardsEvent {
  final String id;
  final String conceptId;
  final String chapterId;
  final int level;
  FlashcardsEventUpdateMastery({required this.id, required this.conceptId, required this.chapterId, required this.level});
}

class FlashcardsEventNext extends FlashcardsEvent {}

class FlashcardsEventPrev extends FlashcardsEvent {}

class FlashcardsEventFlip extends FlashcardsEvent {}
