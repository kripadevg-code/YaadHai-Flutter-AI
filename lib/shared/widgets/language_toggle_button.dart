import 'package:flutter/material.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/services/language_service.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

/// A compact pill-shaped language toggle button (EN ↔ हि).
/// Place it in any AppBar actions or page header row.
class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final service = locator<LanguageService>();

    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final isHindi = service.isHindi;
        return GestureDetector(
          onTap: service.toggle,
          child: AnimatedContainer(
            duration: AppStyles.crossFadeDuration,
            padding: EdgeInsets.symmetric(horizontal: Dimens.w10, vertical: Dimens.h5),
            decoration: BoxDecoration(
              color: isHindi ? AppColors.primary.withValues(alpha: isDark ? 0.25 : 0.12) : (isDark ? AppColors.grey800 : AppColors.grey100),
              borderRadius: BorderRadius.circular(Dimens.r20),
              border: Border.all(
                color: isHindi ? AppColors.primary.withValues(alpha: 0.4) : (isDark ? AppColors.grey700 : AppColors.grey200),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'EN',
                  style: AppStyles.labelSmall.copyWith(
                    color: !isHindi ? AppColors.primary : (isDark ? AppColors.grey500 : AppColors.grey400),
                    fontWeight: !isHindi ? FontWeight.w800 : FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.w4),
                  child: Text('|', style: AppStyles.labelSmall.copyWith(color: isDark ? AppColors.grey600 : AppColors.grey300)),
                ),
                Text(
                  'हि',
                  style: AppStyles.labelSmall.copyWith(
                    color: isHindi ? AppColors.primary : (isDark ? AppColors.grey500 : AppColors.grey400),
                    fontWeight: isHindi ? FontWeight.w800 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A full-width banner shown when Hindi mode is active — reminds the user
/// that AI translation is shown below each concept.
class HindiModeBanner extends StatelessWidget {
  const HindiModeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final service = locator<LanguageService>();
    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        if (!service.isHindi) return const SizedBox.shrink();
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: Dimens.w20, vertical: Dimens.h8),
          color: AppColors.primary.withValues(alpha: 0.08),
          child: Row(
            children: [
              Icon(Icons.translate_rounded, size: Dimens.icon16, color: AppColors.primary),
              SizedBox(width: Dimens.w8),
              Text(
                'हिंदी अनुवाद सक्रिय — AI द्वारा अनुवादित',
                style: AppStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              GestureDetector(
                onTap: service.toggle,
                child: Text(
                  'English',
                  style: AppStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
