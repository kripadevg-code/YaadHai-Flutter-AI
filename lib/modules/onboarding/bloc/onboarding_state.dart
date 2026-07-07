part of 'onboarding_bloc.dart';

enum OnboardingStatus { initial, loading, completed, error }

class OnboardingState {
  const OnboardingState({this.status = OnboardingStatus.initial, this.errorMessage, this.currentPage = 0});

  final OnboardingStatus status;
  final String? errorMessage;
  final int currentPage;

  OnboardingState copyWith({OnboardingStatus? status, String? errorMessage, int? currentPage}) {
    return OnboardingState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
