part of 'subjects_bloc.dart';

enum SubjectsStatus { initial, loading, success, error }

class SubjectsState {
  final List<Subject> subjects;
  final SubjectsStatus status;
  final String? errorMessage;
  final String selectedColor;
  final String selectedIcon;

  const SubjectsState({
    this.subjects = const [],
    this.status = SubjectsStatus.initial,
    this.errorMessage,
    this.selectedColor = '6C5CE7',
    this.selectedIcon = 'menu_book',
  });

  bool get hasData => subjects.isNotEmpty;

  SubjectsState copyWith({
    List<Subject>? subjects,
    SubjectsStatus? status,
    String? errorMessage,
    String? selectedColor,
    String? selectedIcon,
  }) => SubjectsState(
    subjects: subjects ?? this.subjects,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    selectedColor: selectedColor ?? this.selectedColor,
    selectedIcon: selectedIcon ?? this.selectedIcon,
  );
}
