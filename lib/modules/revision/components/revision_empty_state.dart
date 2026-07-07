import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class RevisionEmptyState extends StatelessWidget {
  const RevisionEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimens.w32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Dimens.w120,
              height: Dimens.h120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.success, AppColors.successDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(Dimens.r32),
                boxShadow: [
                  BoxShadow(color: AppColors.success.withValues(alpha: 0.35), blurRadius: Dimens.r24, offset: Offset(0, Dimens.h12)),
                ],
              ),
              child: Icon(Icons.check_circle_rounded, size: Dimens.icon56, color: AppColors.white),
            ),
            SizedBox(height: Dimens.h32),
            Text(
              AppStrings.noDueRevisions,
              style: AppStyles.heading2.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Dimens.h12),
            Text(
              AppStrings.noDueRevisionsBody,
              textAlign: TextAlign.center,
              style: AppStyles.bodyMedium.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey500, height: 1.6),
            ),
            SizedBox(height: Dimens.h32),
            PremiumCard(
              padding: EdgeInsets.all(Dimens.w20),
              child: Row(
                children: [
                  Icon(Icons.emoji_events_rounded, color: AppColors.warning, size: Dimens.icon24),
                  SizedBox(width: Dimens.w12),
                  Expanded(
                    child: Text(
                      AppStrings.revisionComeBackTomorrow,
                      style: AppStyles.bodySmall.copyWith(color: isDarkTheme ? AppColors.grey300 : AppColors.grey700, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
