import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaad_hai/modules/scanner/bloc/scanner_bloc.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ScannerProcessingView extends StatelessWidget {
  const ScannerProcessingView({super.key, required this.state});
  final ScannerState state;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final systemOverlayStyle = isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemOverlayStyle.copyWith(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.grey50,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(Dimens.w20),
            child: PremiumCard(
              padding: EdgeInsets.all(Dimens.w32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(strokeWidth: 3, valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary)),
                  ),
                  SizedBox(height: Dimens.h24),
                  Text(
                    AppStrings.analyzingContent,
                    style: AppStyles.heading2.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: Dimens.h8),
                  Text(
                    state.progressMessage,
                    textAlign: TextAlign.center,
                    style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
