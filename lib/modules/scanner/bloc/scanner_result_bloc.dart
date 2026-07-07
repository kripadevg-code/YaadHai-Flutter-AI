import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/scanner/models/scanner_save_result.dart';
import 'package:yaad_hai/modules/scanner/repos/scanner_repo.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';

part 'scanner_result_event.dart';
part 'scanner_result_state.dart';

class ScannerResultBloc extends Bloc<ScannerResultEvent, ScannerResultState> {
  ScannerResultBloc({required ScannerRepo repository}) : _repository = repository, super(const ScannerResultState()) {
    on<ScannerResultEventInitialize>(_onInitialize);
    on<ScannerResultEventBeginSave>(_onBeginSave);
    on<ScannerResultEventConfirmSaveSubject>(_onConfirmSaveSubject);
    on<ScannerResultEventCancelSave>(_onCancelSave);
    on<ScannerResultEventToggleBookmark>(_onToggleBookmark);
  }

  final ScannerRepo _repository;

  Future<void> _onInitialize(ScannerResultEventInitialize event, Emitter<ScannerResultState> emit) async {
    if (event.initialPack != null) {
      emit(state.copyWith(status: ScannerResultStatus.ready, studyPack: event.initialPack));
      return;
    }

    if (event.chapterId == null) {
      emit(state.copyWith(status: ScannerResultStatus.ready, studyPack: null));
      return;
    }

    emit(state.copyWith(status: ScannerResultStatus.loading));
    try {
      final StudyPackResult? loadedPack = await _repository.loadStudyPack(event.chapterId!);
      emit(state.copyWith(status: ScannerResultStatus.saved, studyPack: loadedPack));
    } catch (error) {
      debugPrint('ScannerResultBloc initialize failed: $error');
      emit(state.copyWith(status: ScannerResultStatus.error, errorMessage: AppStrings.studyPackLoadFailed));
    }
  }

  Future<void> _onBeginSave(ScannerResultEventBeginSave event, Emitter<ScannerResultState> emit) async {
    if (event.chapterId != null) {
      await _saveStudyPack(
        emit: emit,
        studyPack: event.studyPack,
        chapterTitle: event.chapterTitle,
        chapterId: event.chapterId,
        subjectId: event.subjectId,
      );
      return;
    }

    try {
      List<Subject> subjects = await _repository.getSubjects();
      if (subjects.isEmpty) {
        final Subject defaultSubject = await _repository.ensureDefaultSubject();
        subjects = [defaultSubject];
      }

      emit(
        state.copyWith(
          subjectsForPicker: subjects,
          pendingSavePack: event.studyPack,
          pendingSaveChapterTitle: event.chapterTitle,
          pendingSaveChapterId: event.chapterId,
          pendingSaveSubjectId: event.subjectId,
        ),
      );
    } catch (error) {
      debugPrint('ScannerResultBloc beginSave failed: $error');
      emit(state.copyWith(status: ScannerResultStatus.error, errorMessage: AppStrings.studyPackSaveFailed));
    }
  }

  Future<void> _onConfirmSaveSubject(ScannerResultEventConfirmSaveSubject event, Emitter<ScannerResultState> emit) async {
    final StudyPackResult? pendingPack = state.pendingSavePack;
    final String? pendingTitle = state.pendingSaveChapterTitle;
    if (pendingPack == null || pendingTitle == null) return;

    await _saveStudyPack(
      emit: emit,
      studyPack: pendingPack,
      chapterTitle: pendingTitle,
      chapterId: state.pendingSaveChapterId,
      subjectId: event.subjectId,
    );

    emit(state.copyWith(clearPendingSave: true));
  }

  void _onCancelSave(ScannerResultEventCancelSave event, Emitter<ScannerResultState> emit) {
    emit(state.copyWith(clearPendingSave: true));
  }

  Future<void> _saveStudyPack({
    required Emitter<ScannerResultState> emit,
    required StudyPackResult studyPack,
    required String chapterTitle,
    String? chapterId,
    String? subjectId,
  }) async {
    emit(state.copyWith(status: ScannerResultStatus.saving));
    try {
      final ScannerSaveResult saveResult = await _repository.saveStudyPack(
        studyPack: studyPack,
        chapterTitle: chapterTitle,
        chapterId: chapterId,
        subjectId: subjectId,
      );

      emit(
        state.copyWith(
          status: ScannerResultStatus.saved,
          studyPack: studyPack,
          saveSummaryMessage: AppStrings.studyPackSavedSummary(saveResult.conceptCount, saveResult.flashcardCount, saveResult.quizCount),
        ),
      );
    } catch (error) {
      debugPrint('ScannerResultBloc save failed: $error');
      emit(state.copyWith(status: ScannerResultStatus.error, errorMessage: AppStrings.studyPackSaveFailed));
    }
  }

  void _onToggleBookmark(ScannerResultEventToggleBookmark event, Emitter<ScannerResultState> emit) {
    emit(state.copyWith(isBookmarked: !state.isBookmarked));
  }
}
