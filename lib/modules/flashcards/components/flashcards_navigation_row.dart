import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class FlashcardsNavigationRow extends StatelessWidget {
  const FlashcardsNavigationRow({super.key, required this.currentIndex, required this.total, required this.onPrev, required this.onNext});

  final int currentIndex;
  final int total;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        GestureDetector(
          onTap: currentIndex > 0 ? onPrev : null,
          child: Container(
            padding: EdgeInsets.all(Dimens.w12),
            decoration: BoxDecoration(
              color: currentIndex > 0 ? (isDark ? AppColors.grey800 : AppColors.grey100) : (isDark ? AppColors.grey900 : AppColors.grey50),
              borderRadius: BorderRadius.circular(Dimens.r12),
            ),
            child: Icon(
              Icons.chevron_left_rounded,
              color: currentIndex > 0 ? (isDark ? AppColors.white : AppColors.grey700) : AppColors.grey300,
              size: Dimens.icon24,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              '${currentIndex + 1} of $total',
              style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
            ),
          ),
        ),
        GestureDetector(
          onTap: currentIndex < total - 1 ? onNext : null,
          child: Container(
            padding: EdgeInsets.all(Dimens.w12),
            decoration: BoxDecoration(
              color: currentIndex < total - 1 ? AppColors.primary : (isDark ? AppColors.grey900 : AppColors.grey50),
              borderRadius: BorderRadius.circular(Dimens.r12),
            ),
            child: Icon(
              Icons.chevron_right_rounded,
              color: currentIndex < total - 1 ? AppColors.white : AppColors.grey300,
              size: Dimens.icon24,
            ),
          ),
        ),
      ],
    );
  }
}
