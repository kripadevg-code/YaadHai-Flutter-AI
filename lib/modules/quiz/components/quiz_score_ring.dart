import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';

class QuizScoreRing extends StatelessWidget {
  const QuizScoreRing({super.key, required this.score, required this.total, required this.percent, required this.color});

  final int score;
  final int total;
  final double percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final incorrect = total - score;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scorePercent = (percent * 100).round();

    return SizedBox(
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
                else
                  PieChartSectionData(color: AppColors.success, value: score.toDouble(), title: '', radius: 12),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$scorePercent%',
                style: AppStyles.heading1.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w800),
              ),
              Text('$score of $total correct', style: AppStyles.labelSmall.copyWith(color: AppColors.grey600)),
            ],
          ),
        ],
      ),
    );
  }
}
