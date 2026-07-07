import 'package:flutter/material.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ConceptCard extends StatelessWidget {
  const ConceptCard({super.key, required this.concept, required this.index});

  final ConceptData concept;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return PremiumCard(
      padding: EdgeInsets.zero,
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(Dimens.w20),
          childrenPadding: EdgeInsets.only(left: Dimens.w20, right: Dimens.w20, bottom: Dimens.h20),
          leading: Container(
            width: Dimens.icon32,
            height: Dimens.icon32,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r12)),
            child: Text(index.toString(), style: AppStyles.heading4.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
          title: Text(
            concept.title,
            style: AppStyles.heading4.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: Dimens.h8),
            child: Text(
              concept.summary,
              style: AppStyles.bodySmall.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey600, height: 1.4),
            ),
          ),
          children: [
            if (concept.detailedExplanation != null && concept.detailedExplanation!.isNotEmpty) ...[
              SizedBox(height: Dimens.h16),
              Container(
                padding: EdgeInsets.all(Dimens.w16),
                decoration: BoxDecoration(
                  color: isDarkTheme ? AppColors.darkSurface : AppColors.grey50,
                  borderRadius: BorderRadius.circular(Dimens.r12),
                  border: Border.all(color: isDarkTheme ? AppColors.grey800 : AppColors.grey200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline_rounded, size: Dimens.icon16, color: AppColors.primary),
                        SizedBox(width: Dimens.w8),
                        Text(
                          AppStrings.detailedExplanation,
                          style: AppStyles.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimens.h8),
                    Text(
                      concept.detailedExplanation!,
                      style: AppStyles.bodyMedium.copyWith(color: isDarkTheme ? AppColors.grey300 : AppColors.grey800, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
            if (concept.keyPoints.isNotEmpty) ...[
              SizedBox(height: Dimens.h16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    concept.keyPoints.map((point) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: Dimens.h8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: Dimens.h6, right: Dimens.w8),
                              child: Container(
                                width: Dimens.w6,
                                height: Dimens.h6,
                                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                point,
                                style: AppStyles.bodyMedium.copyWith(
                                  color: isDarkTheme ? AppColors.grey300 : AppColors.grey700,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
