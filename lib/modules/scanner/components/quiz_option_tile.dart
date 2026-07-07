import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class QuizOptionTile extends StatelessWidget {
  const QuizOptionTile({
    super.key,
    required this.option,
    required this.text,
    required this.isSelected,
    required this.isAnswered,
    required this.isCorrect,
    this.onTap,
  });

  final String option;
  final String text;
  final bool isSelected;
  final bool isAnswered;
  final bool isCorrect;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.all(Dimens.w20),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? (isDarkTheme ? AppColors.primary.withValues(alpha: 0.15) : AppColors.primary.withValues(alpha: 0.05))
                  : (isDarkTheme ? AppColors.darkCard : AppColors.white),
          borderRadius: BorderRadius.circular(Dimens.r12),
          border: Border.all(
            color: isSelected ? AppColors.primary : (isDarkTheme ? AppColors.grey700 : AppColors.grey200),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (!isDarkTheme && !isSelected)
              BoxShadow(color: AppColors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : (isDarkTheme ? AppColors.grey800 : AppColors.grey100),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                option,
                style: AppStyles.bodyMediumBold.copyWith(
                  color: isSelected ? AppColors.white : (isDarkTheme ? AppColors.grey400 : AppColors.grey600),
                ),
              ),
            ),
            SizedBox(width: Dimens.w16),
            Expanded(
              child: Text(
                text,
                style: AppStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.primary : (isDarkTheme ? AppColors.white : AppColors.grey900),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            if (isAnswered && isCorrect) Icon(Icons.check_circle_rounded, color: AppColors.success, size: Dimens.icon24),
            if (isAnswered && isSelected && !isCorrect) Icon(Icons.cancel_rounded, color: AppColors.error, size: Dimens.icon24),
          ],
        ),
      ),
    );
  }
}
