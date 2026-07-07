import 'package:flutter/material.dart';
import 'package:yaad_hai/modules/scanner/components/knowledge_tree_branch.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class KnowledgeTreeBranchColumn extends StatelessWidget {
  const KnowledgeTreeBranchColumn({super.key, required this.branch, required this.isDarkTheme, required this.isSingle});

  final KnowledgeTreeBranch branch;
  final bool isDarkTheme;
  final bool isSingle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.w120,
      child: Column(
        children: [
          Center(
            child: Container(
              width: isSingle ? 0 : Dimens.connectorWidth,
              height: Dimens.h16,
              color: AppColors.primary.withValues(alpha: 0.3),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimens.w4),
            padding: EdgeInsets.symmetric(horizontal: Dimens.w10, vertical: Dimens.h6),
            decoration: BoxDecoration(
              color: branch.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Dimens.r8),
              border: Border.all(color: branch.color.withValues(alpha: 0.4)),
            ),
            child: Text(
              branch.label,
              style: AppStyles.caption.copyWith(color: branch.color, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: Dimens.h8),
          ...branch.leaves.map(
            (leaf) => Padding(
              padding: EdgeInsets.only(bottom: Dimens.h6),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: Dimens.w4),
                padding: EdgeInsets.symmetric(horizontal: Dimens.w8, vertical: Dimens.h6),
                decoration: BoxDecoration(
                  color: isDarkTheme ? AppColors.darkBackground.withValues(alpha: 0.5) : AppColors.grey50,
                  borderRadius: BorderRadius.circular(Dimens.r6),
                  border: Border.all(color: isDarkTheme ? AppColors.grey800 : AppColors.grey200),
                ),
                child: Text(
                  leaf,
                  style: AppStyles.caption.copyWith(color: isDarkTheme ? AppColors.grey300 : AppColors.grey700, height: 1.3),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
