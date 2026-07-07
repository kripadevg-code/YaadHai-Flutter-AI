import 'package:flutter/material.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ScannerSubjectPickerSheet extends StatelessWidget {
  const ScannerSubjectPickerSheet({super.key, required this.subjects});

  final List<Subject> subjects;

  static Future<String?> show(BuildContext context, List<Subject> subjects) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.transparent,
      isScrollControlled: true,
      builder: (_) => ScannerSubjectPickerSheet(subjects: subjects),
    );
  }

  Color _subjectColor(String colorHex) => Color(int.parse('0xFF$colorHex'));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.r24)),
      ),
      padding: EdgeInsets.symmetric(horizontal: Dimens.w24, vertical: Dimens.h24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: Dimens.h20),
          Text(
            AppStrings.selectSubject,
            style: AppStyles.heading3.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: Dimens.h8),
          Text(
            AppStrings.selectSubjectBody,
            style: AppStyles.bodyMedium.copyWith(color: isDarkTheme ? AppColors.grey400 : AppColors.grey500),
          ),
          SizedBox(height: Dimens.h16),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.4),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final Subject subject = subjects[index];
                final Color color = _subjectColor(subject.colorHex);

                return Padding(
                  padding: EdgeInsets.only(bottom: Dimens.h8),
                  child: InkWell(
                    onTap: () => Navigator.pop(context, subject.id),
                    borderRadius: BorderRadius.circular(Dimens.r12),
                    child: Container(
                      padding: EdgeInsets.all(Dimens.w16),
                      decoration: BoxDecoration(
                        border: Border.all(color: isDarkTheme ? AppColors.grey800 : AppColors.grey200),
                        borderRadius: BorderRadius.circular(Dimens.r12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(Dimens.w8),
                            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
                            child: Icon(Icons.menu_book_rounded, color: color, size: Dimens.icon20),
                          ),
                          SizedBox(width: Dimens.w16),
                          Expanded(
                            child: Text(
                              subject.name,
                              style: AppStyles.bodyMediumBold.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey900),
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded, color: isDarkTheme ? AppColors.grey500 : AppColors.grey400),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
