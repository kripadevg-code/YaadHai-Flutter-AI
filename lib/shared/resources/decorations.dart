import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

/// Shared decoration helpers for consistent UI styling across the app.
///
/// Rewritten to use the project's own design system instead of the legacy
/// `infinity` / `get` packages.
abstract class KDecoration {
  static BoxDecoration get boxDecoration => BoxDecoration(
    color: AppColors.white,
    border: Border.all(width: 1, color: AppColors.grey200),
    borderRadius: BorderRadius.circular(Dimens.r10),
  );

  static BoxDecoration dynamicBoxDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? AppColors.darkCard : AppColors.white,
      borderRadius: BorderRadius.circular(Dimens.r10),
      border: isDark ? null : Border.all(width: 1, color: AppColors.grey200),
    );
  }

  static RoundedRectangleBorder get sheetShape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimens.r24), topRight: Radius.circular(Dimens.r24)));

  static InputDecoration textfieldDecoration(BuildContext context, {String? hintText, String? labelText, String? errorText}) {
    return InputDecoration(
      errorText: errorText,
      hintText: hintText,
      labelText: labelText,
      errorMaxLines: 2,
      contentPadding: EdgeInsets.all(Dimens.h10),
      border: _border(context, false),
      enabledBorder: _border(context, false),
      focusedBorder: _border(context, true),
      errorBorder: _border(context, false),
      disabledBorder: _border(context, false),
    );
  }

  static OutlineInputBorder _border(BuildContext context, bool isEnabled) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Dimens.r10),
      borderSide: BorderSide(width: isEnabled ? 1.2 : 0.8, color: Theme.of(context).colorScheme.primary),
    );
  }
}
