part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeEventLoad extends HomeEvent {}

class HomeEventSignOut extends HomeEvent {}

class HomeEventOpenConcept extends HomeEvent {
  HomeEventOpenConcept(this.concept);

  final Concept concept;
}

class HomeEventClearNavigation extends HomeEvent {}
