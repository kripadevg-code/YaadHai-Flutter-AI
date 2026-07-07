part of 'revision_bloc.dart';

sealed class RevisionEvent {}

class RevisionEventWatch extends RevisionEvent {}

class RevisionEventMarkRevised extends RevisionEvent {
  RevisionEventMarkRevised({required this.revisionId, required this.quality});

  final String revisionId;
  final int quality;
}
