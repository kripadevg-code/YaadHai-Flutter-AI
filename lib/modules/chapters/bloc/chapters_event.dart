part of 'chapters_bloc.dart';

abstract class ChaptersEvent {}

class ChaptersEventWatch extends ChaptersEvent {
  final String subjectId;
  ChaptersEventWatch(this.subjectId);
}

class ChaptersEventAdd extends ChaptersEvent {
  final String subjectId;
  final String title;
  final String? description;
  ChaptersEventAdd({required this.subjectId, required this.title, this.description});
}

class ChaptersEventUpdateMastery extends ChaptersEvent {
  final String id;
  final int level;
  ChaptersEventUpdateMastery({required this.id, required this.level});
}

class ChaptersEventDelete extends ChaptersEvent {
  final String id;
  ChaptersEventDelete(this.id);
}

class ChaptersEventResetForm extends ChaptersEvent {}
