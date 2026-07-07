import 'package:flutter/material.dart';
import 'package:yaad_hai/modules/scanner/components/summary_memory_hook.dart';
import 'package:yaad_hai/modules/scanner/components/summary_section_header.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class SummaryMemoryHooksCard extends StatelessWidget {
  const SummaryMemoryHooksCard({super.key, required this.hooks});

  final List<SummaryMemoryHook> hooks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return PremiumCard(
      padding: EdgeInsets.all(Dimens.w20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SummarySectionHeader(
            icon: Icons.psychology_alt_rounded,
            iconColor: AppColors.accent,
            title: AppStrings.memoryHooks,
            isDarkTheme: isDarkTheme,
          ),
          SizedBox(height: Dimens.h16),
          ...hooks.map(
            (hook) => Padding(
              padding: EdgeInsets.only(bottom: Dimens.h14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimens.w8),
                    decoration: BoxDecoration(color: hook.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(Dimens.r8)),
                    child: Icon(hook.icon, color: hook.color, size: Dimens.icon20),
                  ),
                  SizedBox(width: Dimens.w14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hook.type, style: AppStyles.labelSmall.copyWith(color: hook.color, fontWeight: FontWeight.bold)),
                        SizedBox(height: Dimens.h4),
                        Text(
                          hook.content,
                          style: AppStyles.bodyMedium.copyWith(color: isDarkTheme ? AppColors.grey300 : AppColors.grey700, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
