import 'package:flutter/material.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class FlashcardsEmptyView extends StatelessWidget {
  const FlashcardsEmptyView({super.key, required this.chapter});
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimens.w32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(Dimens.w24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.accent, AppColors.accentDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(Dimens.r24),
                boxShadow: [
                  BoxShadow(color: AppColors.accent.withValues(alpha: 0.35), blurRadius: Dimens.r20, offset: Offset(0, Dimens.h8)),
                ],
              ),
              child: Icon(Icons.style_rounded, size: Dimens.icon48, color: AppColors.white),
            ),
            SizedBox(height: Dimens.h28),
            Text(
              AppStrings.noFlashcards,
              style: AppStyles.heading2.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Dimens.h8),
            Text(
              AppStrings.noFlashcardsBody,
              textAlign: TextAlign.center,
              style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
            ),
            SizedBox(height: Dimens.h32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed:
                    () =>
                        AppNavigator.pushScanner(context, chapterTitle: chapter.title, chapterId: chapter.id, subjectId: chapter.subjectId),
                icon: const Icon(Icons.document_scanner_rounded, color: AppColors.white),
                label: Text(AppStrings.scanToGenerate, style: AppStyles.labelLarge.copyWith(color: AppColors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  padding: EdgeInsets.symmetric(vertical: Dimens.h16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
