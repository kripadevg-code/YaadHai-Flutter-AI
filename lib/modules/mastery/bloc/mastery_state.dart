part of 'mastery_bloc.dart';

enum MasteryStatus { initial, loading, success, error }

class MasteryState {
  final MasteryStatus status;
  final int totalConcepts;
  final int masteredConcepts;
  final List<Concept> weakConcepts;
  final LearningStreak? streak;
  final List<SubjectWithProgress> subjects;
  final String? errorMessage;

  const MasteryState({
    this.status = MasteryStatus.initial,
    this.totalConcepts = 0,
    this.masteredConcepts = 0,
    this.weakConcepts = const [],
    this.streak,
    this.subjects = const [],
    this.errorMessage,
  });

  double get masteryPercent => totalConcepts == 0 ? 0 : masteredConcepts / totalConcepts;

  int get currentStreak => streak?.currentStreak ?? 0;
  int get longestStreak => streak?.longestStreak ?? 0;

  MasteryState copyWith({
    MasteryStatus? status,
    int? totalConcepts,
    int? masteredConcepts,
    List<Concept>? weakConcepts,
    LearningStreak? streak,
    List<SubjectWithProgress>? subjects,
    String? errorMessage,
  }) => MasteryState(
    status: status ?? this.status,
    totalConcepts: totalConcepts ?? this.totalConcepts,
    masteredConcepts: masteredConcepts ?? this.masteredConcepts,
    weakConcepts: weakConcepts ?? this.weakConcepts,
    streak: streak ?? this.streak,
    subjects: subjects ?? this.subjects,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
