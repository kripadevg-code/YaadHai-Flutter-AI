import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/modules/scanner/bloc/flashcards_tab_cubit.dart';

class FlashcardsTab extends StatelessWidget {
  const FlashcardsTab({super.key, required this.pack});
  final dynamic pack;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => FlashcardsTabCubit(), child: _FlashcardsTabView(pack: pack));
  }
}

class _FlashcardsTabView extends StatelessWidget {
  const _FlashcardsTabView({required this.pack});
  final dynamic pack;

  @override
  Widget build(BuildContext context) {
    final cards = pack.flashcards as List;
    if (cards.isEmpty) {
      return Center(child: Text(AppStrings.noFlashcardsGenerated, style: AppStyles.bodyMedium));
    }

    return BlocBuilder<FlashcardsTabCubit, FlashcardsTabState>(
      builder: (context, state) {
        final card = cards[state.current];
        final cubit = context.read<FlashcardsTabCubit>();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.w16),
              child: Row(
                children: [
                  Icon(Icons.flip_to_back_rounded, color: AppColors.primary, size: Dimens.icon24),
                  SizedBox(width: Dimens.w8),
                  Text(
                    'Flashcards',
                    style: AppStyles.heading3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.grey900,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.w20, vertical: Dimens.h12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${state.current + 1} / ${cards.length}', style: AppStyles.labelLarge.copyWith(color: AppColors.grey600)),
                  Text(
                    state.isFlipped ? 'Answer' : 'Question',
                    style: AppStyles.labelMedium.copyWith(color: state.isFlipped ? AppColors.success : AppColors.primary),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.r4),
                child: LinearProgressIndicator(
                  value: (state.current + 1) / cards.length,
                  backgroundColor: AppColors.grey200,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 4,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(Dimens.w20),
                child: GestureDetector(
                  onTap: () => cubit.flip(),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          state.isFlipped
                              ? (Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.success.withValues(alpha: 0.1)
                                  : AppColors.success.withValues(alpha: 0.05))
                              : (Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.white),
                      borderRadius: BorderRadius.circular(Dimens.r24),
                      border: Border.all(
                        color:
                            state.isFlipped
                                ? AppColors.success.withValues(alpha: 0.3)
                                : (Theme.of(context).brightness == Brightness.dark ? AppColors.grey700 : AppColors.grey200),
                        width: 1.5,
                      ),
                      boxShadow: [
                        if (Theme.of(context).brightness != Brightness.dark && !state.isFlipped)
                          BoxShadow(color: AppColors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, 8)),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h20),
                    child: Center(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(Dimens.w12),
                              decoration: BoxDecoration(
                                color:
                                    state.isFlipped ? AppColors.success.withValues(alpha: 0.1) : AppColors.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                state.isFlipped ? Icons.lightbulb_rounded : Icons.help_outline_rounded,
                                color: state.isFlipped ? AppColors.success : AppColors.primary,
                                size: Dimens.icon24,
                              ),
                            ),
                            SizedBox(height: Dimens.h16),
                            Text(
                              state.isFlipped ? card.answer : card.question,
                              textAlign: TextAlign.center,
                              style: AppStyles.heading4.copyWith(
                                color: Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.grey900,
                                height: 1.4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!state.isFlipped && card.hint != null) ...[
                              SizedBox(height: Dimens.h12),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: Dimens.w12, vertical: Dimens.h6),
                                decoration: BoxDecoration(
                                  color: AppColors.grey200.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(Dimens.r8),
                                  border: Border.all(color: AppColors.grey300),
                                ),
                                child: Text(
                                  'Hint: ${card.hint}',
                                  style: AppStyles.bodySmall.copyWith(color: AppColors.grey600, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                            SizedBox(height: Dimens.h20),
                            Text(
                              state.isFlipped ? 'Tap to see question' : AppStrings.tapToReveal,
                              style: AppStyles.labelSmall.copyWith(
                                color: Theme.of(context).brightness == Brightness.dark ? AppColors.grey500 : AppColors.grey400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(Dimens.w20, 0, Dimens.w20, Dimens.h20),
                child: Row(
                  children: [
                    if (state.current > 0)
                      Expanded(child: OutlinedButton(onPressed: () => cubit.prev(), child: const Text(AppStrings.prev))),
                    if (state.current > 0) SizedBox(width: Dimens.w12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: state.current < cards.length - 1 ? () => cubit.next() : null,
                        child: Text(state.current < cards.length - 1 ? 'Next →' : 'Done! 🎉'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
