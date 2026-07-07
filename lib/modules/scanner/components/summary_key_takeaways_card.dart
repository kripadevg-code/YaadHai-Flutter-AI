import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:yaad_hai/modules/scanner/components/summary_section_header.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class SummaryKeyTakeawaysCard extends StatelessWidget {
  const SummaryKeyTakeawaysCard({super.key, required this.keyPoints, required this.showAll, required this.onToggleShowAll});

  final List<String> keyPoints;
  final bool showAll;
  final VoidCallback onToggleShowAll;

  static const List<Color> _bulletColors = [AppColors.success, AppColors.info, AppColors.warning, AppColors.primary, AppColors.accent];

  static const List<IconData> _bulletIcons = [
    Icons.eco_rounded,
    Icons.opacity_rounded,
    Icons.wb_sunny_rounded,
    Icons.science_rounded,
    Icons.air_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final int totalKeyPoints = keyPoints.length;
    final int itemsToShow = showAll ? totalKeyPoints : math.min(5, totalKeyPoints);

    return PremiumCard(
      padding: EdgeInsets.all(Dimens.w20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SummarySectionHeader(
            icon: Icons.task_alt_rounded,
            iconColor: AppColors.primary,
            title: AppStrings.keyTakeaways,
            isDarkTheme: isDarkTheme,
          ),
          SizedBox(height: Dimens.h16),
          ...List.generate(itemsToShow, (index) {
            final Color color = _bulletColors[index % _bulletColors.length];
            final IconData icon = _bulletIcons[index % _bulletIcons.length];

            return Padding(
              padding: EdgeInsets.only(bottom: Dimens.h12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: Dimens.h2),
                    padding: EdgeInsets.all(Dimens.w6),
                    decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
                    child: Icon(icon, color: color, size: Dimens.icon16),
                  ),
                  SizedBox(width: Dimens.w12),
                  Expanded(
                    child: Text(
                      keyPoints[index],
                      style: AppStyles.bodyMedium.copyWith(color: isDarkTheme ? AppColors.grey300 : AppColors.grey700, height: 1.5),
                    ),
                  ),
                ],
              ),
            );
          }),
          if (totalKeyPoints > 5)
            Center(
              child: InkWell(
                onTap: onToggleShowAll,
                borderRadius: BorderRadius.circular(Dimens.r8),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        showAll ? AppStrings.showLess : '${AppStrings.viewAllPoints} ($totalKeyPoints ${AppStrings.points})',
                        style: AppStyles.labelMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: Dimens.w4),
                      Icon(
                        showAll ? Icons.arrow_upward_rounded : Icons.arrow_forward_rounded,
                        color: AppColors.primary,
                        size: Dimens.icon16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
