import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/modules/scanner/bloc/scanner_bloc.dart';
import 'package:yaad_hai/modules/scanner/bloc/scanner_result_bloc.dart';
import 'package:yaad_hai/modules/scanner/components/concepts_tab.dart';
import 'package:yaad_hai/modules/scanner/components/flashcards_tab.dart';
import 'package:yaad_hai/modules/scanner/components/quiz_tab.dart';
import 'package:yaad_hai/modules/scanner/components/scanner_subject_picker_sheet.dart';
import 'package:yaad_hai/modules/scanner/components/study_pack_header.dart';
import 'package:yaad_hai/modules/scanner/components/summary_tab.dart';
import 'package:yaad_hai/modules/scanner/components/text_only_view.dart';
import 'package:yaad_hai/modules/scanner/components/visual_knowledge_tree.dart';
import 'package:yaad_hai/modules/scanner/repos/scanner_repo.dart';
import 'package:yaad_hai/modules/scanner/services/pdf_export_service.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ScannerResultPage extends StatelessWidget {
  const ScannerResultPage({super.key, required this.state, this.chapterId, this.subjectId, required this.chapterTitle});

  final ScannerState state;
  final String? chapterId;
  final String? subjectId;
  final String chapterTitle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              ScannerResultBloc(repository: locator<ScannerRepo>())
                ..add(ScannerResultEventInitialize(initialPack: state.studyPack, chapterId: chapterId)),
      child: _ScannerResultView(scannerState: state, chapterId: chapterId, subjectId: subjectId, chapterTitle: chapterTitle),
    );
  }
}

class _ScannerResultView extends StatelessWidget {
  _ScannerResultView({required this.scannerState, required this.chapterTitle, this.chapterId, this.subjectId});

  final ScannerState scannerState;
  final String? chapterId;
  final String? subjectId;
  final String chapterTitle;
  final PdfExportService _pdfService = PdfExportService();

  void _onSaveTap(BuildContext context, StudyPackResult pack) {
    context.read<ScannerResultBloc>().add(
      ScannerResultEventBeginSave(studyPack: pack, chapterTitle: chapterTitle, chapterId: chapterId, subjectId: subjectId),
    );
  }

  Future<void> _onDownloadTap(BuildContext context, StudyPackResult pack) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: Dimens.icon20,
                height: Dimens.icon20,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white),
              ),
              SizedBox(width: Dimens.w12),
              Text(AppStrings.generatingPdf),
            ],
          ),
          duration: const Duration(seconds: 10),
          behavior: SnackBarBehavior.floating,
        ),
      );

      await _pdfService.downloadPdf(pack: pack, title: chapterTitle);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.pdfDownloaded), behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 2)),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppStrings.somethingWentWrong}: $e'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _onShareTap(BuildContext context, StudyPackResult pack) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: Dimens.icon20,
                height: Dimens.icon20,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white),
              ),
              SizedBox(width: Dimens.w12),
              Text(AppStrings.preparingToShare),
            ],
          ),
          duration: const Duration(seconds: 10),
          behavior: SnackBarBehavior.floating,
        ),
      );

      await _pdfService.sharePdf(pack: pack, title: chapterTitle);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppStrings.somethingWentWrong}: $e'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: BlocConsumer<ScannerResultBloc, ScannerResultState>(
        listenWhen: (previous, current) => previous.subjectsForPicker == null && current.subjectsForPicker != null,
        listener: (context, resultState) async {
          if (!resultState.needsSubjectPicker) return;

          final String? selectedSubjectId = await ScannerSubjectPickerSheet.show(context, resultState.subjectsForPicker!);
          if (!context.mounted) return;

          if (selectedSubjectId == null) {
            context.read<ScannerResultBloc>().add(ScannerResultEventCancelSave());
            return;
          }

          context.read<ScannerResultBloc>().add(ScannerResultEventConfirmSaveSubject(subjectId: selectedSubjectId));
        },
        builder: (context, resultState) {
          return _ScannerResultScaffold(
            resultState: resultState,
            scannerState: scannerState,
            chapterId: chapterId,
            chapterTitle: chapterTitle,
            onSaveTap: _onSaveTap,
            onDownloadTap: (pack) => _onDownloadTap(context, pack),
            onShareTap: (pack) => _onShareTap(context, pack),
          );
        },
      ),
    );
  }
}

class _ScannerResultScaffold extends StatelessWidget {
  const _ScannerResultScaffold({
    required this.resultState,
    required this.scannerState,
    required this.chapterId,
    required this.chapterTitle,
    required this.onSaveTap,
    required this.onDownloadTap,
    required this.onShareTap,
  });

  final ScannerResultState resultState;
  final ScannerState scannerState;
  final String? chapterId;
  final String chapterTitle;
  final void Function(BuildContext context, StudyPackResult pack) onSaveTap;
  final Future<void> Function(StudyPackResult pack) onDownloadTap;
  final Future<void> Function(StudyPackResult pack) onShareTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final StudyPackResult? pack = resultState.studyPack;
    final bool hasAiPack = pack != null;

    return BlocListener<ScannerResultBloc, ScannerResultState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!), backgroundColor: AppColors.error));
        }

        if (state.saveSummaryMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle_rounded, color: AppColors.success, size: Dimens.icon20),
                  SizedBox(width: Dimens.w8),
                  Expanded(child: Text(state.saveSummaryMessage!)),
                ],
              ),
              backgroundColor: theme.cardColor,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      },
      child:
          resultState.isLoading
              ? AppScaffold(title: AppStrings.scanStudyMaterial, body: const Center(child: CircularProgressIndicator()))
              : !hasAiPack
              ? AppScaffold(title: AppStrings.studyPackReady, body: TextOnlyView(text: scannerState.extractedText))
              : AppScaffold(
                title: AppStrings.studyPackReady,
                actions: [
                  if (!resultState.isSaved && !resultState.isSaving)
                    TextButton.icon(
                      onPressed: () => onSaveTap(context, pack),
                      icon: Icon(Icons.save_rounded, size: Dimens.icon20, color: isDarkTheme ? AppColors.white : AppColors.primary),
                      label: Text(AppStrings.saveAction, style: TextStyle(color: isDarkTheme ? AppColors.white : AppColors.primary)),
                    ),
                  if (resultState.isSaving)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.w16),
                      child: Row(
                        children: [
                          SizedBox(width: Dimens.icon16, height: Dimens.icon16, child: const CircularProgressIndicator(strokeWidth: 2)),
                          SizedBox(width: Dimens.w8),
                          Text(
                            AppStrings.saving,
                            style: AppStyles.labelMedium.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey800),
                          ),
                        ],
                      ),
                    ),
                  if (resultState.isSaved)
                    Padding(
                      padding: EdgeInsets.only(right: Dimens.w16),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_rounded, color: AppColors.success, size: Dimens.icon20),
                          SizedBox(width: Dimens.w4),
                          Text(AppStrings.saved, style: AppStyles.labelMedium.copyWith(color: AppColors.success)),
                        ],
                      ),
                    ),
                ],
                slivers: [
                  SliverToBoxAdapter(
                    child: StudyPackHeader(
                      chapterTitle: chapterTitle,
                      pack: pack,
                      isBookmarked: resultState.isBookmarked,
                      onDownload: () => onDownloadTap(pack),
                      onShare: () => onShareTap(pack),
                      onBookmark: () => context.read<ScannerResultBloc>().add(ScannerResultEventToggleBookmark()),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverTabBarDelegate(
                      child: Container(
                        color: isDarkTheme ? AppColors.darkBackground : AppColors.grey50,
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimens.w16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDarkTheme ? AppColors.darkSurface : AppColors.grey100,
                              borderRadius: BorderRadius.circular(Dimens.r16),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: TabBar(
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              dividerColor: AppColors.transparent,
                              labelColor: isDarkTheme ? AppColors.white : AppColors.primary,
                              unselectedLabelColor: isDarkTheme ? AppColors.grey400 : AppColors.grey600,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: isDarkTheme ? AppColors.grey800 : AppColors.white,
                                borderRadius: BorderRadius.circular(Dimens.r12),
                                boxShadow:
                                    isDarkTheme
                                        ? null
                                        : [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.04),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                            // ignore: deprecated_member_use
                                          ),
                                        ],
                              ),
                              labelStyle: AppStyles.labelLarge.copyWith(fontWeight: FontWeight.w700),
                              tabs: [
                                const Tab(text: 'Visual'),
                                Tab(text: AppStrings.tabSummary),
                                Tab(text: AppStrings.tabConcepts),
                                Tab(text: AppStrings.tabFlashcards),
                                Tab(text: AppStrings.tabQuiz),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                body: TabBarView(
                  children: [
                    VisualKnowledgeTree(concepts: pack.concepts, pack: pack),
                    SummaryTab(
                      pack: pack,
                      chapterTitle: chapterTitle,
                      onViewAllFlashcards: () => DefaultTabController.of(context).animateTo(3),
                    ),
                    ConceptsTab(pack: pack),
                    FlashcardsTab(pack: pack),
                    QuizTab(pack: pack),
                  ],
                ),
              ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate({required this.child});
  final Widget child;

  @override
  double get minExtent => Dimens.tabBarHeight;
  @override
  double get maxExtent => Dimens.tabBarHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
