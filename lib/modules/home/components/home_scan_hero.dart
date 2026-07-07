import 'package:flutter/material.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class HomeScanHero extends StatelessWidget {
  const HomeScanHero({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
      child: Container(
        padding: EdgeInsets.all(Dimens.w20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.scanMintDark : AppColors.scanMint,
          borderRadius: BorderRadius.circular(Dimens.r28),
          border: Border.all(color: AppColors.success.withValues(alpha: 0.18)),
        ),
        child: Column(
          children: [
            Container(
              width: Dimens.w80,
              height: Dimens.h80,
              decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle, boxShadow: AppStyles.cardShadow),
              child: Icon(Icons.document_scanner_rounded, color: AppColors.primary, size: Dimens.icon44),
            ),
            SizedBox(height: Dimens.h16),
            Text(
              AppStrings.homeScanTitle,
              textAlign: TextAlign.center,
              style: AppStyles.heading2.copyWith(color: isDark ? AppColors.white : AppColors.homeInk, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: Dimens.h6),
            Text(
              AppStrings.homeScanBody,
              textAlign: TextAlign.center,
              style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey300 : AppColors.grey600),
            ),
            SizedBox(height: Dimens.h18),
            // ── Primary action ──────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => AppNavigator.pushScanner(context),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.homeInk,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: Dimens.h14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r14)),
                ),
                icon: Icon(Icons.center_focus_strong_rounded, size: Dimens.icon20),
                label: Text(AppStrings.scanNow, style: AppStyles.buttonMedium),
              ),
            ),
            SizedBox(height: Dimens.h10),
            // ── Secondary: view scan history ────────────────────────────
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => AppNavigator.pushScanHistory(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isDark ? AppColors.grey300 : AppColors.grey700,
                  side: BorderSide(color: isDark ? AppColors.grey700 : AppColors.success.withValues(alpha: 0.35)),
                  padding: EdgeInsets.symmetric(vertical: Dimens.h12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r14)),
                ),
                icon: Icon(Icons.history_rounded, size: Dimens.icon18),
                label: Text(
                  AppStrings.scanHistoryTitle,
                  style: AppStyles.buttonMedium.copyWith(
                    color: isDark ? AppColors.grey300 : AppColors.grey700,
                    fontSize: AppStyles.buttonMedium.fontSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
