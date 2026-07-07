import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/modules/home/components/home_section_header.dart';
import 'package:yaad_hai/modules/mastery/bloc/mastery_bloc.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class HomeWeakConceptsSection extends StatelessWidget {
  const HomeWeakConceptsSection({super.key, required this.onConceptTap});

  final ValueChanged<Concept> onConceptTap;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<MasteryBloc, MasteryState>(
      builder: (context, state) {
        final displayedConcepts = state.weakConcepts.take(3).toList();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeSectionHeader(
                title: AppStrings.weakAreas,
                actionLabel: state.weakConcepts.isNotEmpty ? AppStrings.seeAll : null,
                onActionTap: state.weakConcepts.isNotEmpty ? () => AppNavigator.goMastery(context) : null,
              ),
              SizedBox(height: Dimens.h16),
              if (state.status == MasteryStatus.loading && state.weakConcepts.isEmpty)
                Center(child: Padding(padding: EdgeInsets.all(Dimens.w24), child: const CircularProgressIndicator()))
              else if (state.weakConcepts.isEmpty)
                const HomeWeakConceptsEmptyCard()
              else
                PremiumCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ...displayedConcepts.asMap().entries.map(
                        (entry) => HomeWeakConceptRow(
                          concept: entry.value,
                          isDarkTheme: isDarkTheme,
                          isLast: entry.key == displayedConcepts.length - 1,
                          onTap: () => onConceptTap(entry.value),
                        ),
                      ),
                      Material(
                        color: AppColors.transparent,
                        child: InkWell(
                          onTap: () => AppNavigator.goMastery(context),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: isDarkTheme ? AppColors.grey800 : AppColors.grey100)),
                            ),
                            padding: EdgeInsets.all(Dimens.w16),
                            child: Center(
                              child: Text(
                                AppStrings.viewAllWeakAreas,
                                style: AppStyles.labelMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class HomeWeakConceptsEmptyCard extends StatelessWidget {
  const HomeWeakConceptsEmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return PremiumCard(
      padding: EdgeInsets.all(Dimens.w20),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Dimens.w12),
            decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.12), shape: BoxShape.circle),
            child: Icon(Icons.verified_rounded, color: AppColors.success, size: Dimens.icon24),
          ),
          SizedBox(width: Dimens.w14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.homeNoWeakAreasTitle,
                  style: AppStyles.bodyMediumBold.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey900),
                ),
                SizedBox(height: Dimens.h4),
                Text(
                  AppStrings.homeNoWeakAreasBody,
                  style: AppStyles.bodySmall.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey600, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeWeakConceptRow extends StatelessWidget {
  const HomeWeakConceptRow({super.key, required this.concept, required this.isDarkTheme, required this.onTap, this.isLast = false});

  final Concept concept;
  final bool isDarkTheme;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration:
              isLast ? null : BoxDecoration(border: Border(bottom: BorderSide(color: isDarkTheme ? AppColors.grey800 : AppColors.grey100))),
          padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h14),
          child: Row(
            children: [
              Container(
                width: Dimens.w8,
                height: Dimens.h8,
                decoration: const BoxDecoration(color: AppColors.warning, shape: BoxShape.circle),
              ),
              SizedBox(width: Dimens.w14),
              Expanded(
                child: Text(
                  concept.title,
                  style: AppStyles.bodyMedium.copyWith(
                    color: isDarkTheme ? AppColors.white : AppColors.grey800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: isDarkTheme ? AppColors.grey600 : AppColors.grey300, size: Dimens.icon20),
            ],
          ),
        ),
      ),
    );
  }
}
