import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand / Premium Primary
  static const Color primary = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryLight = Color(0xFF818CF8); // Indigo 400
  static const Color primaryDark = Color(0xFF3730A3); // Indigo 800
  static const Color accent = Color(0xFF0EA5E9); // Light Blue 500
  static const Color accentDark = Color(0xFF0369A1); // Light Blue 700

  // Semantic
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color successDark = Color(0xFF059669); // Emerald 600
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color warningDark = Color(0xFFD97706); // Amber 600
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color info = Color(0xFF3B82F6); // Blue 500
  static const Color brandPurple = Color(0xFF6D28D9); // Violet 700
  static const Color scanMint = Color(0xFFE9F7F0);
  static const Color scanMintDark = Color(0xFF163A2C);
  static const Color homeInk = Color(0xFF20231B);

  // Google brand (login)
  static const Color googleRed = Color(0xFFEA4335);
  static const Color googleYellow = Color(0xFFFBBC05);
  static const Color googleGreen = Color(0xFF34A853);
  static const Color googleBlue = Color(0xFF4285F4);

  // Structural Greys (SaaS Standard)
  static const Color grey50 = Color(0xFFF9FAFB); // Scaffold Background
  static const Color grey100 = Color(0xFFF3F4F6); // Hover states
  static const Color grey200 = Color(0xFFE5E7EB); // Structural Borders
  static const Color grey300 = Color(0xFFD1D5DB); // Stronger Borders
  static const Color grey400 = Color(0xFF9CA3AF); // Disabled Text
  static const Color grey500 = Color(0xFF6B7280); // Secondary Text
  static const Color grey600 = Color(0xFF4B5563); // Muted Text
  static const Color grey700 = Color(0xFF374151); // Subheadings
  static const Color grey800 = Color(0xFF1F2937); // Primary Text
  static const Color grey900 = Color(0xFF111827); // Headings / Pure Black Alt

  // Mastery levels
  static const Color masteryNone = grey200;
  static const Color masteryLow = error;
  static const Color masteryMedium = warning;
  static const Color masteryHigh = success;
  static const Color masteryMaster = primary;

  // Neutral
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = grey900;
  static const Color transparent = Color(0x00000000);

  // Dark theme
  static const Color darkBackground = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);
  static const Color darkCard = Color(0xFF1F2937);

  // PDF Export
  static const Color pdfPrimary = Color(0xFF6C5CE7); // YaadHai purple
  static const Color pdfPrimaryLight = Color(0xFFEBE9FE); // Pale purple tint
  static const Color pdfPrimaryLighter = Color(0xFFF5F4FF); // Lightest purple
}
