import 'package:flutter/material.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/modules/scanner/components/summary_memory_hook.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';

abstract class SummaryMemoryHookBuilder {
  static List<SummaryMemoryHook> build(StudyPackResult pack) {
    final String summaryText = pack.summary;
    final List<ConceptData> concepts = pack.concepts;
    final String mainSubject = concepts.isNotEmpty ? concepts[0].title : AppStrings.knowledgeTreeOverview;
    final String secondarySubject = concepts.length > 1 ? concepts[1].title : AppStrings.memoryHookSecondaryFallback;

    String analogyContent = AppStrings.memoryHookAnalogyFor(mainSubject);
    String mnemonicContent = AppStrings.memoryHookMnemonicFor(mainSubject, secondarySubject);
    String realWorldContent = AppStrings.memoryHookRealWorldFor(mainSubject);

    final String summaryLower = summaryText.toLowerCase();
    if (summaryLower.contains('photosynthesis') || mainSubject.toLowerCase().contains('photosynthesis')) {
      analogyContent = AppStrings.memoryHookAnalogyPhotosynthesis;
      mnemonicContent = AppStrings.memoryHookMnemonicPhotosynthesis;
      realWorldContent = AppStrings.memoryHookRealWorldPhotosynthesis;
    } else if (summaryLower.contains('cell') || mainSubject.toLowerCase().contains('cell')) {
      analogyContent = AppStrings.memoryHookAnalogyCell;
      mnemonicContent = AppStrings.memoryHookMnemonicCell;
      realWorldContent = AppStrings.memoryHookRealWorldCell;
    }

    return [
      SummaryMemoryHook(type: AppStrings.analogy, content: analogyContent, icon: Icons.link_rounded, color: AppColors.primary),
      SummaryMemoryHook(type: AppStrings.mnemonic, content: mnemonicContent, icon: Icons.star_rounded, color: AppColors.warning),
      SummaryMemoryHook(type: AppStrings.realWorldExample, content: realWorldContent, icon: Icons.public_rounded, color: AppColors.accent),
    ];
  }
}
