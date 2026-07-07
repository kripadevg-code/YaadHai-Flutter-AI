import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/modules/quiz/components/quiz_header.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class QuizEmptyView extends StatelessWidget {
  const QuizEmptyView({super.key, required this.chapterId, required this.subjectId});

  final String chapterId;
  final String subjectId;

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
                    decoration: BoxDecoration(color: AppColors.warning.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: Icon(Icons.quiz_rounded, size: Dimens.icon48, color: AppColors.warning),
                  ),
                  SizedBox(height: Dimens.h24),
                  Text(
                    AppStrings.noQuestions,
                    style: AppStyles.heading2.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: Dimens.h8),
                  Text(
                    AppStrings.noQuestionsBody,
                    textAlign: TextAlign.center,
                    style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
                  ),
                  SizedBox(height: Dimens.h32),
                  SizedBox(
                    width: double.infinity,
                    height: Dimens.h54,
                    child: ElevatedButton.icon(
                      onPressed: () => AppNavigator.pushScanner(context, chapterId: chapterId, subjectId: subjectId),
                      icon: const Icon(Icons.document_scanner_rounded, color: AppColors.white),
                      label: Text(AppStrings.scanStudyMaterial, style: AppStyles.labelLarge.copyWith(color: AppColors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r16)),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimens.h12),
                  SizedBox(
                    width: double.infinity,
                    height: Dimens.h54,
                    child: OutlinedButton(
                      onPressed: () => context.pop(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: isDark ? AppColors.grey700 : AppColors.grey300),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r16)),
                      ),
                      child: Text(
                        AppStrings.goBack,
                        style: AppStyles.labelLarge.copyWith(color: isDark ? AppColors.white : AppColors.grey700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
