import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/modules/profile/bloc/profile_bloc.dart';
import 'package:yaad_hai/modules/profile/models/profile_user_data.dart';
import 'package:yaad_hai/modules/profile/repos/profile_repo.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(repository: locator<ProfileRepo>())..add(const ProfileEventLoad()),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.signedOut) {
          AppNavigator.goLogin(context);
        }
      },
      builder: (context, state) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AppScaffold(
          slivers: [
            _ProfileAppBar(isDark: isDark),
            if (state.isLoading)
              SliverFillRemaining(child: Center(child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2)))
            else if (state.isReady && state.userData != null)
              _ProfileContent(userData: state.userData!, isDark: isDark)
            else if (state.status == ProfileStatus.error)
              SliverFillRemaining(child: _ProfileError(onRetry: () => context.read<ProfileBloc>().add(const ProfileEventLoad()))),
          ],
        );
      },
    );
  }
}

// ─── App Bar ─────────────────────────────────────────────────────────────────

class _ProfileAppBar extends StatelessWidget {
  const _ProfileAppBar({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primary,
      systemOverlayStyle: SystemUiOverlayStyle.light, // Light icons for primary colored background
      leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white), onPressed: () => AppNavigator.pop(context)),
      flexibleSpace: FlexibleSpaceBar(background: _ProfileHeroBanner(isDark: isDark)),
    );
  }
}

// ─── Hero Banner ─────────────────────────────────────────────────────────────

class _ProfileHeroBanner extends StatelessWidget {
  const _ProfileHeroBanner({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final userData = state.userData;
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.brandPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.w24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Dimens.h16),
                  // Avatar
                  _ProfileAvatar(avatarUrl: userData?.avatarUrl, initials: userData?.initials ?? '?', size: Dimens.w80),
                  SizedBox(height: Dimens.h14),
                  // Name
                  Text(
                    userData?.displayName ?? AppStrings.defaultUserName,
                    style: AppStyles.heading3.copyWith(color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Dimens.h4),
                  // Email
                  Text(
                    userData?.email ?? '',
                    style: AppStyles.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.75)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Dimens.h16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── Avatar ───────────────────────────────────────────────────────────────────

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.initials, required this.size, this.avatarUrl});

  final String? avatarUrl;
  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withValues(alpha: 0.2),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.5), width: 3),
        image: avatarUrl != null ? DecorationImage(image: NetworkImage(avatarUrl!), fit: BoxFit.cover) : null,
      ),
      child: avatarUrl == null ? Center(child: Text(initials, style: AppStyles.heading2.copyWith(color: AppColors.white))) : null,
    );
  }
}

// ─── Content Body ─────────────────────────────────────────────────────────────

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.userData, required this.isDark});

  final ProfileUserData userData;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(height: Dimens.h24),

          // ── Stats row ───────────────────────────────────────────────────
          _StatsRow(userData: userData, isDark: isDark),
          SizedBox(height: Dimens.h24),

          // ── AI Status ───────────────────────────────────────────────────
          _AiStatusCard(isDark: isDark),
          SizedBox(height: Dimens.h24),

          // ── Account section ─────────────────────────────────────────────
          _SectionLabel(label: AppStrings.profileAccountSection, isDark: isDark),
          SizedBox(height: Dimens.h12),
          _SettingsTile(
            icon: Icons.person_outline_rounded,
            label: AppStrings.profileDisplayName,
            value: userData.displayName,
            isDark: isDark,
          ),
          SizedBox(height: Dimens.h8),
          _SettingsTile(icon: Icons.email_outlined, label: AppStrings.profileEmail, value: userData.email, isDark: isDark),
          SizedBox(height: Dimens.h24),

          // ── App section ─────────────────────────────────────────────────
          _SectionLabel(label: AppStrings.profileAppSection, isDark: isDark),
          SizedBox(height: Dimens.h12),
          _SettingsTile(
            icon: Icons.palette_outlined,
            label: AppStrings.profileAppearance,
            value: AppStrings.profileAppearanceValue,
            isDark: isDark,
          ),
          SizedBox(height: Dimens.h8),
          _SettingsTile(
            icon: Icons.info_outline_rounded,
            label: AppStrings.profileVersion,
            value: AppStrings.profileVersionValue,
            isDark: isDark,
          ),
          SizedBox(height: Dimens.h32),

          // ── Sign out ────────────────────────────────────────────────────
          _SignOutButton(isDark: isDark),
          SizedBox(height: Dimens.h80),
        ]),
      ),
    );
  }
}

// ─── Stats Row ────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.userData, required this.isDark});

  final ProfileUserData userData;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.menu_book_rounded,
            label: AppStrings.topicsStudied,
            value: '${userData.subjectCount}',
            color: AppColors.primary,
            isDark: isDark,
          ),
        ),
        SizedBox(width: Dimens.w12),
        Expanded(
          child: _StatCard(
            icon: Icons.lightbulb_outline_rounded,
            label: AppStrings.concepts,
            value: '${userData.conceptCount}',
            color: AppColors.brandPurple,
            isDark: isDark,
          ),
        ),
        SizedBox(width: Dimens.w12),
        Expanded(
          child: _StatCard(
            icon: Icons.local_fire_department_rounded,
            label: AppStrings.streak,
            value: '${userData.currentStreak}',
            color: AppColors.warning,
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.label, required this.value, required this.color, required this.isDark});

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w12, vertical: Dimens.h16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.white,
        borderRadius: BorderRadius.circular(Dimens.r16),
        boxShadow: AppStyles.subtleShadow,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Dimens.w8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: Dimens.icon20),
          ),
          SizedBox(height: Dimens.h8),
          Text(value, style: AppStyles.heading3.copyWith(color: isDark ? AppColors.white : AppColors.grey900)),
          SizedBox(height: Dimens.h2),
          Text(
            label,
            style: AppStyles.caption.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─── AI Status Card ───────────────────────────────────────────────────────────

class _AiStatusCard extends StatelessWidget {
  const _AiStatusCard({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimens.w16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.success.withValues(alpha: 0.10), AppColors.primary.withValues(alpha: 0.06)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(Dimens.r16),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Dimens.w10),
            decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(Icons.auto_awesome_rounded, color: AppColors.success, size: Dimens.icon22),
          ),
          SizedBox(width: Dimens.w14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.aiActiveTitle, style: AppStyles.bodyMediumBold.copyWith(color: AppColors.success)),
                SizedBox(height: Dimens.h2),
                Text(AppStrings.aiActiveBody, style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey600)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.w8, vertical: Dimens.h4),
            decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(Dimens.r20)),
            child: Text(AppStrings.profileAiBadge, style: AppStyles.labelSmall.copyWith(color: AppColors.success)),
          ),
        ],
      ),
    );
  }
}

// ─── Section Label ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.isDark});
  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Text(label.toUpperCase(), style: AppStyles.overline.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey400));
  }
}

// ─── Settings Tile ────────────────────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.label, required this.value, required this.isDark});

  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark ? AppColors.darkCard : AppColors.white,
      borderRadius: BorderRadius.circular(Dimens.r14),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h14),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimens.r14), boxShadow: AppStyles.subtleShadow),
        child: Row(
          children: [
            Container(
              width: Dimens.w36,
              height: Dimens.h36,
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(Dimens.r10)),
              child: Icon(icon, color: AppColors.primary, size: Dimens.icon18),
            ),
            SizedBox(width: Dimens.w14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppStyles.caption.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500)),
                  SizedBox(height: Dimens.h2),
                  Text(
                    value,
                    style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.white : AppColors.grey800),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Sign Out Button ──────────────────────────────────────────────────────────

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final isLoading = state.status == ProfileStatus.signingOut;
        return SizedBox(
          width: double.infinity,
          height: Dimens.h52,
          child: OutlinedButton.icon(
            onPressed: isLoading ? null : () => context.read<ProfileBloc>().add(const ProfileEventSignOut()),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.error.withValues(alpha: 0.6)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r14)),
            ),
            icon:
                isLoading
                    ? SizedBox.square(dimension: Dimens.w18, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.error))
                    : Icon(Icons.logout_rounded, color: AppColors.error, size: Dimens.icon20),
            label: Text(AppStrings.signOut, style: AppStyles.labelLarge.copyWith(color: AppColors.error)),
          ),
        );
      },
    );
  }
}

// ─── Error State ──────────────────────────────────────────────────────────────

class _ProfileError extends StatelessWidget {
  const _ProfileError({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline_rounded, color: AppColors.error, size: Dimens.icon48),
          SizedBox(height: Dimens.h16),
          Text(AppStrings.somethingWentWrong, style: AppStyles.bodyMediumBold),
          SizedBox(height: Dimens.h16),
          FilledButton(onPressed: onRetry, child: Text(AppStrings.retry)),
        ],
      ),
    );
  }
}
