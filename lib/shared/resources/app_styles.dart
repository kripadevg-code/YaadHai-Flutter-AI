import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

abstract class AppStyles {
  // ─── Shadows ────────────────────────────────────────────────────────────
  static List<BoxShadow> get cardShadow => [
    BoxShadow(color: AppColors.black.withValues(alpha: 0.04), blurRadius: Dimens.r12, offset: Offset(0, Dimens.h4)),
  ];

  static List<BoxShadow> get topBarShadow => [
    BoxShadow(color: AppColors.black.withValues(alpha: 0.05), blurRadius: Dimens.r12, offset: Offset(0, -Dimens.h4)),
  ];

  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(color: AppColors.black.withValues(alpha: 0.08), blurRadius: Dimens.r8, offset: Offset(0, Dimens.h4)),
  ];

  static List<BoxShadow> get subtleShadow => [
    BoxShadow(color: AppColors.black.withValues(alpha: 0.05), blurRadius: Dimens.r4, offset: Offset(0, Dimens.h2)),
  ];

  static const Duration crossFadeDuration = Duration(milliseconds: 200);

  // ─── Font Families ───────────────────────────────────────────────────────
  static String get headingFamily => GoogleFonts.poppins().fontFamily!;
  static String get bodyFamily => GoogleFonts.nunito().fontFamily!;

  // ─── Display (Poppins — headings, titles) ────────────────────────────────
  static TextStyle get display1 => GoogleFonts.poppins(fontSize: 32.sp, fontWeight: FontWeight.w700, height: 1.2);

  static TextStyle get display2 => GoogleFonts.poppins(fontSize: 28.sp, fontWeight: FontWeight.w700, height: 1.2);

  // ─── Headings (Poppins) ──────────────────────────────────────────────────
  static TextStyle get heading1 => GoogleFonts.poppins(fontSize: 24.sp, fontWeight: FontWeight.w700, height: 1.3);

  static TextStyle get heading2 => GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w600, height: 1.3);

  static TextStyle get heading3 => GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600, height: 1.3);

  static TextStyle get heading4 => GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1.4);

  // ─── Body (Nunito) ───────────────────────────────────────────────────────
  static TextStyle get bodyLarge => GoogleFonts.nunito(fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.5);

  static TextStyle get bodyMedium => GoogleFonts.nunito(fontSize: 14.sp, fontWeight: FontWeight.w400, height: 1.5);

  static TextStyle get bodySmall => GoogleFonts.nunito(fontSize: 12.sp, fontWeight: FontWeight.w400, height: 1.5);

  static TextStyle get bodyLargeBold => GoogleFonts.nunito(fontSize: 16.sp, fontWeight: FontWeight.w700, height: 1.5);

  static TextStyle get bodyMediumBold => GoogleFonts.nunito(fontSize: 14.sp, fontWeight: FontWeight.w700, height: 1.5);

  static TextStyle get bodySmallBold => GoogleFonts.nunito(fontSize: 12.sp, fontWeight: FontWeight.w700, height: 1.5);

  // ─── Label / Caption (Nunito) ────────────────────────────────────────────
  static TextStyle get labelLarge => GoogleFonts.nunito(fontSize: 14.sp, fontWeight: FontWeight.w600, letterSpacing: 0.1, height: 1.4);

  static TextStyle get labelMedium => GoogleFonts.nunito(fontSize: 12.sp, fontWeight: FontWeight.w600, letterSpacing: 0.5, height: 1.4);

  static TextStyle get labelSmall => GoogleFonts.nunito(fontSize: 10.sp, fontWeight: FontWeight.w600, letterSpacing: 0.5, height: 1.4);

  static TextStyle get caption => GoogleFonts.nunito(fontSize: 11.sp, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.4);

  // ─── Button ──────────────────────────────────────────────────────────────
  static TextStyle get buttonLarge => GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w600, letterSpacing: 0.5, height: 1.2);

  static TextStyle get buttonMedium => GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w600, letterSpacing: 0.5, height: 1.2);

  // ─── Overline ────────────────────────────────────────────────────────────
  static TextStyle get overline => GoogleFonts.nunito(fontSize: 10.sp, fontWeight: FontWeight.w700, letterSpacing: 1.5, height: 1.4);
}
