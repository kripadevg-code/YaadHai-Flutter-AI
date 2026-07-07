import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/modules/scanner/bloc/scanner_bloc.dart';
import 'package:yaad_hai/modules/scanner/components/scanner_camera_view.dart';
import 'package:yaad_hai/modules/scanner/components/scanner_preview_view.dart';
import 'package:yaad_hai/modules/scanner/components/scanner_processing_view.dart';
import 'package:yaad_hai/modules/scanner/repos/scanner_repo.dart';
import 'package:yaad_hai/modules/scanner/scanner_result_page.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key, this.chapterTitle, this.chapterId, this.subjectId});
  final String? chapterTitle;
  final String? chapterId;
  final String? subjectId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = ScannerBloc(repository: locator<ScannerRepo>());
        if (chapterTitle != null) {
          bloc.titleController.text = chapterTitle!;
        }
        return bloc;
      },
      child: _ScannerView(chapterId: chapterId, subjectId: subjectId),
    );
  }
}

class _ScannerView extends StatefulWidget {
  const _ScannerView({this.chapterId, this.subjectId});
  final String? chapterId;
  final String? subjectId;

  @override
  State<_ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<_ScannerView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<ScannerBloc>().add(ScannerEventInitCamera());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final ScannerBloc bloc = context.read<ScannerBloc>();
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      bloc.add(ScannerEventDisposeCamera());
    } else if (state == AppLifecycleState.resumed && bloc.state.uiMode == ScannerUiMode.camera) {
      bloc.add(ScannerEventInitCamera());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _startProcessing(BuildContext context, ScannerState state, bool isHindi) {
    if (state.capturedPages.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.captureOnePageFirst), backgroundColor: AppColors.grey800));
      return;
    }
    final titleController = context.read<ScannerBloc>().titleController;
    final title = titleController.text.trim().isEmpty ? AppStrings.scannedContent : titleController.text.trim();
    context.read<ScannerBloc>().add(ScannerEventProcess(title, isHindi: isHindi));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScannerBloc, ScannerState>(
      listener: (context, state) {
        if (state.status == ScannerStatus.done) {
          final titleController = context.read<ScannerBloc>().titleController;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (_) => ScannerResultPage(
                    state: state,
                    chapterId: widget.chapterId,
                    subjectId: widget.subjectId,
                    chapterTitle: titleController.text.trim().isEmpty ? AppStrings.scannedContent : titleController.text.trim(),
                  ),
            ),
          );
        } else if (state.status == ScannerStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? AppStrings.scanErrorFallback,
                style: AppStyles.bodyMedium.copyWith(color: AppColors.white),
              ),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isProcessing) {
          return ScannerProcessingView(state: state);
        }

        if (state.uiMode == ScannerUiMode.camera) {
          return ScannerCameraView(
            controller: state.cameraController,
            isInitialized: state.isCameraInitialized,
            pageCount: state.pageCount,
            onCapture: () => context.read<ScannerBloc>().add(ScannerEventTakePicture()),
            onPickGallery: () => context.read<ScannerBloc>().add(ScannerEventPickGallery()),
            onRetry: () => context.read<ScannerBloc>().add(ScannerEventInitCamera()),
            onClose: () => Navigator.pop(context),
            onPreview: () => context.read<ScannerBloc>().add(ScannerEventSetUiMode(ScannerUiMode.preview)),
          );
        }

        return ScannerPreviewView(
          capturedPages: state.capturedPages,
          selectedIndex: state.selectedPreviewIndex,
          onSelectIndex: (index) => context.read<ScannerBloc>().add(ScannerEventSelectPreview(index)),
          onRemovePage: (index) => context.read<ScannerBloc>().add(ScannerEventRemovePage(index)),
          onKeepTaking: () => context.read<ScannerBloc>().add(ScannerEventSetUiMode(ScannerUiMode.camera)),
          onConfirm: (isHindi) => _startProcessing(context, state, isHindi),
          onClose: () => Navigator.pop(context),
          titleController: context.read<ScannerBloc>().titleController,
        );
      },
    );
  }
}
