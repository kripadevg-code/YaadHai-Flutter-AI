import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/home/models/home_user_profile.dart';
import 'package:yaad_hai/modules/home/repos/home_repo.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required HomeRepo repository}) : _repository = repository, super(const HomeState()) {
    on<HomeEventLoad>(_onLoad);
    on<HomeEventSignOut>(_onSignOut);
    on<HomeEventOpenConcept>(_onOpenConcept);
    on<HomeEventClearNavigation>(_onClearNavigation);
  }

  final HomeRepo _repository;

  void _onLoad(HomeEventLoad event, Emitter<HomeState> emit) {
    emit(state.copyWith(status: HomeStatus.ready, profile: _repository.getCurrentUserProfile()));
  }

  Future<void> _onSignOut(HomeEventSignOut event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.signingOut));
    try {
      await _repository.signOut();
      emit(state.copyWith(status: HomeStatus.signedOut));
    } catch (error) {
      debugPrint('HomeBloc signOut failed: $error');
      emit(state.copyWith(status: HomeStatus.error, errorMessage: AppStrings.signInFailed));
    }
  }

  Future<void> _onOpenConcept(HomeEventOpenConcept event, Emitter<HomeState> emit) async {
    try {
      final Chapter? chapter = await _repository.getChapterById(event.concept.chapterId);
      if (chapter == null) {
        emit(state.copyWith(navigateToMastery: true));
        return;
      }
      emit(state.copyWith(conceptNavigationChapter: chapter));
    } catch (error) {
      debugPrint('HomeBloc openConcept failed: $error');
      emit(state.copyWith(navigateToMastery: true));
    }
  }

  void _onClearNavigation(HomeEventClearNavigation event, Emitter<HomeState> emit) {
    emit(state.copyWith(clearNavigation: true));
  }
}
