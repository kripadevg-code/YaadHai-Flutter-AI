import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yaad_hai/modules/quiz/bloc/quiz_bloc.dart';
import 'package:yaad_hai/modules/quiz/components/quiz_header.dart';
import 'package:yaad_hai/modules/quiz/components/quiz_score_ring.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class QuizResultView extends StatelessWidget {
  const QuizResultView({super.key, required this.state});
  final QuizState state;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scorePercent = state.scorePercent;
    final scoreColor =
        scorePercent >= 0.8
            ? AppColors.success
            : scorePercent >= 0.5
            ? AppColors.warning
            : AppColors.error;
    final total = state.questions.length;
    final mins = state.timeTakenSeconds ~/ 60;
    final secs = state.timeTakenSeconds % 60;

    return AppScaffold(
      topHeader: const QuizHeader(title: AppStrings.quizComplete),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
            child: Column(
              children: [
                SizedBox(height: Dimens.h32),
                QuizScoreRing(score: state.score, total: total, percent: scorePercent, color: scoreColor),
                SizedBox(height: Dimens.h28),
                Text(
                  scorePercent >= 0.8
                      ? '🎉 Excellent!'
                      : scorePercent >= 0.5
                      ? '👍 Good effort!'
                      : '📚 Keep practising!',
                  style: AppStyles.heading2.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: Dimens.h8),
                Text(
                  '${state.score} ${AppStrings.of} $total ${AppStrings.correct.toLowerCase()} answers',
                  style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
                ),
                SizedBox(height: Dimens.h24),
                QuizResultStatsRow(score: state.score, total: total, mins: mins, secs: secs, wrongCount: state.wrongConceptIds.length),
                if (state.wrongConceptIds.isNotEmpty) ...[
                  SizedBox(height: Dimens.h20),
                  PremiumCard(
                    backgroundColor: AppColors.warning.withValues(alpha: 0.06),
                    padding: EdgeInsets.all(Dimens.w16),
                    child: Row(
                      children: [
                        Icon(Icons.warning_rounded, color: AppColors.warning, size: Dimens.icon20),
                        SizedBox(width: Dimens.w12),
                        Expanded(
                          child: Text(
                            '${state.wrongConceptIds.length} weak area${state.wrongConceptIds.length > 1 ? 's' : ''} identified. Review these concepts!',
                            style: AppStyles.bodySmall.copyWith(
                              color: isDark ? AppColors.white : AppColors.grey800,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: Dimens.h54,
                  child: ElevatedButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.home_rounded, color: AppColors.white),
                    label: Text(AppStrings.backToChapter, style: AppStyles.labelLarge.copyWith(color: AppColors.white)),
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
                  child: OutlinedButton.icon(
                    onPressed: () => context.read<QuizBloc>().add(QuizEventReset()),
                    icon: Icon(Icons.refresh_rounded, color: isDark ? AppColors.white : AppColors.grey700),
                    label: Text(
                      AppStrings.retryQuiz,
                      style: AppStyles.labelLarge.copyWith(color: isDark ? AppColors.white : AppColors.grey700),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: isDark ? AppColors.grey700 : AppColors.grey300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r16)),
                    ),
                  ),
                ),
                SizedBox(height: Dimens.h24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class QuizResultStatsRow extends StatelessWidget {
  const QuizResultStatsRow({
    super.key,
    required this.score,
    required this.total,
    required this.mins,
    required this.secs,
    required this.wrongCount,
  });

  final int score;
  final int total;
  final int mins;
  final int secs;
  final int wrongCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: QuizResultStatTile(icon: Icons.check_circle_rounded, color: AppColors.success, value: '$score', label: 'Correct')),
        SizedBox(width: Dimens.w10),
        Expanded(child: QuizResultStatTile(icon: Icons.timer_rounded, color: AppColors.info, value: '${mins}m ${secs}s', label: 'Time')),
        SizedBox(width: Dimens.w10),
        Expanded(child: QuizResultStatTile(icon: Icons.cancel_rounded, color: AppColors.error, value: '${total - score}', label: 'Wrong')),
      ],
    );
  }
}

class QuizResultStatTile extends StatelessWidget {
  const QuizResultStatTile({super.key, required this.icon, required this.color, required this.value, required this.label});

  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return PremiumCard(
      padding: EdgeInsets.symmetric(vertical: Dimens.h16, horizontal: Dimens.w8),
      child: Column(
        children: [
          Icon(icon, color: color, size: Dimens.icon20),
          SizedBox(height: Dimens.h8),
          Text(value, style: AppStyles.bodyMediumBold.copyWith(color: isDark ? AppColors.white : AppColors.grey900)),
          SizedBox(height: Dimens.h4),
          Text(label, style: AppStyles.caption.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500)),
        ],
      ),
    );
  }
}
