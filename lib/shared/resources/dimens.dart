import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Dimens {
  // ─── Heights (vertical .h) ───────────────────────────────────────────────
  static double get h2 => 2.h;
  static double get h3 => 3.h;
  static double get h4 => 4.h;
  static double get h5 => 5.h;
  static double get h6 => 6.h;
  static double get h8 => 8.h;
  static double get h10 => 10.h;
  static double get h12 => 12.h;
  static double get h14 => 14.h;
  static double get h16 => 16.h;
  static double get h18 => 18.h;
  static double get h20 => 20.h;
  static double get h22 => 22.h;
  static double get h24 => 24.h;
  static double get h28 => 28.h;
  static double get h30 => 30.h;
  static double get h32 => 32.h;
  static double get h36 => 36.h;
  static double get h40 => 40.h;
  static double get h48 => 48.h;
  static double get h50 => 50.h;
  static double get h52 => 52.h;
  static double get h54 => 54.h;
  static double get h56 => 56.h;
  static double get h64 => 64.h;
  static double get h72 => 72.h;
  static double get h80 => 80.h;
  static double get h88 => 88.h;
  static double get h100 => 100.h;
  static double get h120 => 120.h;
  static double get h150 => 150.h;
  static double get h200 => 200.h;
  static double get h240 => 240.h;

  // ─── Widths (horizontal .w) ──────────────────────────────────────────────
  static double get w2 => 2.w;
  static double get w4 => 4.w;
  static double get w6 => 6.w;
  static double get w8 => 8.w;
  static double get w10 => 10.w;
  static double get w12 => 12.w;
  static double get w14 => 14.w;
  static double get w16 => 16.w;
  static double get w18 => 18.w;
  static double get w20 => 20.w;
  static double get w22 => 22.w;
  static double get w24 => 24.w;
  static double get w28 => 28.w;
  static double get w32 => 32.w;
  static double get w36 => 36.w;
  static double get w40 => 40.w;
  static double get w44 => 44.w;
  static double get w48 => 48.w;
  static double get w52 => 52.w;
  static double get w56 => 56.w;
  static double get w80 => 80.w;
  static double get w88 => 88.w;
  static double get w120 => 120.w;
  static double get w140 => 140.w;
  static double get w260 => 260.w;
  static double get w60 => 60.w;

  // ─── Radius (radial .r) ──────────────────────────────────────────────────
  static double get r2 => 2.r;
  static double get r4 => 4.r;
  static double get r6 => 6.r;
  static double get r8 => 8.r;
  static double get r10 => 10.r;
  static double get r12 => 12.r;
  static double get r14 => 14.r;
  static double get r16 => 16.r;
  static double get r18 => 18.r;
  static double get r20 => 20.r;
  static double get r24 => 24.r;
  static double get r28 => 28.r;
  static double get r32 => 32.r;
  static double get r40 => 40.r;
  static double get r100 => 100.r;

  // ─── Icon sizes (.r) ────────────────────────────────────────────────────
  static double get icon10 => 10.r;
  static double get icon14 => 14.r;
  static double get icon16 => 16.r;
  static double get icon18 => 18.r;
  static double get icon20 => 20.r;
  static double get icon22 => 22.r;
  static double get icon24 => 24.r;
  static double get icon28 => 28.r;
  static double get icon32 => 32.r;
  static double get icon44 => 44.r;
  static double get icon48 => 48.r;
  static double get icon56 => 56.r;

  // ─── Layout breakpoints & misc ───────────────────────────────────────────
  static double get wideLayoutBreakpoint => 720.w;
  static double get compactHeaderBreakpoint => 600.w;
  static double get connectorWidth => w2;
  static double get borderWidthMedium => w2 * 0.75;

  // ─── PDF Export Dimensions ───────────────────────────────────────────────
  // Note: PDF dimensions are in points (not responsive), but centralized for consistency
  static const double pdfPadding20 = 20.0;
  static const double pdfPadding16 = 16.0;
  static const double pdfPadding12 = 12.0;
  static const double pdfPadding10 = 10.0;
  static const double pdfPadding8 = 8.0;
  static const double pdfPadding6 = 6.0;
  static const double pdfPadding3 = 3.0;
  static const double pdfSpacing30 = 30.0;
  static const double pdfSpacing24 = 24.0;
  static const double pdfSpacing16 = 16.0;
  static const double pdfSpacing12 = 12.0;
  static const double pdfSpacing10 = 10.0;
  static const double pdfSpacing8 = 8.0;
  static const double pdfSpacing4 = 4.0;
  static const double pdfRadius12 = 12.0;
  static const double pdfRadius8 = 8.0;
  static const double pdfRadius6 = 6.0;
  static const double pdfStatCardWidth = 120.0;
  static const double pdfNumberBoxSize = 28.0;
  static const double pdfOptionCircleSize = 24.0;
  static const double pdfBulletSize = 6.0;
  static const double pdfBorderWidth1 = 1.0;
  static const double pdfBorderWidth2 = 2.0;

  // Font sizes
  static const double pdfFontSize28 = 28.0;
  static const double pdfFontSize24 = 24.0;
  static const double pdfFontSize20 = 20.0;
  static const double pdfFontSize18 = 18.0;
  static const double pdfFontSize16 = 16.0;
  static const double pdfFontSize14 = 14.0;
  static const double pdfFontSize12 = 12.0;
  static const double pdfFontSize11 = 11.0;
  static const double pdfFontSize10 = 10.0;
  static const double pdfFontSize9 = 9.0;
  static const double pdfFontSize8 = 8.0;

  // Line spacing
  static const double pdfLineSpacing1_5 = 1.5;
  static const double pdfLineSpacing1_4 = 1.4;

  // ─── Tab Bar Height Dimensions ──────────────────────────────────────────
  static const double tabBarHeight = 58.0;

  // ─── Mastery Page Dimensions ────────────────────────────────────────────
  static const double masteryCircularProgressSize = 104.0;
  static const double masteryCircularProgressStroke = 9.0;
  static const double masteryInnerCircleSize = 66.0;
  static const double masteryInnerIconSize = 32.0;
  static const double masteryBadgePaddingHorizontal = 10.0;
  static const double masteryBadgePaddingVertical = 4.0;
  static const double masteryStatBorderWidth = 1.5;
  static const double masteryWeakConceptBorderWidth = 1.2;
  static const double masteryProgressBadgePaddingH = 8.0;
  static const double masteryProgressBadgePaddingV = 2.0;

  // ─── Subject Page Dimensions ────────────────────────────────────────────
  static const double subjectAddIconSize = 20.0;
  static const double subjectBorderLeftWidth = 4.0;
  static const double subjectColorCheckIconSize = 18.0;
  static const double subjectColorBorderWidth = 2.5;
  static const double subjectIconBorderWidth = 1.5;
}
