import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class QuizQuestionCard extends StatelessWidget {
  const QuizQuestionCard({super.key, required this.question});
  final String question;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimens.w20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isDark
                  ? [AppColors.darkCard, AppColors.darkSurface]
                  : [AppColors.primary.withValues(alpha: 0.05), AppColors.accent.withValues(alpha: 0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(Dimens.r16),
        border: Border.all(color: isDark ? AppColors.grey800 : AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Text(
        question,
        style: AppStyles.heading4.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w600, height: 1.5),
      ),
    );
  }
}

class QuizOptionTile extends StatelessWidget {
  const QuizOptionTile({super.key, required this.option, required this.isSelected, required this.onTap});

  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.all(Dimens.w16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.08) : (isDark ? AppColors.darkCard : AppColors.white),
          borderRadius: BorderRadius.circular(Dimens.r14),
          border: Border.all(
            color: isSelected ? AppColors.primary : (isDark ? AppColors.grey800 : AppColors.grey200),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected || isDark ? null : AppStyles.cardShadow,
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: Dimens.w22,
              height: Dimens.h22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : AppColors.transparent,
                border: Border.all(color: isSelected ? AppColors.primary : (isDark ? AppColors.grey600 : AppColors.grey300), width: 2),
              ),
              child: isSelected ? const Icon(Icons.check_rounded, color: AppColors.white, size: 14) : null,
            ),
            SizedBox(width: Dimens.w14),
            Expanded(
              child: Text(
                option,
                style: AppStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.primary : (isDark ? AppColors.white : AppColors.grey800),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizActionButton extends StatelessWidget {
  const QuizActionButton({super.key, required this.hasAnswer, required this.isLastQuestion, required this.onPressed});

  final bool hasAnswer;
  final bool isLastQuestion;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Dimens.h54,
      child: ElevatedButton(
        onPressed: hasAnswer ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.grey200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r16)),
          elevation: hasAnswer ? 4 : 0,
          shadowColor: AppColors.primary.withValues(alpha: 0.4),
        ),
        child: Text(
          isLastQuestion ? AppStrings.submitAnswer : AppStrings.nextQuestion,
          style: AppStyles.buttonMedium.copyWith(color: hasAnswer ? AppColors.white : AppColors.grey400),
        ),
      ),
    );
  }
}
