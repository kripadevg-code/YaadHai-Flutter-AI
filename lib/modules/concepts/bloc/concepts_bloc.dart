import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/concepts/repos/concepts_repo.dart';
import 'package:yaad_hai/modules/revision/repos/revision_repo.dart';

part 'concepts_event.dart';
part 'concepts_state.dart';

class ConceptsBloc extends Bloc<ConceptsEvent, ConceptsState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();
  final TextEditingController explanationController = TextEditingController();

  ConceptsBloc({required ConceptsRepo conceptsRepository, required RevisionRepo revisionRepository})
    : _conceptsRepository = conceptsRepository,
      _revisionRepository = revisionRepository,
      super(const ConceptsState()) {
    on<ConceptsEventWatch>(_onWatch);
    on<ConceptsEventAdd>(_onAdd);
    on<ConceptsEventUpdateMastery>(_onUpdateMastery);
    on<ConceptsEventDelete>(_onDelete);
    on<ConceptsEventChangeFilter>((event, emit) => emit(state.copyWith(filterIndex: event.index)));
    on<ConceptsEventToggleInterview>((event, emit) => emit(state.copyWith(isInterviewRelevant: event.isRelevant)));
    on<ConceptsEventChangeImportance>((event, emit) => emit(state.copyWith(importance: event.importance)));
    on<ConceptsEventResetForm>((event, emit) {
      titleController.clear();
      summaryController.clear();
      explanationController.clear();
      emit(state.copyWith(isInterviewRelevant: false, importance: 5.0));
    });
  }

  final ConceptsRepo _conceptsRepository;
  final RevisionRepo _revisionRepository;

  @override
  Future<void> close() {
    titleController.dispose();
    summaryController.dispose();
    explanationController.dispose();
    return super.close();
  }

  void _onWatch(ConceptsEventWatch event, Emitter<ConceptsState> emit) async {
    emit(state.copyWith(status: ConceptsStatus.loading));
    await emit.forEach<List<Concept>>(
      _conceptsRepository.watchConceptsByChapter(event.chapterId),
      onData: (concepts) => state.copyWith(status: ConceptsStatus.success, concepts: concepts),
      onError: (_, _) => state.copyWith(status: ConceptsStatus.error),
    );
  }

  Future<void> _onAdd(ConceptsEventAdd event, Emitter<ConceptsState> emit) async {
    try {
      final String conceptId = const Uuid().v4();
      await _conceptsRepository.addConcept(
        id: conceptId,
        chapterId: event.chapterId,
        subjectId: event.subjectId,
        title: event.title,
        summary: event.summary,
        detailedExplanation: event.detailedExplanation,
        keyPoints: event.keyPoints,
        isInterviewRelevant: event.isInterviewRelevant,
        importanceScore: event.importanceScore,
      );
      await _revisionRepository.ensureScheduled(conceptId: conceptId, chapterId: event.chapterId);
    } catch (e) {
      emit(state.copyWith(status: ConceptsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateMastery(ConceptsEventUpdateMastery event, Emitter<ConceptsState> emit) async {
    try {
      await _conceptsRepository.updateMastery(event.id, event.level);
      if (event.level <= 2) {
        await _revisionRepository.ensureDueNow(conceptId: event.id, chapterId: event.chapterId);
      }
    } catch (e) {
      emit(state.copyWith(status: ConceptsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onDelete(ConceptsEventDelete event, Emitter<ConceptsState> emit) async {
    try {
      await _conceptsRepository.deleteConcept(event.id);
    } catch (e) {
      emit(state.copyWith(status: ConceptsStatus.error, errorMessage: e.toString()));
    }
  }
}
