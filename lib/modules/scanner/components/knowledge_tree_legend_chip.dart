import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class KnowledgeTreeLegendChip extends StatelessWidget {
  const KnowledgeTreeLegendChip({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Dimens.w10,
          height: Dimens.h10,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(Dimens.r2)),
        ),
        SizedBox(width: Dimens.w6),
        Text(label, style: AppStyles.caption.copyWith(color: AppColors.grey500)),
      ],
    );
  }
}
