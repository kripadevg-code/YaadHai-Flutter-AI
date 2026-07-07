import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/modules/quiz/bloc/quiz_bloc.dart';
import 'package:yaad_hai/modules/quiz/components/quiz_active_components.dart';
import 'package:yaad_hai/modules/quiz/components/quiz_empty_view.dart';
import 'package:yaad_hai/modules/quiz/components/quiz_error_view.dart';
import 'package:yaad_hai/modules/quiz/components/quiz_header.dart';
import 'package:yaad_hai/modules/quiz/components/quiz_loading_view.dart';
import 'package:yaad_hai/modules/quiz/components/quiz_result_view.dart';
import 'package:yaad_hai/modules/quiz/repos/quiz_repo.dart';
import 'package:yaad_hai/modules/revision/repos/revision_repo.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key, required this.chapterId, required this.subjectId});
  final String chapterId;
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              QuizBloc(quizRepository: locator<QuizRepo>(), revisionRepository: locator<RevisionRepo>())
                ..add(QuizEventLoad(chapterId: chapterId, subjectId: subjectId)),
      child: _QuizView(chapterId: chapterId, subjectId: subjectId),
    );
  }
}

class _QuizView extends StatelessWidget {
  const _QuizView({required this.chapterId, required this.subjectId});
  final String chapterId;
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        return switch (state.status) {
          QuizStatus.initial || QuizStatus.loading => const QuizLoadingView(),
          QuizStatus.empty => QuizEmptyView(chapterId: chapterId, subjectId: subjectId),
          QuizStatus.active => const _ActiveView(),
          QuizStatus.completed => QuizResultView(state: state),
          QuizStatus.error => QuizErrorView(message: state.errorMessage),
        };
      },
    );
  }
}

class _ActiveView extends StatelessWidget {
  const _ActiveView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        final q = state.currentQuestion;
        if (q == null) return const SizedBox.shrink();
        final progress = (state.currentIndex + 1) / state.questions.length;

        return AppScaffold(
          topHeader: QuizHeader(
            title: '${AppStrings.questionLabel} ${state.currentIndex + 1} ${AppStrings.of} ${state.questions.length}',
            progress: progress,
          ),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.all(Dimens.w20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimens.h8),
                    QuizQuestionCard(question: q.question),
                    SizedBox(height: Dimens.h24),
                    Text(
                      AppStrings.selectAnswer,
                      style: AppStyles.labelMedium.copyWith(color: AppColors.grey500, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: Dimens.h12),
                    ...[q.optionA, q.optionB, q.optionC, q.optionD].map(
                      (option) => Padding(
                        padding: EdgeInsets.only(bottom: Dimens.h10),
                        child: QuizOptionTile(
                          option: option,
                          isSelected: state.selectedAnswer == option,
                          onTap: () => context.read<QuizBloc>().add(QuizEventAnswer(option)),
                        ),
                      ),
                    ),
                    const Spacer(),
                    QuizActionButton(
                      hasAnswer: state.selectedAnswer != null,
                      isLastQuestion: state.isLastQuestion,
                      onPressed: () {
                        if (state.isLastQuestion) {
                          context.read<QuizBloc>().add(QuizEventSubmit());
                        } else {
                          context.read<QuizBloc>().add(QuizEventNext());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
