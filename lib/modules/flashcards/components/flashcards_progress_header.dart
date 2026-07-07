import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class FlashcardsProgressHeader extends StatelessWidget {
  const FlashcardsProgressHeader({super.key, required this.currentIndex, required this.total, required this.progress});

  final int currentIndex;
  final int total;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${currentIndex + 1} / $total',
              style: AppStyles.bodyMediumBold.copyWith(color: isDark ? AppColors.white : AppColors.grey800),
            ),
            Text(
              '${(progress * 100).round()}%',
              style: AppStyles.labelMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(height: Dimens.h8),
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.r4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: Dimens.h6,
            backgroundColor: isDark ? AppColors.grey800 : AppColors.grey100,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ],
    );
  }
}
