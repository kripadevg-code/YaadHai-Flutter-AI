import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/core/router/app_router.dart';
import 'package:yaad_hai/modules/home/bloc/home_bloc.dart';
import 'package:yaad_hai/modules/home/components/home_bottom_nav_bar.dart';
import 'package:yaad_hai/modules/home/components/home_hero_sliver.dart';
import 'package:yaad_hai/modules/home/components/home_quick_actions_grid.dart';
import 'package:yaad_hai/modules/home/components/home_revision_banner.dart';
import 'package:yaad_hai/modules/home/components/home_section_header.dart';
import 'package:yaad_hai/modules/home/components/home_weak_concepts_section.dart';
import 'package:yaad_hai/modules/home/repos/home_repo.dart';
import 'package:yaad_hai/modules/mastery/bloc/mastery_bloc.dart';
import 'package:yaad_hai/modules/mastery/mastery_page.dart';
import 'package:yaad_hai/modules/mastery/repos/mastery_repo.dart';
import 'package:yaad_hai/modules/revision/bloc/revision_bloc.dart';
import 'package:yaad_hai/modules/revision/repos/revision_repo.dart';
import 'package:yaad_hai/modules/revision/revision_page.dart';
import 'package:yaad_hai/modules/scan_history/bloc/scan_history_bloc.dart';
import 'package:yaad_hai/modules/scan_history/repos/scan_history_repo.dart';
import 'package:yaad_hai/modules/subjects/bloc/subjects_bloc.dart';
import 'package:yaad_hai/modules/subjects/repos/subjects_repo.dart';
import 'package:yaad_hai/modules/subjects/subjects_page.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<HomeNavItem> _navItems = [
    HomeNavItem(icon: Icons.home_rounded, label: AppStrings.navHome, route: AppRoutes.home),
    HomeNavItem(icon: Icons.menu_book_rounded, label: AppStrings.navSubjects, route: AppRoutes.subjects),
    HomeNavItem(icon: Icons.replay_rounded, label: AppStrings.navRevision, route: AppRoutes.revision),
    HomeNavItem(icon: Icons.bar_chart_rounded, label: AppStrings.navMastery, route: AppRoutes.mastery),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc(repository: locator<HomeRepo>())..add(HomeEventLoad())),
        BlocProvider(create: (_) => MasteryBloc(repository: locator<MasteryRepo>())..add(MasteryEventLoad())),
        BlocProvider(create: (_) => RevisionBloc(repository: locator<RevisionRepo>())..add(RevisionEventWatch())),
        BlocProvider(create: (_) => ScanHistoryBloc(repository: locator<ScanHistoryRepo>())..add(ScanHistoryEventWatch())),
        BlocProvider(create: (_) => SubjectsBloc(repo: locator<SubjectsRepo>())..add(SubjectsEventWatch())),
      ],
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.conceptNavigationChapter != null) {
            AppNavigator.pushConcepts(context, state.conceptNavigationChapter!);
            context.read<HomeBloc>().add(HomeEventClearNavigation());
          }
        },
        child: _HomeScaffold(navItems: _navItems),
      ),
    );
  }
}

class _HomeScaffold extends StatefulWidget {
  const _HomeScaffold({required this.navItems});
  final List<HomeNavItem> navItems;

  @override
  State<_HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<_HomeScaffold> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging && _tabController.index != _currentIndex) {
      setState(() {
        _currentIndex = _tabController.index;
      });
    }
  }

  void _onWeakConceptTap(BuildContext context, Concept concept) {
    context.read<HomeBloc>().add(HomeEventOpenConcept(concept));
  }

  void _switchTab(int index) {
    if (index == _currentIndex) return;
    _tabController.animateTo(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.grey50,
      extendBody: false,
      body: TabBarView(
        controller: _tabController,
        children: [
          _HomeTab(onWeakConceptTap: _onWeakConceptTap, onTabSwitch: _switchTab),
          const SubjectsPage(),
          const RevisionPage(),
          const MasteryPage(),
        ],
      ),
      bottomNavigationBar: HomeBottomNavBar(
        selectedIndex: _currentIndex,
        items: widget.navItems,
        onScanTap: () => AppNavigator.pushScanner(context),
        onTap: _switchTab,
      ),
    );
  }
}

// ─── Home Tab View ───────────────────────────────────────────────────────────

class _HomeTab extends StatelessWidget {
  const _HomeTab({required this.onWeakConceptTap, required this.onTabSwitch});

  final Function(BuildContext, Concept) onWeakConceptTap;
  final ValueChanged<int> onTabSwitch;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        // ── Hero with gradient, profile, mastery chip, stats strip ───────
        const HomeHeroSliver(),

        // ── Spacing after stats strip overlap ─────────────────────────
        SliverToBoxAdapter(child: SizedBox(height: Dimens.h48)),

        // ── Revision focus banner ──────────────────────────────────────
        const SliverToBoxAdapter(child: HomeRevisionBanner()),
        SliverToBoxAdapter(child: SizedBox(height: Dimens.h28)),

        // ── Quick actions 2×2 grid ─────────────────────────────────────
        SliverToBoxAdapter(child: HomeQuickActionsGrid(onTabSwitch: onTabSwitch)),
        SliverToBoxAdapter(child: SizedBox(height: Dimens.h28)),

        // ── Recent Scans section ──────────────────────────────────────
        const SliverToBoxAdapter(child: _RecentScansSection()),
        SliverToBoxAdapter(child: SizedBox(height: Dimens.h28)),

        // ── Weak concepts ──────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Builder(builder: (ctx) => HomeWeakConceptsSection(onConceptTap: (concept) => onWeakConceptTap(ctx, concept))),
        ),

        // ── Nav bar clearance ──────────────────────────────────────────
        SliverToBoxAdapter(child: SizedBox(height: Dimens.h100)),
      ],
    );
  }
}

// ─── Recent Scans Section ─────────────────────────────────────────────────────

class _RecentScansSection extends StatelessWidget {
  const _RecentScansSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanHistoryBloc, ScanHistoryState>(
      builder: (context, state) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        // Always show the section — shows CTA when empty
        final recentEntries = state.entries.take(3).toList();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeSectionHeader(
                title: AppStrings.scanHistoryTitle,
                actionLabel: state.hasData ? AppStrings.seeAll : null,
                onActionTap: state.hasData ? () => AppNavigator.pushScanHistory(context) : null,
              ),
              SizedBox(height: Dimens.h14),
              if (state.isLoading)
                _RecentScansShimmer(isDark: isDark)
              else if (state.isEmpty || recentEntries.isEmpty)
                _RecentScansCta(isDark: isDark)
              else
                Column(
                  children:
                      recentEntries
                          .map(
                            (e) => Padding(padding: EdgeInsets.only(bottom: Dimens.h8), child: _RecentScanTile(entry: e, isDark: isDark)),
                          )
                          .toList(),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _RecentScanTile extends StatelessWidget {
  const _RecentScanTile({required this.entry, required this.isDark});

  final ScanHistoryEntry entry;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      onTap: () => AppNavigator.pushStudyPack(context, chapterId: entry.chapterId, chapterTitle: entry.title, subjectId: entry.subjectId),
      padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h12),
      child: Row(
        children: [
          // ── Gradient icon ──────────────────────────────────────────
          Container(
            width: Dimens.w40,
            height: Dimens.h40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.brandPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(Dimens.r10),
            ),
            child: Icon(Icons.document_scanner_rounded, color: AppColors.white, size: Dimens.icon20),
          ),
          SizedBox(width: Dimens.w12),

          // ── Title + meta ───────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  style: AppStyles.bodyMediumBold.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Dimens.h3),
                Row(
                  children: [
                    _MiniChip(label: '${entry.conceptCount}c', color: AppColors.primary),
                    SizedBox(width: Dimens.w6),
                    _MiniChip(label: '${entry.flashcardCount}f', color: AppColors.success),
                    SizedBox(width: Dimens.w6),
                    _MiniChip(label: '${entry.quizCount}q', color: AppColors.warning),
                    const Spacer(),
                    Text(
                      _relativeTime(entry.scannedAt),
                      style: AppStyles.caption.copyWith(color: isDark ? AppColors.grey600 : AppColors.grey400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: Dimens.w8),
          Icon(Icons.chevron_right_rounded, size: Dimens.icon20, color: isDark ? AppColors.grey600 : AppColors.grey300),
        ],
      ),
    );
  }

  String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(dt);
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w6, vertical: Dimens.h2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r6)),
      child: Text(label, style: AppStyles.labelSmall.copyWith(color: color, fontSize: 9)),
    );
  }
}

class _RecentScansCta extends StatelessWidget {
  const _RecentScansCta({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: EdgeInsets.all(Dimens.w20),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Dimens.w12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.brandPurple]),
              borderRadius: BorderRadius.circular(Dimens.r12),
            ),
            child: Icon(Icons.document_scanner_rounded, color: AppColors.white, size: Dimens.icon24),
          ),
          SizedBox(width: Dimens.w16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.homeScanTitle,
                  style: AppStyles.bodyMediumBold.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
                ),
                SizedBox(height: Dimens.h4),
                Text(
                  'Scan notes → get summaries, flashcards & quiz instantly.',
                  style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
                ),
              ],
            ),
          ),
          SizedBox(width: Dimens.w12),
          FilledButton(
            onPressed: () => AppNavigator.pushScanner(context),
            style: FilledButton.styleFrom(
              // Override global theme minimumSize (double.infinity wide) so
              // this button can live inside a Row without causing infinite-
              // width layout assertions.
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.symmetric(horizontal: Dimens.w14, vertical: Dimens.h10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r10)),
            ),
            child: Text(AppStrings.scanNow, style: AppStyles.labelMedium.copyWith(color: AppColors.white)),
          ),
        ],
      ),
    );
  }
}

class _RecentScansShimmer extends StatelessWidget {
  const _RecentScansShimmer({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        2,
        (_) => Padding(
          padding: EdgeInsets.only(bottom: Dimens.h8),
          child: Container(
            height: Dimens.h64,
            decoration: BoxDecoration(
              color: isDark ? AppColors.grey800 : AppColors.grey100,
              borderRadius: BorderRadius.circular(Dimens.r16),
            ),
          ),
        ),
      ),
    );
  }
}
