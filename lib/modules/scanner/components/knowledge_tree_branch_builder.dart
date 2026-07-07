import 'package:flutter/material.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/modules/scanner/components/knowledge_tree_branch.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';

abstract class KnowledgeTreeBranchBuilder {
  static const List<Color> branchColors = [AppColors.primary, AppColors.accent, AppColors.success, AppColors.warning, AppColors.info];

  static List<KnowledgeTreeBranch> build(List<ConceptData> concepts) {
    if (concepts.isEmpty) {
      return [const KnowledgeTreeBranch(label: AppStrings.knowledgeTreeOverview, color: AppColors.primary, leaves: [])];
    }

    return List.generate(concepts.length.clamp(0, 4), (index) {
      final ConceptData concept = concepts[index];
      final List<String> leaves = concept.keyPoints.isNotEmpty ? concept.keyPoints.take(3).toList() : [concept.title];

      return KnowledgeTreeBranch(label: concept.title, color: branchColors[index % branchColors.length], leaves: leaves);
    });
  }
}
