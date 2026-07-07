import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class FlashcardsHeader extends StatelessWidget {
  const FlashcardsHeader({super.key, required this.chapterTitle});
  final String chapterTitle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.white,
        border: Border(bottom: BorderSide(color: isDark ? AppColors.grey800 : AppColors.grey100)),
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
              child: Icon(Icons.arrow_back_rounded, color: isDark ? AppColors.white : AppColors.grey700, size: Dimens.icon20),
            ),
          ),
          SizedBox(width: Dimens.w16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.flashcards,
                  style: AppStyles.heading4.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
                ),
                Text(
                  chapterTitle,
                  style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
