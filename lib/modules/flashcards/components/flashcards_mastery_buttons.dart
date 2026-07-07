import 'package:flutter/material.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class FlashcardsMasteryButtons extends StatelessWidget {
  const FlashcardsMasteryButtons({super.key, required this.flashcard, required this.onMastery});

  final Flashcard flashcard;
  final void Function(Flashcard flashcard, int level) onMastery;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MasteryButton(
            label: AppStrings.forgot,
            icon: Icons.close_rounded,
            color: AppColors.error,
            onTap: () => onMastery(flashcard, 1),
          ),
        ),
        SizedBox(width: Dimens.w8),
        Expanded(
          child: _MasteryButton(
            label: AppStrings.almost,
            icon: Icons.remove_rounded,
            color: AppColors.warning,
            onTap: () => onMastery(flashcard, 3),
          ),
        ),
        SizedBox(width: Dimens.w8),
        Expanded(
          child: _MasteryButton(
            label: AppStrings.gotIt,
            icon: Icons.check_rounded,
            color: AppColors.success,
            onTap: () => onMastery(flashcard, 5),
          ),
        ),
      ],
    );
  }
}

class _MasteryButton extends StatelessWidget {
  const _MasteryButton({required this.label, required this.icon, required this.color, required this.onTap});

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Dimens.h14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(Dimens.r14),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: Dimens.icon20),
            SizedBox(height: Dimens.h4),
            Text(label, style: AppStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
