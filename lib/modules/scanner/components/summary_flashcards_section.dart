import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class SummaryFlashcardsSection extends StatelessWidget {
  const SummaryFlashcardsSection({super.key, required this.flashcards, required this.flippedIndices, required this.onFlip, this.onViewAll});

  final List<FlashcardData> flashcards;
  final Set<int> flippedIndices;
  final ValueChanged<int> onFlip;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    if (flashcards.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.w4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.flashcardsTapToFlip,
                style: AppStyles.labelLarge.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.bold),
              ),
              if (onViewAll != null)
                InkWell(
                  onTap: onViewAll,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.viewAllFlashcards,
                        style: AppStyles.labelMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward_rounded, color: AppColors.primary, size: Dimens.icon16),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: Dimens.h12),
        SizedBox(
          height: Dimens.h150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: math.min(5, flashcards.length),
            itemBuilder: (context, index) {
              final FlashcardData flashcard = flashcards[index];
              final bool isFlipped = flippedIndices.contains(index);

              return GestureDetector(
                onTap: () => onFlip(index),
                child: Container(
                  width: Dimens.w260,
                  margin: EdgeInsets.only(right: Dimens.w12, bottom: Dimens.h4, left: index == 0 ? Dimens.w4 : 0),
                  decoration: BoxDecoration(
                    color:
                        isFlipped
                            ? AppColors.primary.withValues(alpha: isDarkTheme ? 0.15 : 0.08)
                            : (isDarkTheme ? AppColors.darkSurface : AppColors.white),
                    borderRadius: BorderRadius.circular(Dimens.r16),
                    border: Border.all(
                      color: isFlipped ? AppColors.primary : (isDarkTheme ? AppColors.grey800 : AppColors.grey200),
                      width: Dimens.borderWidthMedium,
                    ),
                    boxShadow: AppStyles.subtleShadow,
                  ),
                  padding: EdgeInsets.all(Dimens.w16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimens.w6, vertical: Dimens.h2),
                            decoration: BoxDecoration(
                              color: isFlipped ? AppColors.primary.withValues(alpha: 0.2) : AppColors.accent.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(Dimens.r4),
                            ),
                            child: Text(
                              isFlipped ? AppStrings.flashcardAnswer : AppStrings.flashcardQuestion,
                              style: AppStyles.labelSmall.copyWith(color: isFlipped ? AppColors.primaryLight : AppColors.accent),
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.flip_camera_android_rounded,
                            size: Dimens.icon16,
                            color: isDarkTheme ? AppColors.grey500 : AppColors.grey400,
                          ),
                        ],
                      ),
                      SizedBox(height: Dimens.h12),
                      Expanded(
                        child: Text(
                          isFlipped ? flashcard.answer : flashcard.question,
                          style: AppStyles.bodyMedium.copyWith(
                            color: isDarkTheme ? AppColors.white : AppColors.grey900,
                            fontWeight: isFlipped ? FontWeight.normal : FontWeight.w600,
                            height: 1.4,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: Dimens.h8),
                      Center(
                        child: Text(
                          AppStrings.tapToFlip,
                          style: AppStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
