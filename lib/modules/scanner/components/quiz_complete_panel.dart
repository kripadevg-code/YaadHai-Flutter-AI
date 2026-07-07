import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class QuizCompletePanel extends StatelessWidget {
  const QuizCompletePanel({super.key, required this.score, required this.total});

  final int score;
  final int total;

  @override
  Widget build(BuildContext context) {
    final int percent = total == 0 ? 0 : (score / total * 100).round();
    final int incorrect = total - score;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final String resultMessage =
        percent >= 80
            ? AppStrings.scannerQuizExcellent
            : percent >= 50
            ? AppStrings.scannerQuizGoodEffort
            : AppStrings.scannerQuizKeepPracticing;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimens.w24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sectionsSpace: 4,
                      centerSpaceRadius: 60,
                      startDegreeOffset: 270,
                      sections: [
                        PieChartSectionData(color: AppColors.success, value: score.toDouble(), title: '', radius: 12),
                        if (incorrect > 0)
                          PieChartSectionData(color: AppColors.error, value: incorrect.toDouble(), title: '', radius: 12)
                        else if (score == 0 && incorrect == 0)
                          PieChartSectionData(color: AppColors.grey400, value: 1, title: '', radius: 12)
                        else
                          PieChartSectionData(color: AppColors.success, value: score.toDouble(), title: '', radius: 12),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$percent%',
                        style: AppStyles.heading1.copyWith(
                          color: isDarkTheme ? AppColors.white : AppColors.grey900,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(AppStrings.scannerQuizScore, style: AppStyles.labelSmall.copyWith(color: AppColors.grey600)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimens.h20),
            Text(resultMessage, style: AppStyles.heading2.copyWith(color: Theme.of(context).textTheme.headlineMedium?.color)),
            SizedBox(height: Dimens.h8),
            Text(AppStrings.scannerQuizScoreSummary(score, total), style: AppStyles.bodyMedium.copyWith(color: AppColors.grey600)),
          ],
        ),
      ),
    );
  }
}
