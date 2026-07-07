part of 'scanner_result_bloc.dart';

abstract class ScannerResultEvent {}

class ScannerResultEventInitialize extends ScannerResultEvent {
  ScannerResultEventInitialize({this.initialPack, this.chapterId});

  final StudyPackResult? initialPack;
  final String? chapterId;
}

class ScannerResultEventBeginSave extends ScannerResultEvent {
  ScannerResultEventBeginSave({required this.studyPack, required this.chapterTitle, this.chapterId, this.subjectId});

  final StudyPackResult studyPack;
  final String chapterTitle;
  final String? chapterId;
  final String? subjectId;
}

class ScannerResultEventConfirmSaveSubject extends ScannerResultEvent {
  ScannerResultEventConfirmSaveSubject({required this.subjectId});

  final String subjectId;
}

class ScannerResultEventCancelSave extends ScannerResultEvent {}

class ScannerResultEventToggleBookmark extends ScannerResultEvent {}
