import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/modules/scanner/components/summary_section_header.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class SummaryQuickRecallCard extends StatelessWidget {
  const SummaryQuickRecallCard({super.key, required this.questions, required this.revealedIndices, required this.onRevealToggle});

  final List<QuizQuestionData> questions;
  final Set<int> revealedIndices;
  final ValueChanged<int> onRevealToggle;

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final int questionsToShow = math.min(4, questions.length);

    return PremiumCard(
      padding: EdgeInsets.all(Dimens.w20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SummarySectionHeader(
            icon: Icons.help_outline_rounded,
            iconColor: AppColors.warning,
            title: AppStrings.quickRecallQuiz,
            isDarkTheme: isDarkTheme,
          ),
          SizedBox(height: Dimens.h16),
          ...List.generate(questionsToShow, (index) {
            final QuizQuestionData quiz = questions[index];
            final bool isRevealed = revealedIndices.contains(index);

            return Container(
              margin: EdgeInsets.only(bottom: Dimens.h12),
              padding: EdgeInsets.all(Dimens.w12),
              decoration: BoxDecoration(
                color: isDarkTheme ? AppColors.darkBackground.withValues(alpha: 0.4) : AppColors.grey50,
                borderRadius: BorderRadius.circular(Dimens.r12),
                border: Border.all(color: isDarkTheme ? AppColors.grey800 : AppColors.grey200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimens.w8, vertical: Dimens.h4),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(Dimens.r6),
                          border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: AppStyles.labelSmall.copyWith(color: AppColors.warning, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: Dimens.w12),
                      Expanded(
                        child: Text(
                          quiz.question,
                          style: AppStyles.bodyMedium.copyWith(
                            color: isDarkTheme ? AppColors.white : AppColors.grey900,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => onRevealToggle(index),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(Dimens.w60, Dimens.h30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          isRevealed ? AppStrings.hideAnswer : AppStrings.revealAnswer,
                          style: AppStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  AnimatedCrossFade(
                    duration: AppStyles.crossFadeDuration,
                    firstChild: const SizedBox.shrink(),
                    secondChild: Padding(
                      padding: EdgeInsets.only(top: Dimens.h10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(height: Dimens.h2, color: isDarkTheme ? AppColors.grey800 : AppColors.grey200),
                          SizedBox(height: Dimens.h8),
                          Row(
                            children: [
                              Text(
                                AppStrings.correctOption,
                                style: AppStyles.bodySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.success),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: Dimens.w6, vertical: Dimens.h2),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(Dimens.r4),
                                ),
                                child: Text(
                                  quiz.correctOption,
                                  style: AppStyles.bodySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.success),
                                ),
                              ),
                            ],
                          ),
                          if (quiz.explanation != null && quiz.explanation!.isNotEmpty) ...[
                            SizedBox(height: Dimens.h6),
                            Text(
                              quiz.explanation!,
                              style: AppStyles.bodySmall.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey600, height: 1.4),
                            ),
                          ],
                        ],
                      ),
                    ),
                    crossFadeState: isRevealed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
