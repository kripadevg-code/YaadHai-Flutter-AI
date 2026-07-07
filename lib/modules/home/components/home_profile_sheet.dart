import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/modules/home/bloc/home_bloc.dart';
import 'package:yaad_hai/modules/home/models/home_user_profile.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class HomeProfileSheet extends StatelessWidget {
  const HomeProfileSheet({super.key, required this.profile});

  final HomeUserProfile profile;

  static Future<void> show(BuildContext context, HomeUserProfile profile) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      // Pass [context] explicitly so HomeBloc is reachable inside the sheet.
      builder: (sheetContext) => BlocProvider.value(value: BlocProvider.of<HomeBloc>(context), child: HomeProfileSheet(profile: profile)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(Dimens.w24, Dimens.h24, Dimens.w24, MediaQuery.viewInsetsOf(context).bottom + Dimens.h32),
      decoration: BoxDecoration(
        color: isDarkTheme ? AppColors.darkBackground : AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.r24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: Dimens.w40,
              height: Dimens.h4,
              decoration: BoxDecoration(
                color: isDarkTheme ? AppColors.grey700 : AppColors.grey200,
                borderRadius: BorderRadius.circular(Dimens.r2),
              ),
            ),
          ),
          SizedBox(height: Dimens.h24),
          HomeProfileHeader(profile: profile, isDarkTheme: isDarkTheme),
          SizedBox(height: Dimens.h28),
          HomeAiStatusBadge(isDarkTheme: isDarkTheme),
          SizedBox(height: Dimens.h16),
          // ── View full profile button ─────────────────────────────────
          SizedBox(
            height: Dimens.h48,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                AppNavigator.pushProfile(context);
              },
              style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r12))),
              icon: Icon(Icons.person_rounded, size: Dimens.icon20),
              label: Text(AppStrings.profileTitle, style: AppStyles.labelLarge.copyWith(color: AppColors.white)),
            ),
          ),
          SizedBox(height: Dimens.h12),
          const HomeSignOutButton(),
        ],
      ),
    );
  }
}

class HomeProfileHeader extends StatelessWidget {
  const HomeProfileHeader({super.key, required this.profile, required this.isDarkTheme});

  final HomeUserProfile profile;
  final bool isDarkTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: Dimens.r28,
          backgroundColor: AppColors.primary.withValues(alpha: 0.12),
          backgroundImage: profile.avatarUrl != null ? NetworkImage(profile.avatarUrl!) : null,
          child: profile.avatarUrl == null ? Text(profile.initials, style: AppStyles.heading3.copyWith(color: AppColors.primary)) : null,
        ),
        SizedBox(width: Dimens.w16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.displayName,
                style: AppStyles.bodyMediumBold.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey900),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Dimens.h2),
              Text(
                profile.email,
                style: AppStyles.bodySmall.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeAiStatusBadge extends StatelessWidget {
  const HomeAiStatusBadge({super.key, required this.isDarkTheme});

  final bool isDarkTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h12),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Dimens.r12),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_awesome_rounded, color: AppColors.success, size: Dimens.icon20),
          SizedBox(width: Dimens.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.aiActiveTitle, style: AppStyles.bodyMediumBold.copyWith(color: AppColors.success)),
                Text(
                  AppStrings.aiActiveBody,
                  style: AppStyles.bodySmall.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeSignOutButton extends StatelessWidget {
  const HomeSignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == HomeStatus.signedOut) {
          Navigator.of(context).pop();
          AppNavigator.goLogin(context);
        }
      },
      builder: (context, state) {
        final bool isLoading = state.status == HomeStatus.signingOut;

        return SizedBox(
          height: Dimens.h52,
          child: OutlinedButton.icon(
            onPressed: isLoading ? null : () => context.read<HomeBloc>().add(HomeEventSignOut()),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.error.withValues(alpha: 0.6)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r12)),
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
