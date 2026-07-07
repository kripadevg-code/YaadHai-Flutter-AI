import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/modules/onboarding/bloc/onboarding_bloc.dart';
import 'package:yaad_hai/modules/onboarding/repos/onboarding_repo.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => OnboardingBloc(repository: locator<OnboardingRepo>()), child: const _OnboardingView());
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  static const List<_OnboardingData> _pages = [
    _OnboardingData(
      icon: Icons.lightbulb_rounded,
      gradientColors: [AppColors.primary, AppColors.primaryDark],
      title: AppStrings.onboarding1Title,
      body: AppStrings.onboarding1Body,
      badge: AppStrings.onboardingBadgeLearn,
    ),
    _OnboardingData(
      icon: Icons.replay_rounded,
      gradientColors: [AppColors.accent, AppColors.accentDark],
      title: AppStrings.onboarding2Title,
      body: AppStrings.onboarding2Body,
      badge: AppStrings.onboardingBadgeRemember,
    ),
    _OnboardingData(
      icon: Icons.emoji_events_rounded,
      gradientColors: [AppColors.warning, AppColors.warningDark],
      title: AppStrings.onboarding3Title,
      body: AppStrings.onboarding3Body,
      badge: AppStrings.onboardingBadgeSucceed,
    ),
  ];

  void _finish(BuildContext context) {
    context.read<OnboardingBloc>().add(OnboardingEventComplete());
  }

  void _next(BuildContext context, int currentPage) {
    if (currentPage < _pages.length - 1) {
      context.read<OnboardingBloc>().add(OnboardingEventNextPage());
    } else {
      _finish(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listenWhen: (previous, current) => current.status == OnboardingStatus.completed,
      listener: (context, state) {
        if (state.status == OnboardingStatus.completed) {
          AppNavigator.goLogin(context);
        }
      },
      builder: (context, state) {
        final isLast = state.currentPage == _pages.length - 1;
        final data = _pages[state.currentPage];

        return Scaffold(
          backgroundColor: AppColors.grey50,
          body: SafeArea(
            child: Column(
              children: [
                _OnboardingTopBar(onSkip: () => _finish(context)),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.95,
                            end: 1.0,
                          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutBack)),
                          child: child,
                        ),
                      );
                    },
                    child: _OnboardingStep(key: ValueKey(state.currentPage), data: data),
                  ),
                ),
                _OnboardingBottom(
                  pageCount: _pages.length,
                  currentPage: state.currentPage,
                  isLast: isLast,
                  gradientColors: data.gradientColors,
                  onNext: () => _next(context, state.currentPage),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OnboardingTopBar extends StatelessWidget {
  const _OnboardingTopBar({required this.onSkip});
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w20, vertical: Dimens.h8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppStrings.appName, style: AppStyles.heading4.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
          TextButton(onPressed: onSkip, child: Text(AppStrings.skip, style: AppStyles.labelLarge.copyWith(color: AppColors.grey400))),
        ],
      ),
    );
  }
}

class _OnboardingStep extends StatelessWidget {
  const _OnboardingStep({super.key, required this.data});
  final _OnboardingData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _OnboardingIcon(data: data),
          SizedBox(height: Dimens.h48),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.w12, vertical: Dimens.h4),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: data.gradientColors),
              borderRadius: BorderRadius.circular(Dimens.r100),
            ),
            child: Text(data.badge, style: AppStyles.overline.copyWith(color: AppColors.white)),
          ),
          SizedBox(height: Dimens.h20),
          Text(data.title, textAlign: TextAlign.center, style: AppStyles.heading1.copyWith(color: AppColors.grey900, height: 1.2)),
          SizedBox(height: Dimens.h16),
          Text(data.body, textAlign: TextAlign.center, style: AppStyles.bodyLarge.copyWith(color: AppColors.grey500, height: 1.7)),
        ],
      ),
    );
  }
}

class _OnboardingIcon extends StatelessWidget {
  const _OnboardingIcon({required this.data});
  final _OnboardingData data;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.7, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            width: Dimens.w120,
            height: Dimens.h120,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: data.gradientColors),
              borderRadius: BorderRadius.circular(Dimens.r32),
              boxShadow: [
                BoxShadow(color: data.gradientColors.first.withValues(alpha: 0.35), blurRadius: Dimens.r24, offset: Offset(0, Dimens.h12)),
              ],
            ),
            child: Icon(data.icon, size: Dimens.icon56, color: AppColors.white),
          ),
        );
      },
    );
  }
}

class _OnboardingBottom extends StatelessWidget {
  const _OnboardingBottom({
    required this.pageCount,
    required this.currentPage,
    required this.isLast,
    required this.gradientColors,
    required this.onNext,
  });

  final int pageCount;
  final int currentPage;
  final bool isLast;
  final List<Color> gradientColors;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Dimens.w24, Dimens.h16, Dimens.w24, Dimens.h40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pageCount,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: Dimens.w4),
                width: index == currentPage ? Dimens.w28 : Dimens.w8,
                height: Dimens.h8,
                decoration: BoxDecoration(
                  gradient: index == currentPage ? LinearGradient(colors: gradientColors) : null,
                  color: index != currentPage ? AppColors.grey200 : null,
                  borderRadius: BorderRadius.circular(Dimens.r4),
                ),
              ),
            ),
          ),
          SizedBox(height: Dimens.h28),
          GestureDetector(
            onTap: onNext,
            child: Container(
              width: double.infinity,
              height: Dimens.h56,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColors),
                borderRadius: BorderRadius.circular(Dimens.r16),
                boxShadow: [
                  BoxShadow(color: gradientColors.first.withValues(alpha: 0.4), blurRadius: Dimens.r16, offset: Offset(0, Dimens.h8)),
                ],
              ),
              child: Center(
                child: Text(
                  isLast ? AppStrings.getStarted : AppStrings.next,
                  style: AppStyles.buttonLarge.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final IconData icon;
  final List<Color> gradientColors;
  final String title;
  final String body;
  final String badge;

  const _OnboardingData({required this.icon, required this.gradientColors, required this.title, required this.body, required this.badge});
}
