import 'package:flutter/material.dart';
import 'package:yaad_hai/core/ai/ai_config.dart';
import 'package:yaad_hai/core/ai/gemini_service.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/services/language_service.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class FlashcardFlipCard extends StatelessWidget {
  const FlashcardFlipCard({super.key, required this.flashcard, required this.isFlipped, required this.onTap});

  final Flashcard flashcard;
  final bool isFlipped;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: isFlipped ? 1 : 0),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        builder: (context, value, _) {
          final angle = value * 3.14159;
          final showFront = value < 0.5;
          return Transform(
            alignment: Alignment.center,
            transform:
                Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
            child:
                showFront
                    ? _CardFace(flashcard: flashcard, isFront: true)
                    : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(3.14159),
                      child: _CardFace(flashcard: flashcard, isFront: false),
                    ),
          );
        },
      ),
    );
  }
}

// ─── Card Face ────────────────────────────────────────────────────────────────

class _CardFace extends StatelessWidget {
  const _CardFace({required this.flashcard, required this.isFront});
  final Flashcard flashcard;
  final bool isFront;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient:
            isFront
                ? const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                : LinearGradient(
                  colors: isDark ? [AppColors.darkCard, AppColors.darkSurface] : [AppColors.white, AppColors.grey50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        borderRadius: BorderRadius.circular(Dimens.r24),
        boxShadow: [
          BoxShadow(
            color: (isFront ? AppColors.primary : AppColors.grey400).withValues(alpha: 0.25),
            blurRadius: Dimens.r20,
            offset: Offset(0, Dimens.h10),
          ),
        ],
        border: isFront ? null : Border.all(color: isDark ? AppColors.grey700 : AppColors.grey200),
      ),
      padding: EdgeInsets.all(Dimens.w28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ── Label chip ────────────────────────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.w10, vertical: Dimens.h4),
            decoration: BoxDecoration(
              color: isFront ? AppColors.white.withValues(alpha: 0.2) : AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Dimens.r20),
            ),
            child: Text(
              isFront ? AppStrings.flashcardQuestion : AppStrings.flashcardAnswer,
              style: AppStyles.overline.copyWith(color: isFront ? AppColors.white : AppColors.success),
            ),
          ),
          SizedBox(height: Dimens.h24),

          // ── Main text ─────────────────────────────────────────────────
          Text(
            isFront ? flashcard.question : flashcard.answer,
            style: AppStyles.heading3.copyWith(
              color: isFront ? AppColors.white : (isDark ? AppColors.white : AppColors.grey900),
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),

          // ── Tap hint (front only) ──────────────────────────────────────
          if (isFront) ...[
            SizedBox(height: Dimens.h24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.touch_app_rounded, size: Dimens.icon20, color: AppColors.white.withValues(alpha: 0.6)),
                SizedBox(width: Dimens.w6),
                Text(AppStrings.tapToReveal, style: AppStyles.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.6))),
              ],
            ),
          ],

          // ── Hint box (back only) ───────────────────────────────────────
          if (!isFront && flashcard.hint != null && flashcard.hint!.isNotEmpty) ...[
            SizedBox(height: Dimens.h16),
            Container(
              padding: EdgeInsets.all(Dimens.w12),
              decoration: BoxDecoration(color: AppColors.warning.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r12)),
              child: Row(
                children: [
                  Icon(Icons.tips_and_updates_rounded, size: Dimens.icon16, color: AppColors.warning),
                  SizedBox(width: Dimens.w8),
                  Expanded(child: Text(flashcard.hint!, style: AppStyles.bodySmall.copyWith(color: AppColors.warning))),
                ],
              ),
            ),
          ],

          // ── Hindi translation (back only, when AI enabled) ─────────────
          if (!isFront && AiConfig.isAiEnabled) _HindiAnswerSection(answer: flashcard.answer, isDark: isDark),
        ],
      ),
    );
  }
}

// ─── Hindi Answer Section ─────────────────────────────────────────────────────

class _HindiAnswerSection extends StatefulWidget {
  const _HindiAnswerSection({required this.answer, required this.isDark});
  final String answer;
  final bool isDark;

  @override
  State<_HindiAnswerSection> createState() => _HindiAnswerSectionState();
}

class _HindiAnswerSectionState extends State<_HindiAnswerSection> {
  final _languageService = locator<LanguageService>();
  bool _loading = false;
  String? _hindiText;

  @override
  void initState() {
    super.initState();
    _languageService.addListener(_onLangChanged);
    if (_languageService.isHindi) _load();
  }

  @override
  void dispose() {
    _languageService.removeListener(_onLangChanged);
    super.dispose();
  }

  void _onLangChanged() {
    if (_languageService.isHindi && _hindiText == null) _load();
    if (mounted) setState(() {});
  }

  Future<void> _load() async {
    if (_hindiText != null || _loading) return;
    setState(() => _loading = true);
    try {
      final translated = await GeminiService.instance.translateToHindi(widget.answer);
      if (mounted) setState(() => _hindiText = translated);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_languageService.isHindi) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: Dimens.h16),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(Dimens.w12),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: widget.isDark ? 0.15 : 0.07),
          borderRadius: BorderRadius.circular(Dimens.r12),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        child:
            _loading
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Dimens.icon16,
                      height: Dimens.icon16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                    ),
                    SizedBox(width: Dimens.w8),
                    Text('अनुवाद हो रहा है...', style: AppStyles.caption.copyWith(color: AppColors.primary)),
                  ],
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.translate_rounded, size: Dimens.icon14, color: AppColors.primary),
                        SizedBox(width: Dimens.w6),
                        Text('हिंदी', style: AppStyles.overline.copyWith(color: AppColors.primary)),
                      ],
                    ),
                    SizedBox(height: Dimens.h6),
                    Text(
                      _hindiText ?? widget.answer,
                      style: AppStyles.bodySmall.copyWith(color: widget.isDark ? AppColors.grey300 : AppColors.grey700, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
      ),
    );
  }
}
