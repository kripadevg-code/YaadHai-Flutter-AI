// Scanner BLoC — manages multi-page capture, OCR, and AI study pack generation
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yaad_hai/core/ai/ai_config.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/modules/scanner/repos/scanner_repo.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc({required ScannerRepo repository}) : _repository = repository, super(const ScannerState()) {
    on<ScannerEventAddPage>(_onAddPage);
    on<ScannerEventRemovePage>(_onRemovePage);
    on<ScannerEventProcess>(_onProcess);
    on<ScannerEventReset>(_onReset);
    on<ScannerEventInitCamera>(_onInitCamera);
    on<ScannerEventDisposeCamera>(_onDisposeCamera);
    on<ScannerEventTakePicture>(_onTakePicture);
    on<ScannerEventPickGallery>(_onPickGallery);
    on<ScannerEventSetUiMode>(_onSetUiMode);
    on<ScannerEventSelectPreview>(_onSelectPreview);
  }

  final ScannerRepo _repository;
  final titleController = TextEditingController();
  final _picker = ImagePicker();

  @override
  Future<void> close() {
    titleController.dispose();
    state.cameraController?.dispose();
    return super.close();
  }

  Future<void> _onInitCamera(ScannerEventInitCamera event, Emitter<ScannerState> emit) async {
    if (state.isCameraInitialized) return;

    final PermissionStatus status = await Permission.camera.request();
    if (!status.isGranted) {
      emit(state.copyWith(status: ScannerStatus.error, errorMessage: AppStrings.cameraPermissionDenied));
      return;
    }

    try {
      final List<CameraDescription> cameras = await availableCameras();
      if (cameras.isEmpty) {
        emit(state.copyWith(status: ScannerStatus.error, errorMessage: AppStrings.cameraUnavailable));
        return;
      }

      final CameraDescription camera = cameras.firstWhere(
        (item) => item.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      final CameraController controller = CameraController(camera, ResolutionPreset.high, enableAudio: false);
      await controller.initialize();
      emit(state.copyWith(cameraController: controller, isCameraInitialized: true, status: ScannerStatus.idle));
    } on CameraException catch (error) {
      debugPrint('ScannerBloc camera initialization failed: ${error.code}');
      emit(
        state.copyWith(
          status: ScannerStatus.error,
          errorMessage: error.code == 'CameraAccessDenied' ? AppStrings.cameraPermissionDenied : AppStrings.cameraUnavailable,
        ),
      );
    } catch (error) {
      debugPrint('ScannerBloc camera initialization failed: $error');
      emit(state.copyWith(status: ScannerStatus.error, errorMessage: AppStrings.cameraUnavailable));
    }
  }

  Future<void> _onDisposeCamera(ScannerEventDisposeCamera event, Emitter<ScannerState> emit) async {
    await state.cameraController?.dispose();
    emit(state.copyWith(clearCameraController: true, isCameraInitialized: false));
  }

  Future<void> _onTakePicture(ScannerEventTakePicture event, Emitter<ScannerState> emit) async {
    final controller = state.cameraController;
    if (controller == null || !state.isCameraInitialized) return;
    if (controller.value.isTakingPicture) return;

    try {
      final file = await controller.takePicture();
      final updated = [...state.capturedPages, File(file.path)];
      emit(
        state.copyWith(
          capturedPages: updated,
          status: ScannerStatus.capturing,
          uiMode: ScannerUiMode.preview,
          selectedPreviewIndex: updated.length - 1,
        ),
      );
    } catch (error) {
      debugPrint('Error taking picture in BLoC: $error');
    }
  }

  Future<void> _onPickGallery(ScannerEventPickGallery event, Emitter<ScannerState> emit) async {
    try {
      final images = await _picker.pickMultiImage(imageQuality: 85);
      if (images.isNotEmpty) {
        final updated = [...state.capturedPages];
        for (final image in images) {
          updated.add(File(image.path));
        }
        emit(
          state.copyWith(
            capturedPages: updated,
            status: ScannerStatus.capturing,
            uiMode: ScannerUiMode.preview,
            selectedPreviewIndex: updated.length - 1,
          ),
        );
      }
    } catch (error) {
      debugPrint('Error picking from gallery in BLoC: $error');
    }
  }

  void _onSetUiMode(ScannerEventSetUiMode event, Emitter<ScannerState> emit) {
    emit(state.copyWith(uiMode: event.mode));
  }

  void _onSelectPreview(ScannerEventSelectPreview event, Emitter<ScannerState> emit) {
    emit(state.copyWith(selectedPreviewIndex: event.index));
  }

  void _onAddPage(ScannerEventAddPage event, Emitter<ScannerState> emit) {
    final updated = [...state.capturedPages, event.file];
    emit(state.copyWith(capturedPages: updated, status: ScannerStatus.capturing, selectedPreviewIndex: updated.length - 1));
  }

  void _onRemovePage(ScannerEventRemovePage event, Emitter<ScannerState> emit) {
    final updated = [...state.capturedPages]..removeAt(event.index);
    final newIndex = state.selectedPreviewIndex.clamp(0, updated.isEmpty ? 0 : updated.length - 1);
    emit(
      state.copyWith(capturedPages: updated, selectedPreviewIndex: newIndex, uiMode: updated.isEmpty ? ScannerUiMode.camera : state.uiMode),
    );
  }

  Future<void> _onProcess(ScannerEventProcess event, Emitter<ScannerState> emit) async {
    if (state.capturedPages.isEmpty) return;

    emit(state.copyWith(status: ScannerStatus.extractingText, progressMessage: AppStrings.processingImages));

    try {
      final StringBuffer textBuffer = StringBuffer();
      for (var index = 0; index < state.capturedPages.length; index++) {
        emit(state.copyWith(progressMessage: AppStrings.processingPageProgress(index + 1, state.capturedPages.length)));

        final String pageText = await _repository.extractTextFromImage(state.capturedPages[index]);
        if (pageText.isNotEmpty) {
          textBuffer.writeln(pageText);
          textBuffer.writeln('\n');
        }
      }

      final String rawText = textBuffer.toString().trim();
      if (rawText.isEmpty) {
        emit(state.copyWith(status: ScannerStatus.error, errorMessage: AppStrings.ocrExtractionFailed));
        return;
      }

      final String fullText =
          event.isHindi
              ? 'IMPORTANT: You MUST generate all output fields (summary, keyPoints, concepts, detailedExplanation, flashcards, quizQuestions, question, options, answer explanation, etc.) strictly in Hindi language using Devanagari script. Do not write in English except for English technical terms in brackets. Translate everything into Hindi.\n\n$rawText'
              : rawText;

      emit(state.copyWith(extractedText: rawText, status: ScannerStatus.generatingContent, progressMessage: AppStrings.analyzingContent));

      if (!AiConfig.isAiEnabled) {
        emit(state.copyWith(status: ScannerStatus.done, progressMessage: AppStrings.aiDisabledDone));
        return;
      }

      emit(state.copyWith(progressMessage: AppStrings.finalizingPack));

      final StudyPackResult pack = await _repository.generateStudyPack(text: fullText, chapterTitle: event.chapterTitle);

      emit(state.copyWith(status: ScannerStatus.done, studyPack: pack, progressMessage: AppStrings.studyPackReady));
    } catch (error, stackTrace) {
      debugPrint('ScannerBloc process failed: $error');
      debugPrint(stackTrace.toString());
      emit(state.copyWith(status: ScannerStatus.error, errorMessage: '${AppStrings.scanProcessFailed}: $error'));
    }
  }

  void _onReset(ScannerEventReset event, Emitter<ScannerState> emit) {
    emit(const ScannerState());
  }
}
