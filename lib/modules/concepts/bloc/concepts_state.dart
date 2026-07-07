part of 'concepts_bloc.dart';

enum ConceptsStatus { initial, loading, success, error }

class ConceptsState {
  final List<Concept> concepts;
  final ConceptsStatus status;
  final String? errorMessage;
  final int filterIndex;
  final bool isInterviewRelevant;
  final double importance;

  const ConceptsState({
    this.concepts = const [],
    this.status = ConceptsStatus.initial,
    this.errorMessage,
    this.filterIndex = 0,
    this.isInterviewRelevant = false,
    this.importance = 5.0,
  });

  bool get hasData => concepts.isNotEmpty;
  List<Concept> get interviewConcepts => concepts.where((c) => c.isInterviewRelevant).toList();
  List<Concept> get weakConcepts => concepts.where((c) => c.masteryLevel <= 2).toList();

  ConceptsState copyWith({
    List<Concept>? concepts,
    ConceptsStatus? status,
    String? errorMessage,
    int? filterIndex,
    bool? isInterviewRelevant,
    double? importance,
  }) => ConceptsState(
    concepts: concepts ?? this.concepts,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    filterIndex: filterIndex ?? this.filterIndex,
    isInterviewRelevant: isInterviewRelevant ?? this.isInterviewRelevant,
    importance: importance ?? this.importance,
  );
}
