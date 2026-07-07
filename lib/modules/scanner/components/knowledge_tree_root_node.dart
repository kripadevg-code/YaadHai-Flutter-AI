import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class KnowledgeTreeRootNode extends StatelessWidget {
  const KnowledgeTreeRootNode({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.w20, vertical: Dimens.h10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.info, AppColors.info.withValues(alpha: 0.75)]),
          borderRadius: BorderRadius.circular(Dimens.r10),
          boxShadow: [BoxShadow(color: AppColors.info.withValues(alpha: 0.25), blurRadius: Dimens.r8, offset: Offset(0, Dimens.h4))],
        ),
        child: Text(
          label,
          style: AppStyles.labelMedium.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
