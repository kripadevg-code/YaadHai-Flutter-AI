part of 'onboarding_bloc.dart';

sealed class OnboardingEvent {}

class OnboardingEventComplete extends OnboardingEvent {}

class OnboardingEventNextPage extends OnboardingEvent {}
