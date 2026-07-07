part of 'scanner_bloc.dart';

enum ScannerUiMode { camera, preview }

enum ScannerStatus { idle, capturing, extractingText, generatingContent, done, error }

class ScannerState {
  final List<File> capturedPages;
  final ScannerStatus status;
  final String extractedText;
  final StudyPackResult? studyPack;
  final String progressMessage;
  final String? errorMessage;
  final CameraController? cameraController;
  final bool isCameraInitialized;
  final ScannerUiMode uiMode;
  final int selectedPreviewIndex;

  const ScannerState({
    this.capturedPages = const [],
    this.status = ScannerStatus.idle,
    this.extractedText = '',
    this.studyPack,
    this.progressMessage = '',
    this.errorMessage,
    this.cameraController,
    this.isCameraInitialized = false,
    this.uiMode = ScannerUiMode.camera,
    this.selectedPreviewIndex = 0,
  });

  bool get hasPages => capturedPages.isNotEmpty;
  bool get isProcessing => status == ScannerStatus.extractingText || status == ScannerStatus.generatingContent;
  bool get hasResult => status == ScannerStatus.done && studyPack != null;
  int get pageCount => capturedPages.length;

  ScannerState copyWith({
    List<File>? capturedPages,
    ScannerStatus? status,
    String? extractedText,
    StudyPackResult? studyPack,
    String? progressMessage,
    String? errorMessage,
    CameraController? cameraController,
    bool clearCameraController = false,
    bool? isCameraInitialized,
    ScannerUiMode? uiMode,
    int? selectedPreviewIndex,
  }) => ScannerState(
    capturedPages: capturedPages ?? this.capturedPages,
    status: status ?? this.status,
    extractedText: extractedText ?? this.extractedText,
    studyPack: studyPack ?? this.studyPack,
    progressMessage: progressMessage ?? this.progressMessage,
    errorMessage: errorMessage ?? this.errorMessage,
    cameraController: clearCameraController ? null : cameraController ?? this.cameraController,
    isCameraInitialized: isCameraInitialized ?? this.isCameraInitialized,
    uiMode: uiMode ?? this.uiMode,
    selectedPreviewIndex: selectedPreviewIndex ?? this.selectedPreviewIndex,
  );
}
