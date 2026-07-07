import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/modules/home/bloc/home_bloc.dart';
import 'package:yaad_hai/modules/home/components/home_profile_sheet.dart';
import 'package:yaad_hai/modules/home/models/home_user_profile.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final HomeUserProfile profile =
            state.profile ??
            const HomeUserProfile(
              displayName: AppStrings.defaultUserName,
              email: '',
              initials: AppStrings.defaultUserInitial,
              greeting: AppStrings.goodMorning,
            );

        return SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h14, Dimens.w20, Dimens.h16),
            child: Row(
              children: [
                Container(
                  width: Dimens.w40,
                  height: Dimens.h40,
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(Dimens.r14)),
                  child: Icon(Icons.auto_stories_rounded, color: AppColors.white, size: Dimens.icon22),
                ),
                SizedBox(width: Dimens.w10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.appName,
                        style: AppStyles.heading4.copyWith(
                          color: isDarkTheme ? AppColors.white : AppColors.homeInk,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '${profile.greeting}, ${profile.displayName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.caption.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey500),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => HomeProfileSheet.show(context, profile),
                  icon: Icon(Icons.account_circle_outlined, color: isDarkTheme ? AppColors.grey300 : AppColors.homeInk),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
