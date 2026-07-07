import 'package:flutter/material.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/modules/scanner/components/concept_card.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ConceptsTab extends StatelessWidget {
  const ConceptsTab({super.key, required this.pack});

  final StudyPackResult pack;

  @override
  Widget build(BuildContext context) {
    if (pack.concepts.isEmpty) {
      return Center(
        child: Text(
          'No concepts extracted.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(Dimens.w20),
      physics: const BouncingScrollPhysics(),
      itemCount: pack.concepts.length,
      separatorBuilder: (context, index) => SizedBox(height: Dimens.h16),
      itemBuilder: (context, index) {
        final concept = pack.concepts[index];
        return ConceptCard(concept: concept, index: index + 1);
      },
    );
  }
}
