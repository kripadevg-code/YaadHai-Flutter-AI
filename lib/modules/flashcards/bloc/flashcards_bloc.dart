// Flashcards BLoC
import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/flashcards/repos/flashcards_repo.dart';
import 'package:yaad_hai/modules/revision/repos/revision_repo.dart';

part 'flashcards_event.dart';
part 'flashcards_state.dart';

class FlashcardsBloc extends Bloc<FlashcardsEvent, FlashcardsState> {
  FlashcardsBloc({required FlashcardsRepo flashcardsRepository, required RevisionRepo revisionRepository})
    : _flashcardsRepository = flashcardsRepository,
      _revisionRepository = revisionRepository,
      super(const FlashcardsState()) {
    on<FlashcardsEventWatch>(_onWatch);
    on<FlashcardsEventAdd>(_onAdd);
    on<FlashcardsEventUpdateMastery>(_onUpdateMastery);
    on<FlashcardsEventNext>((event, emit) {
      if (state.currentIndex < state.flashcards.length - 1) {
        emit(state.copyWith(currentIndex: state.currentIndex + 1, isFlipped: false));
      }
    });
    on<FlashcardsEventPrev>((event, emit) {
      if (state.currentIndex > 0) {
        emit(state.copyWith(currentIndex: state.currentIndex - 1, isFlipped: false));
      }
    });
    on<FlashcardsEventFlip>((event, emit) {
      emit(state.copyWith(isFlipped: !state.isFlipped));
    });
  }

  final FlashcardsRepo _flashcardsRepository;
  final RevisionRepo _revisionRepository;

  void _onWatch(FlashcardsEventWatch event, Emitter<FlashcardsState> emit) async {
    emit(state.copyWith(status: FlashcardsStatus.loading));
    await emit.forEach<List<Flashcard>>(
      _flashcardsRepository.watchFlashcardsByChapter(event.chapterId),
      onData: (cards) => state.copyWith(status: FlashcardsStatus.success, flashcards: cards, currentIndex: 0, isFlipped: false),
      onError: (_, _) => state.copyWith(status: FlashcardsStatus.error),
    );
  }

  Future<void> _onAdd(FlashcardsEventAdd event, Emitter<FlashcardsState> emit) async {
    try {
      await _flashcardsRepository.addFlashcard(
        id: const Uuid().v4(),
        conceptId: event.conceptId,
        chapterId: event.chapterId,
        question: event.question,
        answer: event.answer,
        hint: event.hint,
        difficulty: event.difficulty,
      );
      await _revisionRepository.ensureScheduled(conceptId: event.conceptId, chapterId: event.chapterId);
    } catch (e) {
      emit(state.copyWith(status: FlashcardsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateMastery(FlashcardsEventUpdateMastery event, Emitter<FlashcardsState> emit) async {
    try {
      await _flashcardsRepository.updateMastery(event.id, event.level);
      if (event.level <= 2) {
        await _revisionRepository.ensureDueNow(conceptId: event.conceptId, chapterId: event.chapterId);
      }
    } catch (e) {
      emit(state.copyWith(status: FlashcardsStatus.error, errorMessage: e.toString()));
    }
  }
}
