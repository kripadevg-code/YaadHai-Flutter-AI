class ScannerSaveResult {
  const ScannerSaveResult({
    required this.chapterId,
    required this.subjectId,
    required this.conceptCount,
    required this.flashcardCount,
    required this.quizCount,
  });

  final String chapterId;
  final String subjectId;
  final int conceptCount;
  final int flashcardCount;
  final int quizCount;
}
