import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/modules/revision/bloc/revision_bloc.dart';
import 'package:yaad_hai/modules/revision/models/revision_item.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class RevisionCard extends StatelessWidget {
  const RevisionCard({super.key, required this.item});

  final RevisionItem item;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final Color urgencyColor =
        item.repetitions <= 1
            ? AppColors.error
            : item.repetitions <= 3
            ? AppColors.warning
            : AppColors.success;
    final String urgencyLabel =
        item.repetitions <= 1
            ? AppStrings.revisionUrgent
            : item.repetitions <= 3
            ? AppStrings.revisionSoon
            : AppStrings.revisionRoutine;

    return PremiumCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: urgencyColor, width: 4)),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
            ),
            child: Padding(
              padding: EdgeInsets.all(Dimens.w16),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimens.w10),
                    decoration: BoxDecoration(color: urgencyColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r10)),
                    child: Icon(Icons.replay_rounded, color: urgencyColor, size: Dimens.icon20),
                  ),
                  SizedBox(width: Dimens.w14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.conceptTitle,
                          style: AppStyles.heading4.copyWith(
                            color: isDarkTheme ? AppColors.white : AppColors.grey900,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: Dimens.h4),
                        Text(
                          item.chapterTitle,
                          style: AppStyles.bodySmall.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: Dimens.h4),
                        Row(
                          children: [
                            Icon(Icons.repeat_rounded, size: Dimens.icon16, color: isDarkTheme ? AppColors.grey500 : AppColors.grey400),
                            SizedBox(width: Dimens.w4),
                            Text(
                              '${AppStrings.repetitionLabel}${item.repetitions}',
                              style: AppStyles.bodySmall.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.w8, vertical: Dimens.h4),
                    decoration: BoxDecoration(color: urgencyColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r8)),
                    child: Text(urgencyLabel, style: AppStyles.labelSmall.copyWith(color: urgencyColor, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(top: BorderSide(color: isDarkTheme ? AppColors.grey800 : AppColors.grey100))),
            padding: EdgeInsets.fromLTRB(Dimens.w16, Dimens.h12, Dimens.w16, Dimens.h16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.conceptSummary != null && item.conceptSummary!.isNotEmpty) ...[
                  Text(
                    item.conceptSummary!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.bodySmall.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey600, height: 1.4),
                  ),
                  SizedBox(height: Dimens.h10),
                ],
                Text(
                  AppStrings.howWellRemember,
                  style: AppStyles.labelMedium.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey600),
                ),
                SizedBox(height: Dimens.h10),
                Row(
                  children: [
                    RevisionQualityButton(label: AppStrings.qualityForgot, quality: 1, color: AppColors.error, revisionId: item.id),
                    SizedBox(width: Dimens.w6),
                    RevisionQualityButton(label: AppStrings.qualityHard, quality: 3, color: AppColors.warning, revisionId: item.id),
                    SizedBox(width: Dimens.w6),
                    RevisionQualityButton(label: AppStrings.qualityGood, quality: 4, color: AppColors.success, revisionId: item.id),
                    SizedBox(width: Dimens.w6),
                    RevisionQualityButton(label: AppStrings.qualityEasy, quality: 5, color: AppColors.primary, revisionId: item.id),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RevisionQualityButton extends StatelessWidget {
  const RevisionQualityButton({super.key, required this.label, required this.quality, required this.color, required this.revisionId});

  final String label;
  final int quality;
  final Color color;
  final String revisionId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<RevisionBloc>().add(RevisionEventMarkRevised(revisionId: revisionId, quality: quality)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Dimens.h10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Dimens.r10),
            border: Border.all(color: color.withValues(alpha: 0.25)),
          ),
          child: Text(label, textAlign: TextAlign.center, style: AppStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
