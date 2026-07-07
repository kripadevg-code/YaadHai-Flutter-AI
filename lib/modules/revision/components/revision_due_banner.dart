import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class RevisionDueBanner extends StatelessWidget {
  const RevisionDueBanner({super.key, required this.dueCount});

  final int dueCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h16, Dimens.w20, Dimens.h8),
      child: PremiumCard(
        backgroundColor: AppColors.primary.withValues(alpha: 0.06),
        padding: EdgeInsets.all(Dimens.w16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Dimens.w10),
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.12), shape: BoxShape.circle),
              child: Icon(Icons.replay_rounded, color: AppColors.primary, size: Dimens.icon20),
            ),
            SizedBox(width: Dimens.w14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.revisionConceptReviewCount(dueCount), style: AppStyles.bodyMediumBold.copyWith(color: AppColors.primary)),
                  Text(AppStrings.revisionRatePrompt, style: AppStyles.bodySmall.copyWith(color: AppColors.primary.withValues(alpha: 0.7))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
