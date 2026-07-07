import 'package:flutter/material.dart';
import 'package:yaad_hai/modules/quiz/components/quiz_header.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class QuizLoadingView extends StatelessWidget {
  const QuizLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      topHeader: const QuizHeader(title: AppStrings.quiz),
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(Dimens.w24),
                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: const CircularProgressIndicator(color: AppColors.primary),
              ),
              SizedBox(height: Dimens.h20),
              Text('Loading quiz...', style: AppStyles.bodyMedium.copyWith(color: AppColors.grey500)),
            ],
          ),
        ),
      ],
    );
  }
}
