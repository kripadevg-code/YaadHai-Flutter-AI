part of 'revision_bloc.dart';

enum RevisionStatus { initial, loading, success, error }

class RevisionState {
  const RevisionState({this.revisionItems = const [], this.status = RevisionStatus.initial, this.errorMessage});

  final List<RevisionItem> revisionItems;
  final RevisionStatus status;
  final String? errorMessage;

  bool get hasData => revisionItems.isNotEmpty;
  int get dueCount => revisionItems.length;

  RevisionState copyWith({List<RevisionItem>? revisionItems, RevisionStatus? status, String? errorMessage}) {
    return RevisionState(
      revisionItems: revisionItems ?? this.revisionItems,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
