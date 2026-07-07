import 'package:yaad_hai/core/database/app_database.dart';

class RevisionItem {
  const RevisionItem({required this.revision, required this.conceptTitle, required this.chapterTitle, this.conceptSummary});

  final Revision revision;
  final String conceptTitle;
  final String chapterTitle;
  final String? conceptSummary;

  String get id => revision.id;
  int get repetitions => revision.repetitions;
}
