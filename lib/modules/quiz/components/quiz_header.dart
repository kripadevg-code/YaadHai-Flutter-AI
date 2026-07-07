import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class QuizHeader extends StatelessWidget {
  const QuizHeader({super.key, required this.title, this.progress});
  final String title;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkBackground : AppColors.white,
            border: Border(
              bottom: BorderSide(color: progress != null ? AppColors.transparent : (isDark ? AppColors.grey800 : AppColors.grey100)),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h12),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(Dimens.w8),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.grey800 : AppColors.grey100,
                    borderRadius: BorderRadius.circular(Dimens.r10),
                  ),
                  child: Icon(Icons.close_rounded, color: isDark ? AppColors.white : AppColors.grey700, size: Dimens.icon20),
                ),
              ),
              SizedBox(width: Dimens.w16),
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.heading4.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        if (progress != null)
          LinearProgressIndicator(
            value: progress,
            minHeight: Dimens.h4,
            backgroundColor: isDark ? AppColors.grey800 : AppColors.grey100,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
      ],
    );
  }
}
