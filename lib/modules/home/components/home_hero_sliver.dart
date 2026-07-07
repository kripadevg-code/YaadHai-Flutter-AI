import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/modules/home/bloc/home_bloc.dart';
import 'package:yaad_hai/modules/home/components/home_profile_sheet.dart';
import 'package:yaad_hai/modules/home/models/home_user_profile.dart';
import 'package:yaad_hai/modules/mastery/bloc/mastery_bloc.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

import 'package:yaad_hai/modules/home/components/home_stats_strip.dart';

class HomeHeroSliver extends StatelessWidget {
  const HomeHeroSliver({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return SliverToBoxAdapter(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Gradient with Curve
          ClipPath(
            clipper: _HeroClipper(),
            child: Container(
              padding: EdgeInsets.fromLTRB(Dimens.w24, Dimens.h20, Dimens.w24, Dimens.h80),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors:
                      isDarkTheme
                          ? [AppColors.darkSurface, AppColors.darkBackground]
                          : [AppColors.primaryDark, AppColors.primary, AppColors.brandPurple],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Decorative blobs inside the curve
                    Positioned(
                      top: -40,
                      right: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white.withValues(alpha: 0.05)),
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      left: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white.withValues(alpha: 0.05)),
                      ),
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        final HomeUserProfile profile =
                            state.profile ??
                            const HomeUserProfile(
                              displayName: AppStrings.defaultUserName,
                              email: '',
                              initials: AppStrings.defaultUserInitial,
                              greeting: AppStrings.goodMorning,
                            );

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(Dimens.w8),
                                      decoration: BoxDecoration(
                                        color: AppColors.white.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(Dimens.r10),
                                      ),
                                      child: Icon(Icons.auto_stories_rounded, color: AppColors.white, size: Dimens.icon20),
                                    ),
                                    SizedBox(width: Dimens.w10),
                                    Text(
                                      AppStrings.appName,
                                      style: AppStyles.heading4.copyWith(color: AppColors.white, fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                                HomeProfileAvatar(profile: profile),
                              ],
                            ),
                            SizedBox(height: Dimens.h24),
                            Text(
                              '${profile.greeting} 👋',
                              style: AppStyles.bodyMedium.copyWith(color: AppColors.white.withValues(alpha: 0.8)),
                            ),
                            SizedBox(height: Dimens.h4),
                            Text(
                              profile.displayName,
                              style: AppStyles.heading1.copyWith(color: AppColors.white, fontWeight: FontWeight.w800, height: 1.1),
                            ),
                            SizedBox(height: Dimens.h8),
                            Text(
                              AppStrings.studyOverviewToday,
                              style: AppStyles.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.7)),
                            ),
                            SizedBox(height: Dimens.h16),
                            const HomeMasteryProgressChip(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Overlapping Stats Strip
          Positioned(
            left: 0,
            right: 0,
            bottom: -Dimens.h32, // Let it hang out of the container
            child: const HomeStatsStrip(),
          ),
        ],
      ),
    );
  }
}

class _HeroClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class HomeMasteryProgressChip extends StatelessWidget {
  const HomeMasteryProgressChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasteryBloc, MasteryState>(
      builder: (context, state) {
        final bool isLoading = state.status == MasteryStatus.loading;
        final int percent = (state.masteryPercent * 100).round();

        return Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.w14, vertical: Dimens.h8),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(Dimens.r20),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.trending_up_rounded, color: AppColors.white, size: Dimens.icon16),
              SizedBox(width: Dimens.w8),
              Text(
                isLoading ? AppStrings.masteryScore : '${AppStrings.masteryScore}: $percent%',
                style: AppStyles.labelMedium.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      },
    );
  }
}

class HomeProfileAvatar extends StatelessWidget {
  const HomeProfileAvatar({super.key, required this.profile});

  final HomeUserProfile profile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HomeProfileSheet.show(context, profile),
      child: Container(
        width: Dimens.w40,
        height: Dimens.h40,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white.withValues(alpha: 0.4), width: Dimens.borderWidthMedium),
        ),
        child:
            profile.avatarUrl != null
                ? ClipOval(
                  child: Image.network(
                    profile.avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => HomeInitialsCircle(initials: profile.initials),
                  ),
                )
                : HomeInitialsCircle(initials: profile.initials),
      ),
    );
  }
}

class HomeInitialsCircle extends StatelessWidget {
  const HomeInitialsCircle({super.key, required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(initials, style: AppStyles.bodyMediumBold.copyWith(color: AppColors.white)));
  }
}
