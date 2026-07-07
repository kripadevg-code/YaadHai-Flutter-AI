import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class PremiumCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final bool isInteractive;
  final Color? backgroundColor;

  const PremiumCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.isInteractive = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final radius = borderRadius ?? Dimens.r16;

    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? (isDark ? AppColors.darkCard : AppColors.white),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: isDark ? AppColors.grey700 : AppColors.grey200, width: Dimens.w2 / 2),
        boxShadow: isDark ? null : AppStyles.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius - Dimens.r2 / 2),
        child: Padding(padding: padding ?? EdgeInsets.all(Dimens.w20), child: child),
      ),
    );

    if (onTap != null || isInteractive) {
      return GestureDetector(onTap: onTap, child: MouseRegion(cursor: SystemMouseCursors.click, child: card));
    }

    return card;
  }
}
