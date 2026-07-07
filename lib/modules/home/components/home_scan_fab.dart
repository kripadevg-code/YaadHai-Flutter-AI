import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class HomeScanFab extends StatelessWidget {
  const HomeScanFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.brandPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(Dimens.r100),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: Dimens.r24, offset: Offset(0, Dimens.h8))],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimens.r100),
          onTap: () => AppNavigator.pushScanner(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.w24, vertical: Dimens.h16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(FontAwesomeIcons.qrcode, color: AppColors.white, size: Dimens.icon20),
                SizedBox(width: Dimens.w10),
                Text(
                  AppStrings.scan.toUpperCase(),
                  style: GoogleFonts.poppins(
                    textStyle: AppStyles.labelLarge.copyWith(color: AppColors.white, letterSpacing: 1.2, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
