import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/chapters/repos/chapters_repo.dart';

part 'chapters_event.dart';
part 'chapters_state.dart';

class ChaptersBloc extends Bloc<ChaptersEvent, ChaptersState> {
  final ChaptersRepo _repo;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  ChaptersBloc({required ChaptersRepo repo}) : _repo = repo, super(const ChaptersState()) {
    on<ChaptersEventWatch>(_onWatch);
    on<ChaptersEventAdd>(_onAdd);
    on<ChaptersEventUpdateMastery>(_onUpdateMastery);
    on<ChaptersEventDelete>(_onDelete);
    on<ChaptersEventResetForm>((event, emit) {
      titleController.clear();
      descController.clear();
    });
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descController.dispose();
    return super.close();
  }

  void _onWatch(ChaptersEventWatch event, Emitter<ChaptersState> emit) async {
    emit(state.copyWith(status: ChaptersStatus.loading));
    await emit.forEach<List<Chapter>>(
      _repo.watchChaptersBySubject(event.subjectId),
      onData: (chapters) => state.copyWith(status: ChaptersStatus.success, chapters: chapters),
      onError: (_, _) => state.copyWith(status: ChaptersStatus.error),
    );
  }

  Future<void> _onAdd(ChaptersEventAdd event, Emitter<ChaptersState> emit) async {
    try {
      await _repo.addChapter(
        id: const Uuid().v4(),
        subjectId: event.subjectId,
        title: event.title,
        description: event.description,
        orderIndex: state.chapters.length,
      );
    } catch (e) {
      emit(state.copyWith(status: ChaptersStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateMastery(ChaptersEventUpdateMastery event, Emitter<ChaptersState> emit) async {
    try {
      await _repo.updateMastery(event.id, event.level);
    } catch (e) {
      emit(state.copyWith(status: ChaptersStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onDelete(ChaptersEventDelete event, Emitter<ChaptersState> emit) async {
    try {
      await _repo.deleteChapter(event.id);
    } catch (e) {
      emit(state.copyWith(status: ChaptersStatus.error, errorMessage: e.toString()));
    }
  }
}
