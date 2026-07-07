import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ConceptsFilterBar extends StatelessWidget {
  const ConceptsFilterBar({
    super.key,
    required this.selectedIndex,
    required this.total,
    required this.weakCount,
    required this.interviewCount,
    required this.onChanged,
  });

  final int selectedIndex;
  final int total;
  final int weakCount;
  final int interviewCount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tabs = [('All', total, AppColors.primary), ('Weak', weakCount, AppColors.error), ('Interview', interviewCount, AppColors.accent)];

    return Container(
      color: isDark ? AppColors.darkBackground : AppColors.white,
      padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h8, Dimens.w20, Dimens.h16),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final isSelected = i == selectedIndex;
          final (label, count, color) = tabs[i];
          return Padding(
            padding: EdgeInsets.only(right: Dimens.w8),
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: Dimens.w14, vertical: Dimens.h8),
                decoration: BoxDecoration(
                  color: isSelected ? color.withValues(alpha: 0.12) : (isDark ? AppColors.grey800 : AppColors.grey100),
                  borderRadius: BorderRadius.circular(Dimens.r20),
                  border: Border.all(color: isSelected ? color : AppColors.transparent, width: 1.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: AppStyles.labelMedium.copyWith(
                        color: isSelected ? color : (isDark ? AppColors.grey400 : AppColors.grey500),
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                    if (count > 0) ...[
                      SizedBox(width: Dimens.w6),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimens.w6, vertical: Dimens.h2),
                        decoration: BoxDecoration(
                          color: isSelected ? color : AppColors.grey300,
                          borderRadius: BorderRadius.circular(Dimens.r10),
                        ),
                        child: Text('$count', style: AppStyles.caption.copyWith(color: AppColors.white, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
