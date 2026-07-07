import 'package:flutter/material.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';
import 'package:yaad_hai/shared/widgets/language_toggle_button.dart';

class ConceptsHeader extends StatelessWidget {
  const ConceptsHeader({super.key, required this.chapter, required this.onAdd});
  final Chapter chapter;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.white,
        border: Border(bottom: BorderSide(color: isDark ? AppColors.grey800 : AppColors.grey100)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h12),
            child: Row(
              children: [
                // ── Back button ────────────────────────────────────────
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(Dimens.w8),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.grey800 : AppColors.grey100,
                      borderRadius: BorderRadius.circular(Dimens.r10),
                    ),
                    child: Icon(Icons.arrow_back_rounded, color: isDark ? AppColors.white : AppColors.grey700, size: Dimens.icon20),
                  ),
                ),
                SizedBox(width: Dimens.w12),

                // ── Title ──────────────────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chapter.title,
                        style: AppStyles.heading4.copyWith(
                          color: isDark ? AppColors.white : AppColors.grey900,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(AppStrings.concepts, style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500)),
                    ],
                  ),
                ),
                SizedBox(width: Dimens.w8),

                // ── Language toggle ────────────────────────────────────
                const LanguageToggleButton(),
                SizedBox(width: Dimens.w10),

                // ── Add button ─────────────────────────────────────────
                GestureDetector(
                  onTap: onAdd,
                  child: Container(
                    padding: EdgeInsets.all(Dimens.w10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
                      borderRadius: BorderRadius.circular(Dimens.r12),
                      boxShadow: [
                        BoxShadow(color: AppColors.primary.withValues(alpha: 0.35), blurRadius: Dimens.r8, offset: Offset(0, Dimens.h3)),
                      ],
                    ),
                    child: const Icon(Icons.add_rounded, color: AppColors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),

          // ── Hindi mode banner ──────────────────────────────────────────
          const HindiModeBanner(),
        ],
      ),
    );
  }
}
