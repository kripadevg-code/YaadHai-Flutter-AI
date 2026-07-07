import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class TextOnlyView extends StatelessWidget {
  const TextOnlyView({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Dimens.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(Dimens.w14),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(Dimens.r12),
              border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, color: AppColors.warning, size: Dimens.icon20),
                SizedBox(width: Dimens.w10),
                Expanded(
                  child: Text(
                    'AI features not configured. Showing extracted text only. Add your Gemini API key to enable study pack generation.',
                    style: AppStyles.bodySmall.copyWith(color: AppColors.warning),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimens.h16),
          Text('Extracted Text', style: AppStyles.heading3.copyWith(color: Theme.of(context).textTheme.headlineMedium?.color)),
          SizedBox(height: Dimens.h8),
          Text(text, style: AppStyles.bodyMedium),
        ],
      ),
    );
  }
}
