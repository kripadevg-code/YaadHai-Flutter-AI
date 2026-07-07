import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:yaad_hai/modules/onboarding/repos/onboarding_repo.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({required OnboardingRepo repository}) : _repository = repository, super(const OnboardingState()) {
    on<OnboardingEventComplete>(_onComplete);
    on<OnboardingEventNextPage>(_onNextPage);
  }

  final OnboardingRepo _repository;

  void _onNextPage(OnboardingEventNextPage event, Emitter<OnboardingState> emit) {
    if (state.currentPage < 2) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  Future<void> _onComplete(OnboardingEventComplete event, Emitter<OnboardingState> emit) async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    try {
      await _repository.markOnboardingComplete();
      emit(state.copyWith(status: OnboardingStatus.completed));
    } catch (error) {
      debugPrint('OnboardingBloc complete failed: $error');
      emit(state.copyWith(status: OnboardingStatus.error, errorMessage: AppStrings.somethingWentWrong));
    }
  }
}
