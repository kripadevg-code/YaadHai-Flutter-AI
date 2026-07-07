import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/modules/revision/bloc/revision_bloc.dart';
import 'package:yaad_hai/modules/revision/components/revision_card.dart';
import 'package:yaad_hai/modules/revision/components/revision_due_banner.dart';
import 'package:yaad_hai/modules/revision/components/revision_empty_state.dart';
import 'package:yaad_hai/modules/revision/repos/revision_repo.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class RevisionPage extends StatelessWidget {
  const RevisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RevisionBloc(repository: locator<RevisionRepo>())..add(RevisionEventWatch()),
      child: const RevisionView(),
    );
  }
}

class RevisionView extends StatelessWidget {
  const RevisionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RevisionBloc, RevisionState>(
      builder: (context, state) {
        final subtitle = state.dueCount > 0 ? AppStrings.revisionDueTodayCount(state.dueCount) : null;

        return AppScaffold(
          hideOnScroll: true,
          title: AppStrings.revision,
          subtitle: subtitle,
          actions: [
            if (state.dueCount > 0)
              Padding(
                padding: EdgeInsets.only(right: Dimens.w16, top: Dimens.h8, bottom: Dimens.h8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.w10, vertical: Dimens.h6),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Dimens.r20),
                    border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.schedule_rounded, size: Dimens.icon16, color: AppColors.warning),
                      SizedBox(width: Dimens.w4),
                      Text(
                        '${state.dueCount} ${AppStrings.revisionDueCount}',
                        style: AppStyles.labelSmall.copyWith(color: AppColors.warning, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
          ],
          slivers: [
            if (state.status == RevisionStatus.loading && !state.hasData)
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
            else if (state.revisionItems.isEmpty)
              const SliverFillRemaining(child: RevisionEmptyState())
            else ...[
              SliverToBoxAdapter(child: RevisionDueBanner(dueCount: state.dueCount)),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h8, Dimens.w20, Dimens.h20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        Padding(padding: EdgeInsets.only(bottom: Dimens.h12), child: RevisionCard(item: state.revisionItems[index])),
                    childCount: state.revisionItems.length,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
