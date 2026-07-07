import 'package:flutter/material.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class StudyPackHeader extends StatelessWidget {
  const StudyPackHeader({
    super.key,
    required this.chapterTitle,
    required this.pack,
    this.onDownload,
    this.onShare,
    this.onBookmark,
    this.isBookmarked = false,
  });

  final String chapterTitle;
  final StudyPackResult pack;
  final VoidCallback? onDownload;
  final VoidCallback? onShare;
  final VoidCallback? onBookmark;
  final bool isBookmarked;

  int _estimateReadMinutes() {
    final int wordCount = pack.summary.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
    return (wordCount / 200).ceil().clamp(1, 30);
  }

  int _totalKeyPoints() {
    if (pack.keyPoints.isNotEmpty) return pack.keyPoints.length;
    return pack.concepts.fold<int>(0, (total, concept) => total + (concept.keyPoints.isNotEmpty ? concept.keyPoints.length : 1));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final int readMinutes = _estimateReadMinutes();
    final int keyPointCount = _totalKeyPoints();

    return Padding(
      padding: EdgeInsets.fromLTRB(Dimens.w16, Dimens.h16, Dimens.w16, Dimens.h12),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkTheme ? AppColors.darkCard : AppColors.white,
          borderRadius: BorderRadius.circular(Dimens.r24),
          boxShadow: isDarkTheme ? null : AppStyles.cardShadow,
          border: Border.all(color: isDarkTheme ? AppColors.grey800 : AppColors.grey100, width: 1.2),
        ),
        padding: EdgeInsets.all(Dimens.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(Dimens.w10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(Dimens.r12),
                  ),
                  child: Icon(Icons.auto_awesome_rounded, color: AppColors.primary, size: Dimens.icon22),
                ),
                SizedBox(width: Dimens.w12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chapterTitle,
                        style: AppStyles.heading3.copyWith(
                          color: isDarkTheme ? AppColors.white : AppColors.grey900,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: Dimens.h6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          _StatPill(icon: Icons.timer_outlined, label: '$readMinutes min read', color: AppColors.primary),
                          _StatPill(icon: Icons.fact_check_outlined, label: '$keyPointCount points', color: AppColors.success),
                          _StatPill(icon: Icons.bolt_rounded, label: 'AI Ready', color: AppColors.brandPurple),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimens.h14),
            Divider(color: isDarkTheme ? AppColors.grey800 : AppColors.grey100, thickness: 1.0),
            SizedBox(height: Dimens.h10),
            Row(
              children: [
                _HeaderActionButton(
                  icon: isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                  label: isBookmarked ? 'Bookmarked' : 'Bookmark',
                  onTap: onBookmark,
                  color: AppColors.primary,
                  isFilled: isBookmarked,
                ),
                const Spacer(),
                _HeaderActionButton(
                  icon: Icons.download_rounded,
                  label: AppStrings.download,
                  onTap: onDownload,
                  color: isDarkTheme ? AppColors.grey300 : AppColors.grey700,
                ),
                SizedBox(width: Dimens.w8),
                _HeaderActionButton(
                  icon: Icons.share_rounded,
                  label: AppStrings.share,
                  onTap: onShare,
                  color: isDarkTheme ? AppColors.grey300 : AppColors.grey700,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.icon, required this.label, required this.color});

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(label, style: AppStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w700, fontSize: 10)),
        ],
      ),
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({required this.icon, required this.label, required this.onTap, required this.color, this.isFilled = false});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color color;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.r10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.w12, vertical: Dimens.h8),
          decoration: BoxDecoration(
            color: isFilled ? color.withValues(alpha: 0.12) : AppColors.transparent,
            borderRadius: BorderRadius.circular(Dimens.r10),
            border: Border.all(
              color: isFilled ? color.withValues(alpha: 0.3) : (isDark ? AppColors.grey800 : AppColors.grey200),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: Dimens.icon16, color: isFilled ? color : color.withValues(alpha: 0.8)),
              SizedBox(width: Dimens.w6),
              Text(
                label,
                style: AppStyles.caption.copyWith(
                  color: isFilled ? color : (isDark ? AppColors.grey300 : AppColors.grey700),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
