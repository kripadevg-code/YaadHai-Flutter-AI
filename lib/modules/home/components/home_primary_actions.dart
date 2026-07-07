import 'package:flutter/material.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class HomePrimaryActions extends StatelessWidget {
  const HomePrimaryActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
      child: Row(
        children: [
          Expanded(
            child: _HomePrimaryAction(
              icon: Icons.library_books_rounded,
              label: AppStrings.studyLibrary,
              onTap: () => AppNavigator.goSubjects(context),
            ),
          ),
          SizedBox(width: Dimens.w12),
          Expanded(
            child: _HomePrimaryAction(
              icon: Icons.history_rounded,
              label: AppStrings.reviewDue,
              onTap: () => AppNavigator.goRevision(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomePrimaryAction extends StatelessWidget {
  const _HomePrimaryAction({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.warning,
      borderRadius: BorderRadius.circular(Dimens.r18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.r18),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.w12, vertical: Dimens.h16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.homeInk, size: Dimens.icon20),
              SizedBox(width: Dimens.w8),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.labelLarge.copyWith(color: AppColors.homeInk, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
