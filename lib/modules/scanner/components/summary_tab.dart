import 'package:flutter/material.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/modules/scanner/components/summary_executive_card.dart';
import 'package:yaad_hai/modules/scanner/components/summary_flashcards_section.dart';
import 'package:yaad_hai/modules/scanner/components/summary_key_takeaways_card.dart';
import 'package:yaad_hai/modules/scanner/components/summary_memory_hook_builder.dart';
import 'package:yaad_hai/modules/scanner/components/summary_memory_hooks_card.dart';
import 'package:yaad_hai/modules/scanner/components/summary_quick_recall_card.dart';
import 'package:yaad_hai/modules/scanner/components/summary_responsive_row.dart';
import 'package:yaad_hai/modules/scanner/components/summary_study_tip_footer.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/modules/scanner/bloc/summary_tab_cubit.dart';

class SummaryTab extends StatelessWidget {
  const SummaryTab({super.key, required this.pack, required this.chapterTitle, this.onViewAllFlashcards});

  final StudyPackResult pack;
  final String chapterTitle;
  final VoidCallback? onViewAllFlashcards;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SummaryTabCubit(),
      child: _SummaryTabView(pack: pack, chapterTitle: chapterTitle, onViewAllFlashcards: onViewAllFlashcards),
    );
  }
}

class _SummaryTabView extends StatelessWidget {
  const _SummaryTabView({required this.pack, required this.chapterTitle, this.onViewAllFlashcards});

  final StudyPackResult pack;
  final String chapterTitle;
  final VoidCallback? onViewAllFlashcards;

  List<String> get _allKeyPoints {
    if (pack.keyPoints.isNotEmpty) return pack.keyPoints;
    return pack.concepts.expand((concept) => concept.keyPoints.isNotEmpty ? concept.keyPoints : [concept.title]).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SummaryTabCubit, SummaryTabState>(
      builder: (context, state) {
        final cubit = context.read<SummaryTabCubit>();
        final isWide = MediaQuery.of(context).size.width > 600;

        return SingleChildScrollView(
          padding: EdgeInsets.all(Dimens.w20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SummaryExecutiveCard(summary: pack.summary),
              if (pack.summary.isNotEmpty) SizedBox(height: Dimens.h20),

              SummaryKeyTakeawaysCard(
                keyPoints: _allKeyPoints,
                showAll: state.showAllKeyPoints,
                onToggleShowAll: () => cubit.toggleShowAllKeyPoints(),
              ),
              if (_allKeyPoints.isNotEmpty) SizedBox(height: Dimens.h20),

              SummaryResponsiveRow(
                isWide: isWide,
                leftFlex: 1,
                rightFlex: 1,
                left: SummaryMemoryHooksCard(hooks: SummaryMemoryHookBuilder.build(pack)),
                right: SummaryQuickRecallCard(
                  questions: pack.quizQuestions,
                  revealedIndices: state.revealedQuizQuestions,
                  onRevealToggle: cubit.toggleQuizQuestion,
                ),
              ),
              SizedBox(height: Dimens.h20),

              if (pack.flashcards.isNotEmpty) ...[
                SummaryFlashcardsSection(
                  flashcards: pack.flashcards,
                  flippedIndices: state.flippedFlashcards,
                  onFlip: cubit.toggleFlashcard,
                  onViewAll: onViewAllFlashcards,
                ),
                SizedBox(height: Dimens.h20),
              ],

              const SummaryStudyTipFooter(),
              SizedBox(height: Dimens.h40),
            ],
          ),
        );
      },
    );
  }
}
