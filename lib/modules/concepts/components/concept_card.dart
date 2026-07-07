import 'package:flutter/material.dart';
import 'package:yaad_hai/core/ai/ai_config.dart';
import 'package:yaad_hai/core/ai/gemini_service.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/services/language_service.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ConceptCard extends StatelessWidget {
  const ConceptCard({super.key, required this.concept});
  final Concept concept;

  static const _masteryColors = [
    AppColors.grey300,
    AppColors.error,
    AppColors.warning,
    AppColors.info,
    AppColors.success,
    AppColors.primary,
  ];

  static const _masteryLabels = ['—', 'Learning', 'Familiar', 'Good', 'Mastered', 'Expert'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final level = concept.masteryLevel.clamp(0, 5);
    final masteryColor = _masteryColors[level];

    return PremiumCard(
      padding: EdgeInsets.all(Dimens.w16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title + mastery badge ────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: Text(
                  concept.title,
                  style: AppStyles.heading4.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: Dimens.w12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimens.w8, vertical: Dimens.h4),
                decoration: BoxDecoration(
                  color: masteryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Dimens.r8),
                  border: Border.all(color: masteryColor.withValues(alpha: 0.3)),
                ),
                child: Text(_masteryLabels[level], style: AppStyles.labelSmall.copyWith(color: masteryColor, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          SizedBox(height: Dimens.h8),

          // ── English summary ──────────────────────────────────────────────
          Text(
            concept.summary,
            style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey600, height: 1.5),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          // ── Hindi expandable section ─────────────────────────────────────
          if (AiConfig.isAiEnabled) _HindiSection(concept: concept, isDark: isDark),

          // ── Interview relevant badge ──────────────────────────────────────
          if (concept.isInterviewRelevant) ...[
            SizedBox(height: Dimens.h10),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.w8, vertical: Dimens.h4),
                  decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star_rounded, size: Dimens.icon10, color: AppColors.accent),
                      SizedBox(width: Dimens.w4),
                      Text(
                        AppStrings.interviewRelevant,
                        style: AppStyles.caption.copyWith(color: AppColors.accent, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Dimens.w8),
                Text(
                  '${AppStrings.importanceScore}: ${concept.importanceScore}/10',
                  style: AppStyles.caption.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey400),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Hindi Section ────────────────────────────────────────────────────────────

class _HindiSection extends StatefulWidget {
  const _HindiSection({required this.concept, required this.isDark});

  final Concept concept;
  final bool isDark;

  @override
  State<_HindiSection> createState() => _HindiSectionState();
}

class _HindiSectionState extends State<_HindiSection> {
  final _languageService = locator<LanguageService>();

  bool _expanded = false;
  bool _loading = false;
  String? _hindiText;
  String? _error;

  @override
  void initState() {
    super.initState();
    _languageService.addListener(_onLanguageChanged);
    if (_languageService.isHindi) _maybeLoad();
  }

  @override
  void dispose() {
    _languageService.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    if (_languageService.isHindi && _hindiText == null) {
      _maybeLoad();
    }
    if (mounted) setState(() {});
  }

  Future<void> _maybeLoad() async {
    if (_hindiText != null || _loading) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final translated = await GeminiService.instance.translateToHindi('${widget.concept.title}. ${widget.concept.summary}');
      if (mounted) {
        setState(() {
          _hindiText = translated;
          _loading = false;
          _expanded = true;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _error = 'अनुवाद उपलब्ध नहीं';
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isHindi = _languageService.isHindi;

    // Hide entirely when Hindi mode is off and never loaded
    if (!isHindi && _hindiText == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimens.h10),
        GestureDetector(
          onTap: () {
            if (_hindiText == null && !_loading) {
              _maybeLoad();
            } else {
              setState(() => _expanded = !_expanded);
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: Dimens.w12, vertical: Dimens.h8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: widget.isDark ? 0.15 : 0.06),
              borderRadius: BorderRadius.circular(Dimens.r10),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.translate_rounded, size: Dimens.icon16, color: AppColors.primary),
                SizedBox(width: Dimens.w8),
                Text('हिंदी में पढ़ें', style: AppStyles.labelSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                const Spacer(),
                if (_loading)
                  SizedBox(
                    width: Dimens.icon16,
                    height: Dimens.icon16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                  )
                else
                  Icon(
                    _expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    size: Dimens.icon16,
                    color: AppColors.primary,
                  ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: AppStyles.crossFadeDuration,
          crossFadeState: _expanded && (_hindiText != null || _error != null) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild:
              _hindiText != null
                  ? Padding(
                    padding: EdgeInsets.only(top: Dimens.h8),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(Dimens.w12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: widget.isDark ? 0.1 : 0.04),
                        borderRadius: BorderRadius.circular(Dimens.r10),
                      ),
                      child: Text(
                        _hindiText!,
                        style: AppStyles.bodySmall.copyWith(color: widget.isDark ? AppColors.grey300 : AppColors.grey700, height: 1.6),
                      ),
                    ),
                  )
                  : Padding(
                    padding: EdgeInsets.only(top: Dimens.h8),
                    child: Text(_error ?? '', style: AppStyles.caption.copyWith(color: AppColors.error)),
                  ),
          secondChild: const SizedBox.shrink(),
        ),
      ],
    );
  }
}
