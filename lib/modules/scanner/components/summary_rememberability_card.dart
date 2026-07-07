import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class SummaryRememberabilityCard extends StatelessWidget {
  const SummaryRememberabilityCard({super.key, required this.keyPointCount});

  final int keyPointCount;

  String _labelForScore(int score) {
    if (score >= 90) return AppStrings.excellentEasyRecall;
    if (score >= 80) return AppStrings.veryGoodRecall;
    return AppStrings.goodRecall;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final int score = (85 + (keyPointCount % 5) * 3).clamp(50, 99);

    return PremiumCard(
      padding: EdgeInsets.all(Dimens.w20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(Dimens.w8),
                decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: Icon(Icons.psychology_rounded, color: AppColors.success, size: Dimens.icon22),
              ),
              SizedBox(width: Dimens.w12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.rememberabilityScore,
                    style: AppStyles.labelSmall.copyWith(
                      color: isDarkTheme ? AppColors.grey400 : AppColors.grey500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Dimens.h2),
                  Text('$score%', style: AppStyles.heading3.copyWith(color: AppColors.success, fontWeight: FontWeight.w800)),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimens.h12),
          Row(
            children: [
              Row(children: List.generate(5, (_) => Icon(Icons.star_rounded, color: AppColors.success, size: Dimens.icon16))),
              SizedBox(width: Dimens.w8),
              Expanded(
                child: Text(
                  _labelForScore(score),
                  style: AppStyles.caption.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimens.h14),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: Dimens.h6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.r4),
                  gradient: const LinearGradient(colors: [AppColors.error, AppColors.warning, AppColors.success]),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final double position = (constraints.maxWidth * (score / 100) - Dimens.w10 / 2).clamp(
                    0.0,
                    constraints.maxWidth - Dimens.w10,
                  );
                  return Padding(
                    padding: EdgeInsets.only(left: position),
                    child: Container(
                      width: Dimens.w10,
                      height: Dimens.h10,
                      decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle, boxShadow: AppStyles.subtleShadow),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
