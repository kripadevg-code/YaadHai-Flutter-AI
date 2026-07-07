part of 'subjects_bloc.dart';

abstract class SubjectsEvent {}

class SubjectsEventWatch extends SubjectsEvent {}

class SubjectsEventAdd extends SubjectsEvent {
  final String name;
  final String colorHex;
  final String iconName;
  SubjectsEventAdd({required this.name, required this.colorHex, required this.iconName});
}

class SubjectsEventDelete extends SubjectsEvent {
  final String id;
  SubjectsEventDelete(this.id);
}

class SubjectsEventChangeColor extends SubjectsEvent {
  final String colorHex;
  SubjectsEventChangeColor(this.colorHex);
}

class SubjectsEventChangeIcon extends SubjectsEvent {
  final String iconName;
  SubjectsEventChangeIcon(this.iconName);
}

class SubjectsEventResetForm extends SubjectsEvent {}
