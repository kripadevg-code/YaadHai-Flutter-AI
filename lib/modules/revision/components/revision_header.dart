import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class RevisionHeader extends StatelessWidget {
  const RevisionHeader({super.key, required this.dueCount});

  final int dueCount;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? AppColors.darkBackground : AppColors.white,
        border: Border(bottom: BorderSide(color: isDarkTheme ? AppColors.grey800 : AppColors.grey100)),
      ),
      padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(Dimens.w8),
              decoration: BoxDecoration(
                color: isDarkTheme ? AppColors.grey800 : AppColors.grey100,
                borderRadius: BorderRadius.circular(Dimens.r10),
              ),
              child: Icon(Icons.arrow_back_rounded, color: isDarkTheme ? AppColors.white : AppColors.grey700, size: Dimens.icon20),
            ),
          ),
          SizedBox(width: Dimens.w16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.revision,
                  style: AppStyles.heading4.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
                ),
                if (dueCount > 0)
                  Text(
                    AppStrings.revisionDueTodayCount(dueCount),
                    style: AppStyles.bodySmall.copyWith(color: AppColors.warning, fontWeight: FontWeight.w600),
                  ),
              ],
            ),
          ),
          if (dueCount > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimens.w10, vertical: Dimens.h6),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Dimens.r20),
                border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule_rounded, size: Dimens.icon16, color: AppColors.warning),
                  SizedBox(width: Dimens.w4),
                  Text(
                    '$dueCount ${AppStrings.revisionDueCount}',
                    style: AppStyles.labelSmall.copyWith(color: AppColors.warning, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
