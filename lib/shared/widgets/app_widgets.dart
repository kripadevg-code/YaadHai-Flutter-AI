import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, this.message, required this.onRetry});
  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimens.w40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: Dimens.icon48, color: AppColors.error),
            SizedBox(height: Dimens.h16),
            Text(
              message ?? AppStrings.somethingWentWrong,
              textAlign: TextAlign.center,
              style: AppStyles.bodyMedium.copyWith(color: theme.textTheme.bodyMedium?.color),
            ),
            SizedBox(height: Dimens.h24),
            ElevatedButton(onPressed: onRetry, child: const Text(AppStrings.retry)),
          ],
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.icon, required this.title, required this.body, this.actionLabel, this.onAction});

  final IconData icon;
  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimens.w40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(Dimens.w24),
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), shape: BoxShape.circle),
              child: Icon(icon, size: Dimens.icon48, color: AppColors.primary),
            ),
            SizedBox(height: Dimens.h24),
            Text(title, style: AppStyles.heading2.copyWith(color: theme.textTheme.headlineMedium?.color)),
            SizedBox(height: Dimens.h8),
            Text(body, textAlign: TextAlign.center, style: AppStyles.bodyMedium.copyWith(color: AppColors.grey600)),
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: Dimens.h28),
              ElevatedButton.icon(onPressed: onAction, icon: Icon(Icons.add_rounded, size: Dimens.icon24), label: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

class MasteryChip extends StatelessWidget {
  const MasteryChip({super.key, required this.level});
  final int level;

  Color get _color => switch (level) {
    0 => AppColors.grey400,
    1 => AppColors.masteryLow,
    2 => AppColors.masteryMedium,
    3 => AppColors.masteryHigh,
    _ => AppColors.masteryMaster,
  };

  String get _label => switch (level) {
    0 => AppStrings.masteryNotStarted,
    1 => AppStrings.masteryBeginner,
    2 => AppStrings.masteryIntermediate,
    3 => AppStrings.masteryAdvanced,
    _ => AppStrings.masteryMaster,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w10, vertical: Dimens.h4),
      decoration: BoxDecoration(color: _color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(Dimens.r20)),
      child: Text(_label, style: AppStyles.labelSmall.copyWith(color: level == 0 ? AppColors.grey600 : _color)),
    );
  }
}

class MasteryBar extends StatelessWidget {
  const MasteryBar({super.key, required this.level, this.onLevelTap});
  final int level;
  final ValueChanged<int>? onLevelTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final isActive = index < level;
        final color = isActive ? AppColors.primary : AppColors.grey200;
        return Expanded(
          child: GestureDetector(
            onTap: onLevelTap != null ? () => onLevelTap!(index + 1) : null,
            child: Container(
              margin: EdgeInsets.only(right: index < 4 ? Dimens.w6 : 0),
              height: Dimens.h8,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(Dimens.r4)),
            ),
          ),
        );
      }),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.actionLabel, this.onAction});
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(child: Text(title, style: AppStyles.heading4.copyWith(color: theme.textTheme.titleLarge?.color))),
        if (actionLabel != null && onAction != null)
          GestureDetector(onTap: onAction, child: Text(actionLabel!, style: AppStyles.labelMedium.copyWith(color: AppColors.primary))),
      ],
    );
  }
}

class SheetHandle extends StatelessWidget {
  const SheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Dimens.w40,
        height: Dimens.h4,
        decoration: BoxDecoration(color: AppColors.grey200, borderRadius: BorderRadius.circular(Dimens.r2)),
      ),
    );
  }
}
