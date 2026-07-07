import 'package:flutter/material.dart';
import 'package:yaad_hai/modules/scanner/components/quiz_complete_panel.dart';
import 'package:yaad_hai/modules/scanner/components/quiz_option_tile.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/modules/scanner/bloc/quiz_tab_cubit.dart';

class QuizTab extends StatelessWidget {
  const QuizTab({super.key, required this.pack});
  final dynamic pack;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => QuizTabCubit(), child: _QuizTabView(pack: pack));
  }
}

class _QuizTabView extends StatelessWidget {
  const _QuizTabView({required this.pack});
  final dynamic pack;

  @override
  Widget build(BuildContext context) {
    final questions = pack.quizQuestions as List;
    if (questions.isEmpty) {
      return Center(child: Text(AppStrings.noQuizGenerated, style: AppStyles.bodyMedium));
    }

    return BlocBuilder<QuizTabCubit, QuizTabState>(
      builder: (context, state) {
        if (state.completed) {
          return QuizCompletePanel(score: state.score, total: questions.length);
        }

        final dynamic question = questions[state.current];
        final theme = Theme.of(context);
        final isDarkTheme = theme.brightness == Brightness.dark;
        final cubit = context.read<QuizTabCubit>();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.w20, vertical: Dimens.h12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.r4),
                child: LinearProgressIndicator(
                  value: (state.current + 1) / questions.length,
                  backgroundColor: AppColors.grey200,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 6,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Dimens.w20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.scannerQuizProgress(state.current + 1, questions.length),
                      style: AppStyles.labelMedium.copyWith(color: AppColors.grey600),
                    ),
                    SizedBox(height: Dimens.h8),
                    PremiumCard(
                      padding: EdgeInsets.all(Dimens.w24),
                      child: Text(
                        question.question,
                        style: AppStyles.heading3.copyWith(
                          color: isDarkTheme ? AppColors.white : AppColors.grey900,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: Dimens.h20),
                    ...[('A', question.optionA), ('B', question.optionB), ('C', question.optionC), ('D', question.optionD)].map(
                      (option) => Padding(
                        padding: EdgeInsets.only(bottom: Dimens.h12),
                        child: QuizOptionTile(
                          option: option.$1,
                          text: option.$2,
                          isSelected: state.selectedAnswer == option.$1,
                          isAnswered: state.answered,
                          isCorrect: question.correctOption == option.$1,
                          onTap: state.answered ? null : () => cubit.selectAnswer(option.$1),
                        ),
                      ),
                    ),
                    if (state.answered && question.explanation != null) ...[
                      SizedBox(height: Dimens.h8),
                      Container(
                        padding: EdgeInsets.all(Dimens.w14),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(Dimens.r12),
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info_outline_rounded, size: Dimens.icon16, color: AppColors.primary),
                                SizedBox(width: Dimens.w6),
                                Text(AppStrings.scannerQuizExplanation, style: AppStyles.labelSmall.copyWith(color: AppColors.primary)),
                              ],
                            ),
                            SizedBox(height: Dimens.h6),
                            Text(question.explanation!, style: AppStyles.bodySmall.copyWith(color: theme.textTheme.bodySmall?.color)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.all(Dimens.w20),
                child: ElevatedButton(
                  onPressed:
                      state.selectedAnswer == null
                          ? null
                          : state.answered
                          ? () => cubit.nextQuestion(questions.length)
                          : () => cubit.checkAnswer(state.selectedAnswer == question.correctOption),
                  child: Text(
                    state.answered
                        ? (state.current < questions.length - 1 ? AppStrings.scannerQuizNextQuestion : AppStrings.scannerQuizSeeResults)
                        : AppStrings.scannerQuizCheckAnswer,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
