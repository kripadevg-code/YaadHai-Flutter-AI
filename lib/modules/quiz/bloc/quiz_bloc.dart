// Quiz BLoC
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/quiz/repos/quiz_repo.dart';
import 'package:yaad_hai/modules/revision/repos/revision_repo.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({required QuizRepo quizRepository, required RevisionRepo revisionRepository})
    : _quizRepository = quizRepository,
      _revisionRepository = revisionRepository,
      super(const QuizState()) {
    on<QuizEventLoad>(_onLoad);
    on<QuizEventAnswer>(_onAnswer);
    on<QuizEventNext>(_onNext);
    on<QuizEventSubmit>(_onSubmit);
    on<QuizEventReset>(_onReset);
  }

  final QuizRepo _quizRepository;
  final RevisionRepo _revisionRepository;

  Future<void> _onLoad(QuizEventLoad event, Emitter<QuizState> emit) async {
    emit(state.copyWith(status: QuizStatus.loading));
    try {
      final questions = await _quizRepository.getQuestionsByChapter(event.chapterId);
      if (questions.isEmpty) {
        emit(state.copyWith(status: QuizStatus.empty));
        return;
      }
      emit(
        state.copyWith(
          status: QuizStatus.active,
          questions: questions,
          chapterId: event.chapterId,
          subjectId: event.subjectId,
          currentIndex: 0,
          answers: {},
          startTime: DateTime.now(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: QuizStatus.error, errorMessage: e.toString()));
    }
  }

  void _onAnswer(QuizEventAnswer event, Emitter<QuizState> emit) {
    final updated = Map<int, String>.from(state.answers);
    updated[state.currentIndex] = event.selectedOption;
    emit(state.copyWith(answers: updated));
  }

  void _onNext(QuizEventNext event, Emitter<QuizState> emit) {
    if (state.currentIndex < state.questions.length - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    }
  }

  Future<void> _onSubmit(QuizEventSubmit event, Emitter<QuizState> emit) async {
    emit(state.copyWith(status: QuizStatus.loading));
    try {
      int score = 0;
      final wrongConceptIds = <String>[];
      for (var i = 0; i < state.questions.length; i++) {
        final q = state.questions[i];
        final answer = state.answers[i] ?? '';
        if (answer == q.correctOption) {
          score++;
        } else {
          wrongConceptIds.add(q.conceptId);
        }
      }
      final timeTaken = DateTime.now().difference(state.startTime ?? DateTime.now()).inSeconds;

      await _quizRepository.saveAttempt(
        chapterId: state.chapterId!,
        subjectId: state.subjectId!,
        score: score,
        totalQuestions: state.questions.length,
        timeTakenSeconds: timeTaken,
        wrongConceptIds: wrongConceptIds,
      );

      for (final conceptId in wrongConceptIds.toSet()) {
        await _revisionRepository.ensureDueNow(conceptId: conceptId, chapterId: state.chapterId!);
      }

      emit(state.copyWith(status: QuizStatus.completed, score: score, wrongConceptIds: wrongConceptIds, timeTakenSeconds: timeTaken));
    } catch (e) {
      debugPrint('QuizBloc submit failed: $e');
      emit(state.copyWith(status: QuizStatus.error, errorMessage: e.toString()));
    }
  }

  // Reset re-loads with the same chapterId/subjectId so the user can retry
  Future<void> _onReset(QuizEventReset event, Emitter<QuizState> emit) async {
    final chapterId = state.chapterId;
    final subjectId = state.subjectId;
    if (chapterId != null && subjectId != null) {
      emit(const QuizState());
      add(QuizEventLoad(chapterId: chapterId, subjectId: subjectId));
    } else {
      emit(const QuizState());
    }
  }
}
