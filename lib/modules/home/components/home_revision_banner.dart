import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/modules/revision/bloc/revision_bloc.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class HomeRevisionBanner extends StatelessWidget {
  const HomeRevisionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RevisionBloc, RevisionState>(
      builder: (context, state) {
        final int count = state.dueCount;
        final bool hasDue = count > 0;
        final bool isLoading = state.status == RevisionStatus.loading && !state.hasData;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
          child: Material(
            color: AppColors.transparent,
            child: InkWell(
              onTap: () => AppNavigator.goRevision(context),
              borderRadius: BorderRadius.circular(Dimens.r20),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: hasDue ? [AppColors.primary, AppColors.primaryDark] : [AppColors.success, AppColors.successDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(Dimens.r24),
                  boxShadow: [
                    BoxShadow(
                      color: (hasDue ? AppColors.primary : AppColors.success).withValues(alpha: 0.35),
                      blurRadius: Dimens.r24,
                      offset: Offset(0, Dimens.h12),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.r24),
                  child: Stack(
                    children: [
                      // Decorative blobs
                      Positioned(
                        right: -30,
                        top: -40,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white.withValues(alpha: 0.1)),
                        ),
                      ),
                      Positioned(
                        right: 80,
                        bottom: -30,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white.withValues(alpha: 0.1)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimens.w20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: Dimens.w10, vertical: Dimens.h4),
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(Dimens.r8),
                                      border: Border.all(color: AppColors.white.withValues(alpha: 0.2)),
                                    ),
                                    child: Text(
                                      AppStrings.dailyFocus.toUpperCase(),
                                      style: AppStyles.overline.copyWith(color: AppColors.white, letterSpacing: 1.2),
                                    ),
                                  ),
                                  SizedBox(height: Dimens.h14),
                                  Text(
                                    isLoading
                                        ? AppStrings.homeStatsLoading
                                        : hasDue
                                        ? '$count ${AppStrings.topicsDue}'
                                        : AppStrings.allCaughtUp,
                                    style: AppStyles.heading2.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  SizedBox(height: Dimens.h6),
                                  Text(
                                    hasDue ? AppStrings.startSpacedRepetition : AppStrings.greatWorkRevisions,
                                    style: AppStyles.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.85)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(Dimens.w16),
                              decoration: BoxDecoration(
                                color: AppColors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.white.withValues(alpha: 0.4), width: 1.5),
                              ),
                              child: Icon(
                                hasDue ? Icons.play_arrow_rounded : Icons.check_rounded,
                                color: AppColors.white,
                                size: Dimens.icon24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
