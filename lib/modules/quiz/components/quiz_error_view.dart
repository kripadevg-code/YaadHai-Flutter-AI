import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yaad_hai/modules/quiz/components/quiz_header.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class QuizErrorView extends StatelessWidget {
  const QuizErrorView({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppScaffold(
      topHeader: const QuizHeader(title: AppStrings.quiz),
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(Dimens.w32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimens.w24),
                    decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: Icon(Icons.error_outline_rounded, size: Dimens.icon48, color: AppColors.error),
                  ),
                  SizedBox(height: Dimens.h24),
                  Text(
                    AppStrings.somethingWentWrong,
                    style: AppStyles.heading2.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
                  ),
                  if (message != null) ...[
                    SizedBox(height: Dimens.h8),
                    Text(
                      message!,
                      style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: Dimens.h32),
                  SliverFillRemainingHelperButton(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SliverFillRemainingHelperButton extends StatelessWidget {
  const SliverFillRemainingHelperButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => context.pop(),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: Dimens.h16),
          side: BorderSide(color: isDark ? AppColors.grey700 : AppColors.grey300),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r16)),
        ),
        child: Text(AppStrings.goBack, style: AppStyles.labelLarge.copyWith(color: isDark ? AppColors.white : AppColors.grey700)),
      ),
    );
  }
}
