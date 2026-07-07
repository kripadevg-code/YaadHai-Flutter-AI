import 'package:flutter/material.dart';
import 'package:yaad_hai/modules/scanner/components/summary_section_header.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class SummaryExecutiveCard extends StatelessWidget {
  const SummaryExecutiveCard({super.key, required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    if (summary.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return PremiumCard(
      padding: EdgeInsets.all(Dimens.w20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SummarySectionHeader(
            title: AppStrings.executiveSummary,
            icon: Icons.lightbulb_outline_rounded,
            iconColor: AppColors.primary,
            isDarkTheme: isDarkTheme,
          ),
          SizedBox(height: Dimens.h12),
          Text(
            summary,
            style: AppStyles.bodyMedium.copyWith(color: isDarkTheme ? AppColors.grey300 : AppColors.grey700, height: 1.6, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
