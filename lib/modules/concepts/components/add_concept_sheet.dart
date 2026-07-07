import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/concepts/bloc/concepts_bloc.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class AddConceptSheet extends StatelessWidget {
  const AddConceptSheet({super.key, required this.chapter});
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<ConceptsBloc, ConceptsState>(
      builder: (context, state) {
        final bloc = context.read<ConceptsBloc>();

        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.r24)),
          ),
          padding: EdgeInsets.only(
            left: Dimens.w24,
            right: Dimens.w24,
            top: Dimens.h16,
            bottom: MediaQuery.of(context).viewInsets.bottom + Dimens.h24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: Dimens.w40,
                    height: Dimens.h4,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.grey700 : AppColors.grey200,
                      borderRadius: BorderRadius.circular(Dimens.r2),
                    ),
                  ),
                ),
                SizedBox(height: Dimens.h20),
                Text(
                  AppStrings.addConcept,
                  style: AppStyles.heading3.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: Dimens.h24),
                PremiumCard(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h4),
                  child: TextField(
                    controller: bloc.titleController,
                    style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
                    decoration: InputDecoration(
                      hintText: AppStrings.conceptTitleHint,
                      hintStyle: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey400),
                      prefixIcon: const Icon(Icons.lightbulb_rounded, color: AppColors.primary),
                      border: InputBorder.none,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                SizedBox(height: Dimens.h12),
                PremiumCard(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h4),
                  child: TextField(
                    controller: bloc.summaryController,
                    style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
                    decoration: InputDecoration(
                      hintText: AppStrings.conceptSummaryHint,
                      hintStyle: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey400),
                      prefixIcon: const Icon(Icons.short_text_rounded, color: AppColors.grey400),
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                SizedBox(height: Dimens.h12),
                PremiumCard(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h4),
                  child: TextField(
                    controller: bloc.explanationController,
                    style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
                    decoration: InputDecoration(
                      hintText: '${AppStrings.detailedExplanation} (optional)',
                      hintStyle: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey400),
                      prefixIcon: const Icon(Icons.notes_rounded, color: AppColors.grey400),
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                SizedBox(height: Dimens.h20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${AppStrings.importanceScore}: ${state.importance.round()}/10',
                        style: AppStyles.labelLarge.copyWith(color: isDark ? AppColors.grey300 : AppColors.grey700),
                      ),
                    ),
                    Text('${state.importance.round()}', style: AppStyles.heading4.copyWith(color: AppColors.primary)),
                  ],
                ),
                Slider(
                  value: state.importance,
                  min: 1,
                  max: 10,
                  divisions: 9,
                  activeColor: AppColors.primary,
                  onChanged: (v) => bloc.add(ConceptsEventChangeImportance(v)),
                ),
                PremiumCard(
                  padding: EdgeInsets.zero,
                  child: SwitchListTile(
                    value: state.isInterviewRelevant,
                    activeTrackColor: AppColors.accent.withValues(alpha: 0.2),
                    activeThumbColor: AppColors.accent,
                    title: Text(
                      AppStrings.interviewRelevant,
                      style: AppStyles.bodyMedium.copyWith(
                        color: isDark ? AppColors.white : AppColors.grey900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'Mark for interview preparation',
                      style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey600),
                    ),
                    onChanged: (v) => bloc.add(ConceptsEventToggleInterview(v)),
                    contentPadding: EdgeInsets.symmetric(horizontal: Dimens.w16),
                  ),
                ),
                SizedBox(height: Dimens.h28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final title = bloc.titleController.text.trim();
                      final summary = bloc.summaryController.text.trim();
                      if (title.isEmpty || summary.isEmpty) return;
                      bloc.add(
                        ConceptsEventAdd(
                          chapterId: chapter.id,
                          subjectId: chapter.subjectId,
                          title: title,
                          summary: summary,
                          detailedExplanation:
                              bloc.explanationController.text.trim().isEmpty ? null : bloc.explanationController.text.trim(),
                          isInterviewRelevant: state.isInterviewRelevant,
                          importanceScore: state.importance.round(),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: Dimens.h16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r16)),
                    ),
                    child: Text(AppStrings.addConcept, style: AppStyles.labelLarge.copyWith(color: AppColors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
