import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/subjects/repos/subjects_repo.dart';

part 'subjects_event.dart';
part 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectsEvent, SubjectsState> {
  final SubjectsRepo _repo;
  final TextEditingController nameController = TextEditingController();

  SubjectsBloc({required SubjectsRepo repo}) : _repo = repo, super(const SubjectsState()) {
    on<SubjectsEventWatch>(_onWatch);
    on<SubjectsEventAdd>(_onAdd);
    on<SubjectsEventDelete>(_onDelete);
    on<SubjectsEventChangeColor>((event, emit) => emit(state.copyWith(selectedColor: event.colorHex)));
    on<SubjectsEventChangeIcon>((event, emit) => emit(state.copyWith(selectedIcon: event.iconName)));
    on<SubjectsEventResetForm>((event, emit) {
      nameController.clear();
      emit(state.copyWith(selectedColor: '6C5CE7', selectedIcon: 'menu_book'));
    });
  }

  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }

  void _onWatch(SubjectsEventWatch event, Emitter<SubjectsState> emit) async {
    emit(state.copyWith(status: SubjectsStatus.loading));
    await emit.forEach<List<Subject>>(
      _repo.watchSubjects(),
      onData: (subjects) => state.copyWith(status: SubjectsStatus.success, subjects: subjects),
      onError: (_, _) => state.copyWith(status: SubjectsStatus.error),
    );
  }

  Future<void> _onAdd(SubjectsEventAdd event, Emitter<SubjectsState> emit) async {
    try {
      await _repo.addSubject(id: const Uuid().v4(), name: event.name, colorHex: event.colorHex, iconName: event.iconName);
    } catch (e) {
      emit(state.copyWith(status: SubjectsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onDelete(SubjectsEventDelete event, Emitter<SubjectsState> emit) async {
    try {
      await _repo.deleteSubject(event.id);
    } catch (e) {
      emit(state.copyWith(status: SubjectsStatus.error, errorMessage: e.toString()));
    }
  }
}
