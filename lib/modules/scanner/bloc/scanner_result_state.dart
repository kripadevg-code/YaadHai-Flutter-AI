part of 'scanner_result_bloc.dart';

enum ScannerResultStatus { initial, loading, ready, saving, saved, error }

class ScannerResultState {
  const ScannerResultState({
    this.status = ScannerResultStatus.initial,
    this.studyPack,
    this.isBookmarked = false,
    this.errorMessage,
    this.saveSummaryMessage,
    this.subjectsForPicker,
    this.pendingSavePack,
    this.pendingSaveChapterTitle,
    this.pendingSaveChapterId,
    this.pendingSaveSubjectId,
    this.chapterId,
  });

  final ScannerResultStatus status;
  final StudyPackResult? studyPack;
  final bool isBookmarked;
  final String? errorMessage;
  final String? saveSummaryMessage;
  final List<Subject>? subjectsForPicker;
  final StudyPackResult? pendingSavePack;
  final String? pendingSaveChapterTitle;
  final String? pendingSaveChapterId;
  final String? pendingSaveSubjectId;
  final String? chapterId;

  bool get hasStudyPack => studyPack != null;
  bool get isLoading => status == ScannerResultStatus.loading;
  bool get isSaving => status == ScannerResultStatus.saving;
  bool get isSaved => status == ScannerResultStatus.saved;
  bool get needsSubjectPicker => subjectsForPicker != null && subjectsForPicker!.isNotEmpty;

  ScannerResultState copyWith({
    ScannerResultStatus? status,
    StudyPackResult? studyPack,
    bool? isBookmarked,
    String? errorMessage,
    String? saveSummaryMessage,
    List<Subject>? subjectsForPicker,
    StudyPackResult? pendingSavePack,
    String? pendingSaveChapterTitle,
    String? pendingSaveChapterId,
    String? pendingSaveSubjectId,
    String? chapterId,
    bool clearPendingSave = false,
  }) {
    return ScannerResultState(
      status: status ?? this.status,
      studyPack: studyPack ?? this.studyPack,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      errorMessage: errorMessage,
      saveSummaryMessage: saveSummaryMessage,
      subjectsForPicker: clearPendingSave ? null : subjectsForPicker ?? this.subjectsForPicker,
      pendingSavePack: clearPendingSave ? null : pendingSavePack ?? this.pendingSavePack,
      pendingSaveChapterTitle: clearPendingSave ? null : pendingSaveChapterTitle ?? this.pendingSaveChapterTitle,
      pendingSaveChapterId: clearPendingSave ? null : pendingSaveChapterId ?? this.pendingSaveChapterId,
      pendingSaveSubjectId: clearPendingSave ? null : pendingSaveSubjectId ?? this.pendingSaveSubjectId,
      chapterId: chapterId ?? this.chapterId,
    );
  }
}
