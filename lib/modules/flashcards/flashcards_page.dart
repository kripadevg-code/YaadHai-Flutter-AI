import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/modules/flashcards/bloc/flashcards_bloc.dart';
import 'package:yaad_hai/modules/flashcards/components/flashcard_flip_card.dart';
import 'package:yaad_hai/modules/flashcards/components/flashcards_empty_view.dart';
import 'package:yaad_hai/modules/flashcards/components/flashcards_header.dart';
import 'package:yaad_hai/modules/flashcards/components/flashcards_mastery_buttons.dart';
import 'package:yaad_hai/modules/flashcards/components/flashcards_navigation_row.dart';
import 'package:yaad_hai/modules/flashcards/components/flashcards_progress_header.dart';
import 'package:yaad_hai/modules/flashcards/repos/flashcards_repo.dart';
import 'package:yaad_hai/modules/revision/repos/revision_repo.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class FlashcardsPage extends StatelessWidget {
  const FlashcardsPage({super.key, required this.chapter});
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              FlashcardsBloc(flashcardsRepository: locator<FlashcardsRepo>(), revisionRepository: locator<RevisionRepo>())
                ..add(FlashcardsEventWatch(chapter.id)),
      child: _FlashcardsView(chapter: chapter),
    );
  }
}

class _FlashcardsView extends StatelessWidget {
  const _FlashcardsView({required this.chapter});
  final Chapter chapter;

  void _markMastery(BuildContext context, Flashcard flashcard, int level) {
    context.read<FlashcardsBloc>().add(
      FlashcardsEventUpdateMastery(id: flashcard.id, conceptId: flashcard.conceptId, chapterId: flashcard.chapterId, level: level),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlashcardsBloc, FlashcardsState>(
      builder: (context, state) {
        final bloc = context.read<FlashcardsBloc>();
        return AppScaffold(
          topHeader: FlashcardsHeader(chapterTitle: chapter.title),
          safeAreaBottom: true,
          slivers: [
            if (state.status == FlashcardsStatus.loading && !state.hasData)
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
            else if (!state.hasData || state.flashcards.isEmpty)
              SliverFillRemaining(child: FlashcardsEmptyView(chapter: chapter))
            else
              SliverFillRemaining(
                hasScrollBody: false,
                child: _FlashcardsSession(
                  flashcards: state.flashcards,
                  currentIndex: state.currentIndex,
                  isFlipped: state.isFlipped,
                  onFlip: () => bloc.add(FlashcardsEventFlip()),
                  onNext: () => bloc.add(FlashcardsEventNext()),
                  onPrev: () => bloc.add(FlashcardsEventPrev()),
                  onMastery: (flashcard, level) => _markMastery(context, flashcard, level),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _FlashcardsSession extends StatelessWidget {
  const _FlashcardsSession({
    required this.flashcards,
    required this.currentIndex,
    required this.isFlipped,
    required this.onFlip,
    required this.onNext,
    required this.onPrev,
    required this.onMastery,
  });

  final List<Flashcard> flashcards;
  final int currentIndex;
  final bool isFlipped;
  final VoidCallback onFlip;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final void Function(Flashcard flashcard, int level) onMastery;

  @override
  Widget build(BuildContext context) {
    final flashcard = flashcards[currentIndex];
    final progress = (currentIndex + 1) / flashcards.length;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
      child: Column(
        children: [
          SizedBox(height: Dimens.h16),
          FlashcardsProgressHeader(currentIndex: currentIndex, total: flashcards.length, progress: progress),
          SizedBox(height: Dimens.h24),
          Expanded(child: FlashcardFlipCard(flashcard: flashcard, isFlipped: isFlipped, onTap: onFlip)),
          SizedBox(height: Dimens.h24),
          FlashcardsMasteryButtons(flashcard: flashcard, onMastery: onMastery),
          SizedBox(height: Dimens.h20),
          FlashcardsNavigationRow(currentIndex: currentIndex, total: flashcards.length, onPrev: onPrev, onNext: onNext),
          SizedBox(height: Dimens.h16),
        ],
      ),
    );
  }
}
