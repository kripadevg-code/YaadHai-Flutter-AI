import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/modules/concepts/bloc/concepts_bloc.dart';
import 'package:yaad_hai/modules/concepts/components/add_concept_sheet.dart';
import 'package:yaad_hai/modules/concepts/components/concept_card.dart';
import 'package:yaad_hai/modules/concepts/components/concepts_empty_view.dart';
import 'package:yaad_hai/modules/concepts/components/concepts_filter_bar.dart';
import 'package:yaad_hai/modules/concepts/components/concepts_header.dart';
import 'package:yaad_hai/modules/concepts/repos/concepts_repo.dart';
import 'package:yaad_hai/modules/revision/repos/revision_repo.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ConceptsPage extends StatelessWidget {
  const ConceptsPage({super.key, required this.chapter});
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              ConceptsBloc(conceptsRepository: locator<ConceptsRepo>(), revisionRepository: locator<RevisionRepo>())
                ..add(ConceptsEventWatch(chapter.id)),
      child: _ConceptsView(chapter: chapter),
    );
  }
}

class _ConceptsView extends StatelessWidget {
  const _ConceptsView({required this.chapter});
  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConceptsBloc, ConceptsState>(
      builder: (context, state) {
        final bloc = context.read<ConceptsBloc>();
        final concepts = switch (state.filterIndex) {
          1 => state.weakConcepts,
          2 => state.interviewConcepts,
          _ => state.concepts,
        };

        return AppScaffold(
          hideOnScroll: true,
          topHeader: ConceptsHeader(chapter: chapter, onAdd: () => _showAddSheet(context)),
          slivers: [
            SliverToBoxAdapter(
              child: ConceptsFilterBar(
                selectedIndex: state.filterIndex,
                total: state.concepts.length,
                weakCount: state.weakConcepts.length,
                interviewCount: state.interviewConcepts.length,
                onChanged: (i) => bloc.add(ConceptsEventChangeFilter(i)),
              ),
            ),
            if (state.status == ConceptsStatus.loading && !state.hasData)
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
            else if (concepts.isEmpty)
              SliverFillRemaining(child: ConceptsEmptyView(isFiltered: state.filterIndex != 0, onAdd: () => _showAddSheet(context)))
            else
              SliverPadding(
                padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h8, Dimens.w20, Dimens.h20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(padding: EdgeInsets.only(bottom: Dimens.h10), child: ConceptCard(concept: concepts[index])),
                    childCount: concepts.length,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showAddSheet(BuildContext context) {
    context.read<ConceptsBloc>().add(ConceptsEventResetForm());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(value: context.read<ConceptsBloc>(), child: AddConceptSheet(chapter: chapter)),
    );
  }
}
