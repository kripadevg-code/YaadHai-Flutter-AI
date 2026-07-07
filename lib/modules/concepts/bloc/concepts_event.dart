part of 'concepts_bloc.dart';

abstract class ConceptsEvent {}

class ConceptsEventWatch extends ConceptsEvent {
  final String chapterId;
  ConceptsEventWatch(this.chapterId);
}

class ConceptsEventAdd extends ConceptsEvent {
  final String chapterId;
  final String subjectId;
  final String title;
  final String summary;
  final String? detailedExplanation;
  final String? keyPoints;
  final bool isInterviewRelevant;
  final int importanceScore;
  ConceptsEventAdd({
    required this.chapterId,
    required this.subjectId,
    required this.title,
    required this.summary,
    this.detailedExplanation,
    this.keyPoints,
    this.isInterviewRelevant = false,
    this.importanceScore = 5,
  });
}

class ConceptsEventUpdateMastery extends ConceptsEvent {
  final String id;
  final String chapterId;
  final int level;
  ConceptsEventUpdateMastery({required this.id, required this.chapterId, required this.level});
}

class ConceptsEventDelete extends ConceptsEvent {
  final String id;
  ConceptsEventDelete(this.id);
}

class ConceptsEventChangeFilter extends ConceptsEvent {
  final int index;
  ConceptsEventChangeFilter(this.index);
}

class ConceptsEventToggleInterview extends ConceptsEvent {
  final bool isRelevant;
  ConceptsEventToggleInterview(this.isRelevant);
}

class ConceptsEventChangeImportance extends ConceptsEvent {
  final double importance;
  ConceptsEventChangeImportance(this.importance);
}

class ConceptsEventResetForm extends ConceptsEvent {}
