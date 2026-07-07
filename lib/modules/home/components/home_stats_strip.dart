import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/modules/mastery/bloc/mastery_bloc.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class HomeStatsStrip extends StatelessWidget {
  const HomeStatsStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasteryBloc, MasteryState>(
      builder: (context, state) {
        final bool isLoading = state.status == MasteryStatus.loading;
        final String streakValue = isLoading ? AppStrings.homeStatsLoading : '${state.currentStreak}';
        final String conceptsValue = isLoading ? AppStrings.homeStatsLoading : '${state.totalConcepts}';
        final String masteryValue = isLoading ? AppStrings.homeStatsLoading : '${(state.masteryPercent * 100).round()}%';

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
          child: PremiumCard(
            padding: EdgeInsets.symmetric(vertical: Dimens.h16, horizontal: Dimens.w12),
            child: Row(
              children: [
                Expanded(
                  child: HomeStatTile(
                    icon: Icons.local_fire_department_rounded,
                    iconColor: AppColors.warning,
                    value: streakValue,
                    label: AppStrings.streak,
                  ),
                ),
                const HomeStatDivider(),
                Expanded(
                  child: HomeStatTile(
                    icon: Icons.psychology_rounded,
                    iconColor: AppColors.info,
                    value: conceptsValue,
                    label: AppStrings.concepts,
                  ),
                ),
                const HomeStatDivider(),
                Expanded(
                  child: HomeStatTile(
                    icon: Icons.analytics_rounded,
                    iconColor: AppColors.success,
                    value: masteryValue,
                    label: AppStrings.masteryScore,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeStatDivider extends StatelessWidget {
  const HomeStatDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(width: Dimens.connectorWidth, height: Dimens.h40, color: isDarkTheme ? AppColors.grey800 : AppColors.grey200);
  }
}

class HomeStatTile extends StatelessWidget {
  const HomeStatTile({super.key, required this.icon, required this.iconColor, required this.value, required this.label});

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(Dimens.w8),
          decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.12), shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: Dimens.icon20),
        ),
        SizedBox(height: Dimens.h8),
        Text(
          value,
          style: AppStyles.heading3.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: Dimens.h2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppStyles.labelSmall.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey500),
        ),
      ],
    );
  }
}
