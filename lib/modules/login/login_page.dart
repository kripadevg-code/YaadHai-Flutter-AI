import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/modules/login/bloc/login_bloc.dart';
import 'package:yaad_hai/modules/login/repos/login_repo.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => LoginBloc(repository: locator<LoginRepo>()), child: const _LoginView());
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  void _onGoogleSignIn(BuildContext context) {
    context.read<LoginBloc>().add(LoginEventSignInWithGoogle());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          AppNavigator.goHome(context);
        }
        if (state.status == LoginStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!, style: AppStyles.bodyMedium.copyWith(color: AppColors.white)),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r12)),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              const _AnimatedBackground(),
              _DecorativeBlobs(),
              SafeArea(
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    _AnimatedSection(
                      duration: const Duration(milliseconds: 700),
                      slideOffset: const Offset(0, 0.18),
                      child: _LogoSection(),
                    ),
                    const Spacer(flex: 3),
                    _AnimatedSection(
                      duration: const Duration(milliseconds: 700),
                      slideOffset: const Offset(0, 0.18),
                      child: _AuthCard(isLoading: state.isLoading, onGoogleTap: () => _onGoogleSignIn(context)),
                    ),
                    const Spacer(),
                    _AnimatedSection(
                      duration: const Duration(milliseconds: 700),
                      slideOffset: const Offset(0, 0.18),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: Dimens.h32),
                        child: Text(
                          AppStrings.privacyNote,
                          style: AppStyles.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.5)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Shared animated wrapper ───────────────────────────────────────────────────

class _AnimatedSection extends StatelessWidget {
  const _AnimatedSection({required this.duration, required this.slideOffset, required this.child});

  final Duration duration;
  final Offset slideOffset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
              slideOffset.dx * (1 - value) * 100, // assuming original offset was relative
              slideOffset.dy * (1 - value) * 100,
            ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

// ── Background ────────────────────────────────────────────────────────────────

class _AnimatedBackground extends StatelessWidget {
  const _AnimatedBackground();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primaryDark, AppColors.primary, AppColors.brandPurple],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Decorative blobs ──────────────────────────────────────────────────────────

class _DecorativeBlobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Positioned(top: -60, right: -80, child: _Blob(size: 260, color: AppColors.white.withValues(alpha: 0.06))),
      Positioned(bottom: -100, left: -60, child: _Blob(size: 320, color: AppColors.accent.withValues(alpha: 0.12))),
    ],
  );
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) =>
      SizedBox.square(dimension: size, child: DecoratedBox(decoration: BoxDecoration(shape: BoxShape.circle, color: color)));
}

// ── Logo section ──────────────────────────────────────────────────────────────

class _LogoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      _LogoBadge(),
      SizedBox(height: Dimens.h24),
      Text(
        AppStrings.appName,
        style: AppStyles.display1.copyWith(color: AppColors.white, fontWeight: FontWeight.w800, letterSpacing: -1.0),
      ),
      SizedBox(height: Dimens.h8),
      Text(AppStrings.tagline, style: AppStyles.bodyLarge.copyWith(color: AppColors.white.withValues(alpha: 0.80), letterSpacing: 0.3)),
      SizedBox(height: Dimens.h6),
      Text(AppStrings.taglineSub, style: AppStyles.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.55))),
    ],
  );
}

class _LogoBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    width: Dimens.w80,
    height: Dimens.h80,
    decoration: BoxDecoration(
      color: AppColors.white.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(Dimens.r20),
      border: Border.all(color: AppColors.white.withValues(alpha: 0.25), width: 1.5),
      boxShadow: [BoxShadow(color: AppColors.black.withValues(alpha: 0.25), blurRadius: Dimens.r24, offset: Offset(0, Dimens.h8))],
    ),
    child: Icon(Icons.psychology_rounded, size: Dimens.icon44, color: AppColors.white),
  );
}

// ── Auth card ─────────────────────────────────────────────────────────────────

class _AuthCard extends StatelessWidget {
  const _AuthCard({required this.isLoading, required this.onGoogleTap});

  final bool isLoading;
  final VoidCallback onGoogleTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: Dimens.w24),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(Dimens.r28),
        boxShadow: [BoxShadow(color: AppColors.black.withValues(alpha: 0.18), blurRadius: Dimens.r40, offset: Offset(0, Dimens.h16))],
      ),
      child: Padding(
        padding: EdgeInsets.all(Dimens.w28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.loginWelcome, style: AppStyles.heading2.copyWith(color: AppColors.grey900)),
            SizedBox(height: Dimens.h6),
            Text(AppStrings.loginSubtitle, style: AppStyles.bodyMedium.copyWith(color: AppColors.grey500, height: 1.6)),
            SizedBox(height: Dimens.h28),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.85, end: 1.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.scale(scale: value, child: child);
              },
              child: _GoogleSignInButton(isLoading: isLoading, onTap: onGoogleTap),
            ),
          ],
        ),
      ),
    ),
  );
}

// ── Google Sign-In button ─────────────────────────────────────────────────────

class _GoogleSignInButton extends StatelessWidget {
  const _GoogleSignInButton({required this.isLoading, required this.onTap});

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: isLoading ? null : onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      height: Dimens.h56,
      decoration: BoxDecoration(
        color: isLoading ? AppColors.grey100 : AppColors.grey50,
        borderRadius: BorderRadius.circular(Dimens.r16),
        border: Border.all(color: AppColors.grey200, width: 1.5),
        boxShadow:
            isLoading
                ? const []
                : [BoxShadow(color: AppColors.black.withValues(alpha: 0.06), blurRadius: Dimens.r12, offset: Offset(0, Dimens.h4))],
      ),
      child:
          isLoading
              ? Center(
                child: SizedBox.square(
                  dimension: Dimens.w22,
                  child: CircularProgressIndicator(strokeWidth: 2.5, valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary)),
                ),
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _GoogleLogo(),
                  SizedBox(width: Dimens.w12),
                  Text(AppStrings.continueWithGoogle, style: AppStyles.buttonMedium.copyWith(color: AppColors.grey800, letterSpacing: 0.2)),
                ],
              ),
    ),
  );
}

// ── Google logo (painted — no asset needed) ───────────────────────────────────

class _GoogleLogo extends StatelessWidget {
  const _GoogleLogo();

  @override
  Widget build(BuildContext context) => SizedBox.square(dimension: Dimens.w24, child: CustomPaint(painter: _GoogleLogoPainter()));
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    final arcRect = Rect.fromCircle(center: center, radius: radius * 0.78);
    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.18
          ..strokeCap = StrokeCap.round;

    for (final (color, start, sweep) in [
      (AppColors.googleRed, -1.57, 1.57),
      (AppColors.googleYellow, 0.0, 1.57),
      (AppColors.googleGreen, 1.57, 0.96),
      (AppColors.googleBlue, 2.53, 1.18),
    ]) {
      canvas.drawArc(arcRect, start, sweep, false, paint..color = color);
    }

    // White crossbar
    canvas.drawLine(
      center,
      Offset(center.dx + radius * 0.75, center.dy),
      Paint()
        ..color = AppColors.white
        ..strokeWidth = size.width * 0.20
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
