import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class SummarySectionHeader extends StatelessWidget {
  const SummarySectionHeader({super.key, required this.icon, required this.iconColor, required this.title, required this.isDarkTheme});

  final IconData icon;
  final Color iconColor;
  final String title;
  final bool isDarkTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(Dimens.w8),
          decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r8)),
          child: Icon(icon, color: iconColor, size: Dimens.icon20),
        ),
        SizedBox(width: Dimens.w12),
        Text(
          title,
          style: AppStyles.labelLarge.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
