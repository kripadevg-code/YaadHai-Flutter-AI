import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/modules/splash/bloc/splash_bloc.dart';
import 'package:yaad_hai/modules/splash/models/splash_destination.dart';
import 'package:yaad_hai/modules/splash/repos/splash_repo.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(repository: locator<SplashRepo>())..add(SplashEventResolveDestination()),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  void _navigate(BuildContext context, SplashDestination destination) {
    switch (destination) {
      case SplashDestination.home:
        AppNavigator.goHome(context);
      case SplashDestination.login:
        AppNavigator.goLogin(context);
      case SplashDestination.onboarding:
        AppNavigator.goOnboarding(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.ready && state.destination != null) {
          _navigate(context, state.destination!);
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryDark, AppColors.primary, AppColors.accent],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Opacity(opacity: value.clamp(0.0, 1.0), child: Transform.scale(scale: 0.6 + (0.4 * value), child: _LogoBadge())),
                      SizedBox(height: Dimens.h32),
                      Opacity(
                        opacity: ((value - 0.3) / 0.7).clamp(0.0, 1.0),
                        child: Transform.translate(offset: Offset(0, 20 * (1 - value)), child: const _SplashText()),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimens.w88,
      height: Dimens.h88,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(Dimens.r24),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [BoxShadow(color: AppColors.black.withValues(alpha: 0.2), blurRadius: Dimens.r32, offset: Offset(0, Dimens.h12))],
      ),
      child: Icon(Icons.psychology_rounded, size: Dimens.icon48, color: AppColors.white),
    );
  }
}

class _SplashText extends StatelessWidget {
  const _SplashText();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.appName,
          style: AppStyles.display1.copyWith(color: AppColors.white, letterSpacing: -1.0, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: Dimens.h8),
        Text(AppStrings.tagline, style: AppStyles.bodyLarge.copyWith(color: AppColors.white.withValues(alpha: 0.85), letterSpacing: 0.3)),
        SizedBox(height: Dimens.h4),
        Text(AppStrings.taglineSub, style: AppStyles.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.6))),
      ],
    );
  }
}
