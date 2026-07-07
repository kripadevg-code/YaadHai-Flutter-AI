import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ConceptsEmptyView extends StatelessWidget {
  const ConceptsEmptyView({super.key, required this.isFiltered, required this.onAdd});

  final bool isFiltered;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimens.w32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(Dimens.w24),
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.lightbulb_rounded, size: Dimens.icon48, color: AppColors.primary),
            ),
            SizedBox(height: Dimens.h24),
            Text(
              isFiltered ? 'No matching concepts' : AppStrings.noConcepts,
              style: AppStyles.heading2.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Dimens.h8),
            Text(
              isFiltered ? 'Try a different filter' : AppStrings.noConceptsBody,
              textAlign: TextAlign.center,
              style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
            ),
            if (!isFiltered) ...[
              SizedBox(height: Dimens.h32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_rounded, color: AppColors.white),
                  label: Text(AppStrings.addConcept, style: AppStyles.labelLarge.copyWith(color: AppColors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: Dimens.h16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r16)),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
