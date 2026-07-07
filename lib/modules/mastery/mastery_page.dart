import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/modules/mastery/bloc/mastery_bloc.dart';
import 'package:yaad_hai/modules/mastery/models/subject_with_progress.dart';
import 'package:yaad_hai/modules/mastery/repos/mastery_repo.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class MasteryPage extends StatelessWidget {
  const MasteryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MasteryBloc(repository: locator<MasteryRepo>())..add(MasteryEventLoad()),
      child: const _MasteryView(),
    );
  }
}

class _MasteryView extends StatelessWidget {
  const _MasteryView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasteryBloc, MasteryState>(
      builder: (context, state) {
        final count = state.subjects.length;
        final subtitle = count > 0 ? '$count ${count == 1 ? AppStrings.subject : AppStrings.mySubjects.toLowerCase()}' : null;

        return AppScaffold(
          hideOnScroll: true,
          title: AppStrings.masteryDashboard,
          subtitle: subtitle,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Dimens.w16, top: Dimens.h8, bottom: Dimens.h8),
              child: GestureDetector(
                onTap: () => context.read<MasteryBloc>().add(MasteryEventLoad()),
                child: Container(
                  padding: EdgeInsets.all(Dimens.w8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Dimens.r10),
                  ),
                  child: Icon(Icons.refresh_rounded, color: AppColors.primary, size: Dimens.icon20),
                ),
              ),
            ),
          ],
          slivers: [
            if (state.status == MasteryStatus.loading)
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
            else ...[
              SliverPadding(
                padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h16, Dimens.w20, 0),
                sliver: SliverToBoxAdapter(child: _MasteryRingCard(state: state)),
              ),
              SliverToBoxAdapter(child: _StatsStrip(state: state)),
              if (state.weakConcepts.isNotEmpty) ...[
                const SliverToBoxAdapter(child: _SectionLabel(text: AppStrings.weakConceptsFocus)),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: Dimens.h10),
                        child: _WeakConceptTile(concept: state.weakConcepts[index]),
                      ),
                      childCount: state.weakConcepts.length,
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: Dimens.h16)),
              ],
              const SliverToBoxAdapter(child: _SectionLabel(text: AppStrings.subjectWiseMastery)),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(Dimens.w20, 0, Dimens.w20, Dimens.h80),
                sliver:
                    state.subjects.isEmpty
                        ? SliverToBoxAdapter(child: const _EmptySubjectsHint())
                        : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => Padding(
                              padding: EdgeInsets.only(bottom: Dimens.h10),
                              child: _SubjectProgressTile(subjectWithProgress: state.subjects[index]),
                            ),
                            childCount: state.subjects.length,
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

// ─── Mastery Hero Progress Card (Redesigned) ─────────────────────────────────

class _MasteryRingCard extends StatelessWidget {
  const _MasteryRingCard({required this.state});
  final MasteryState state;

  @override
  Widget build(BuildContext context) {
    final percent = (state.masteryPercent * 100).round();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.brandPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(Dimens.r24),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.35), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      padding: EdgeInsets.all(Dimens.w20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimens.masteryBadgePaddingHorizontal,
                    vertical: Dimens.masteryBadgePaddingVertical,
                  ),
                  decoration: BoxDecoration(color: AppColors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(Dimens.r20)),
                  child: Text(
                    AppStrings.overallProgress.toUpperCase(),
                    style: AppStyles.labelSmall.copyWith(color: AppColors.white, letterSpacing: 1.0, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: Dimens.h14),
                Text('$percent%', style: AppStyles.display1.copyWith(color: AppColors.white, fontWeight: FontWeight.w900)),
                SizedBox(height: Dimens.h8),
                Text(
                  '${state.masteredConcepts} ${AppStrings.masteryOfText} ${state.totalConcepts} ${AppStrings.masteryConceptsMasteredMessage}',
                  style: AppStyles.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.85), height: 1.45),
                ),
              ],
            ),
          ),
          SizedBox(width: Dimens.w16),
          _MasteryCircularProgress(percent: state.masteryPercent),
        ],
      ),
    );
  }
}

class _MasteryCircularProgress extends StatelessWidget {
  const _MasteryCircularProgress({required this.percent});
  final double percent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.masteryCircularProgressSize,
      height: Dimens.masteryCircularProgressSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Track
          SizedBox(
            width: Dimens.masteryCircularProgressSize,
            height: Dimens.masteryCircularProgressSize,
            child: CircularProgressIndicator(
              value: 1.0,
              backgroundColor: AppColors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white.withValues(alpha: 0.15)),
              strokeWidth: Dimens.masteryCircularProgressStroke,
            ),
          ),
          // Progress
          SizedBox(
            width: Dimens.masteryCircularProgressSize,
            height: Dimens.masteryCircularProgressSize,
            child: CircularProgressIndicator(
              value: percent,
              backgroundColor: AppColors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.white),
              strokeWidth: Dimens.masteryCircularProgressStroke,
              strokeCap: StrokeCap.round,
            ),
          ),
          // Inner Icon
          Container(
            width: Dimens.masteryInnerCircleSize,
            height: Dimens.masteryInnerCircleSize,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.25),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8)],
            ),
            child: Icon(Icons.stars_rounded, color: AppColors.white, size: Dimens.masteryInnerIconSize),
          ),
        ],
      ),
    );
  }
}

// ─── Stats Dashboard Row (Redesigned) ────────────────────────────────────────

class _StatsStrip extends StatelessWidget {
  const _StatsStrip({required this.state});
  final MasteryState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h20, Dimens.w20, Dimens.h16),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              icon: Icons.local_fire_department_rounded,
              color: AppColors.warning,
              value: '${state.currentStreak}',
              label: AppStrings.streak,
            ),
          ),
          SizedBox(width: Dimens.w10),
          Expanded(
            child: _StatCard(
              icon: Icons.psychology_rounded,
              color: AppColors.primary,
              value: '${state.totalConcepts}',
              label: AppStrings.concepts,
            ),
          ),
          SizedBox(width: Dimens.w10),
          Expanded(
            child: _StatCard(
              icon: Icons.warning_amber_rounded,
              color: AppColors.error,
              value: '${state.weakConcepts.length}',
              label: AppStrings.weakAreas,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.color, required this.value, required this.label});
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkCard : AppColors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(Dimens.r20),
        border: Border.all(color: color.withValues(alpha: 0.15), width: Dimens.masteryStatBorderWidth),
        boxShadow: isDark ? null : AppStyles.cardShadow,
      ),
      padding: EdgeInsets.symmetric(vertical: Dimens.h16, horizontal: Dimens.w10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Dimens.w8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: Dimens.icon22),
          ),
          SizedBox(height: Dimens.h10),
          Text(value, style: AppStyles.heading3.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w800)),
          SizedBox(height: Dimens.h4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppStyles.caption.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey600, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// ─── Section Labels & Sub-items ──────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h14, Dimens.w20, Dimens.h14),
      child: Row(
        children: [
          Container(
            width: Dimens.w4,
            height: Dimens.h20,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.brandPurple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(Dimens.r2),
            ),
          ),
          SizedBox(width: Dimens.w10),
          Text(text, style: AppStyles.heading4.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _WeakConceptTile extends StatelessWidget {
  const _WeakConceptTile({required this.concept});
  final Concept concept;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkCard : AppColors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(Dimens.r16),
        border: Border.all(color: AppColors.masteryLow.withValues(alpha: 0.15), width: Dimens.masteryWeakConceptBorderWidth),
        boxShadow: isDark ? null : AppStyles.cardShadow,
      ),
      padding: EdgeInsets.all(Dimens.w16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Dimens.w10),
            decoration: BoxDecoration(color: AppColors.masteryLow.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r12)),
            child: Icon(Icons.psychology_rounded, color: AppColors.masteryLow, size: Dimens.icon22),
          ),
          SizedBox(width: Dimens.w14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  concept.title,
                  style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Dimens.h4),
                Text(
                  concept.summary,
                  style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: Dimens.w10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.w10, vertical: Dimens.h4),
            decoration: BoxDecoration(
              color: AppColors.masteryLow.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Dimens.r8),
              border: Border.all(color: AppColors.masteryLow.withValues(alpha: 0.3)),
            ),
            child: Text(
              '${AppStrings.masteryLevelPrefix} ${concept.masteryLevel}',
              style: AppStyles.labelSmall.copyWith(color: AppColors.masteryLow, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Subject Progress Tiles (Redesigned) ─────────────────────────────────────

class _SubjectProgressTile extends StatelessWidget {
  const _SubjectProgressTile({required this.subjectWithProgress});
  final SubjectWithProgress subjectWithProgress;

  Color get _subjectColor {
    try {
      return Color(int.parse('FF${subjectWithProgress.subject.colorHex}', radix: 16));
    } catch (_) {
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = _subjectColor;
    final mastery = subjectWithProgress.masteryPercent;
    final subject = subjectWithProgress.subject;
    final cardBg = isDark ? AppColors.darkCard : AppColors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(Dimens.r16),
        boxShadow: isDark ? null : AppStyles.cardShadow,
        border: Border.all(color: isDark ? AppColors.grey800 : AppColors.grey100, width: 1.0),
      ),
      padding: EdgeInsets.all(Dimens.w16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Dimens.w10),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(Icons.menu_book_rounded, color: color, size: Dimens.icon22),
          ),
          SizedBox(width: Dimens.w14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subject.name,
                      style: AppStyles.bodyMedium.copyWith(
                        color: isDark ? AppColors.white : AppColors.grey900,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimens.masteryProgressBadgePaddingH,
                        vertical: Dimens.masteryProgressBadgePaddingV,
                      ),
                      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(Dimens.r12)),
                      child: Text(
                        '${(mastery * 100).round()}%',
                        style: AppStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimens.h10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.r8),
                  child: LinearProgressIndicator(
                    value: mastery,
                    minHeight: Dimens.h8,
                    backgroundColor: isDark ? AppColors.grey800 : AppColors.grey100,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                SizedBox(height: Dimens.h8),
                Text(
                  '${subject.totalChapters} ${AppStrings.chapters.toLowerCase()} ${AppStrings.masteryChaptersLogged}',
                  style: AppStyles.caption.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptySubjectsHint extends StatelessWidget {
  const _EmptySubjectsHint();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimens.h32),
        child: Text(
          AppStrings.masteryEmptySubjectsMessage,
          style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey400),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
