import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/modules/scan_history/bloc/scan_history_bloc.dart';
import 'package:yaad_hai/modules/scan_history/repos/scan_history_repo.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ScanHistoryPage extends StatelessWidget {
  const ScanHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScanHistoryBloc(repository: locator<ScanHistoryRepo>())..add(ScanHistoryEventWatch()),
      child: const _ScanHistoryView(),
    );
  }
}

class _ScanHistoryView extends StatelessWidget {
  const _ScanHistoryView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanHistoryBloc, ScanHistoryState>(
      builder: (context, state) {
        final count = state.entries.length;
        final subtitle = count > 0 ? '$count ${AppStrings.scanHistoryCount}' : null;

        return AppScaffold(
          hideOnScroll: true,
          title: AppStrings.scanHistoryTitle,
          subtitle: subtitle,
          floatingActionButton: const _ScanFab(),
          slivers: [
            if (state.isLoading)
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
            else if (state.isEmpty)
              const SliverFillRemaining(child: _EmptyState())
            else if (state.status == ScanHistoryStatus.error)
              SliverFillRemaining(child: _ErrorState(message: state.errorMessage))
            else
              _ScanHistoryList(entries: state.entries),
          ],
        );
      },
    );
  }
}

// ─── Grouped List ─────────────────────────────────────────────────────────────

class _ScanHistoryList extends StatelessWidget {
  const _ScanHistoryList({required this.entries});

  final List<ScanHistoryEntry> entries;

  @override
  Widget build(BuildContext context) {
    final Map<String, List<ScanHistoryEntry>> grouped = {};
    for (final entry in entries) {
      grouped.putIfAbsent(_dateKey(entry.scannedAt), () => []).add(entry);
    }
    final keys = grouped.keys.toList();

    return SliverList.builder(
      itemCount: keys.length,
      itemBuilder: (context, index) => _DateGroup(dateLabel: keys[index], entries: grouped[keys[index]]!),
    );
  }

  String _dateKey(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final date = DateTime(dt.year, dt.month, dt.day);
    if (date == today) return AppStrings.today;
    if (date == yesterday) return AppStrings.yesterday;
    return DateFormat('MMMM d, yyyy').format(dt);
  }
}

class _DateGroup extends StatelessWidget {
  const _DateGroup({required this.dateLabel, required this.entries});

  final String dateLabel;
  final List<ScanHistoryEntry> entries;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h20, Dimens.w20, Dimens.h8),
          child: Text(
            dateLabel,
            style: AppStyles.overline.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey400, letterSpacing: 1.2),
          ),
        ),
        ...entries.map(
          (entry) =>
              Padding(padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h4), child: _ScanHistoryCard(entry: entry)),
        ),
      ],
    );
  }
}

// ─── Card ─────────────────────────────────────────────────────────────────────

class _ScanHistoryCard extends StatelessWidget {
  const _ScanHistoryCard({required this.entry});

  final ScanHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dismissible(
      key: ValueKey(entry.id),
      direction: DismissDirection.endToStart,
      background: const _DeleteBackground(),
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => context.read<ScanHistoryBloc>().add(ScanHistoryEventDelete(entry.id)),
      child: PremiumCard(
        onTap: () => AppNavigator.pushStudyPack(context, chapterId: entry.chapterId, chapterTitle: entry.title, subjectId: entry.subjectId),
        padding: EdgeInsets.all(Dimens.w16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ScanIconBadge(),
            SizedBox(width: Dimens.w14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.title,
                          style: AppStyles.labelLarge.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: Dimens.w8),
                      Text(
                        DateFormat('h:mm a').format(entry.scannedAt),
                        style: AppStyles.caption.copyWith(color: isDark ? AppColors.grey600 : AppColors.grey400),
                      ),
                    ],
                  ),
                  if (entry.summarySnippet.isNotEmpty) ...[
                    SizedBox(height: Dimens.h4),
                    Text(
                      entry.summarySnippet,
                      style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: Dimens.h10),
                  _StatsRow(entry: entry, isDark: isDark),
                ],
              ),
            ),
            SizedBox(width: Dimens.w8),
            Icon(Icons.arrow_forward_ios_rounded, size: Dimens.icon16, color: isDark ? AppColors.grey600 : AppColors.grey300),
          ],
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Remove scan?'),
            content: const Text('This removes it from your history. The study pack stays in your library.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: FilledButton.styleFrom(backgroundColor: AppColors.error),
                child: const Text('Remove'),
              ),
            ],
          ),
    );
  }
}

class _ScanIconBadge extends StatelessWidget {
  const _ScanIconBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimens.w44,
      height: Dimens.h48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.brandPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(Dimens.r12),
      ),
      child: Icon(Icons.document_scanner_rounded, color: AppColors.white, size: Dimens.icon22),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.entry, required this.isDark});

  final ScanHistoryEntry entry;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Dimens.w6,
      runSpacing: Dimens.h4,
      children: [
        if (entry.pageCount > 0)
          _StatChip(icon: Icons.photo_library_outlined, label: '${entry.pageCount}p', color: AppColors.accent, isDark: isDark),
        if (entry.conceptCount > 0)
          _StatChip(
            icon: Icons.lightbulb_outline_rounded,
            label: '${entry.conceptCount} concepts',
            color: AppColors.primary,
            isDark: isDark,
          ),
        if (entry.flashcardCount > 0)
          _StatChip(icon: Icons.style_outlined, label: '${entry.flashcardCount} cards', color: AppColors.success, isDark: isDark),
        if (entry.quizCount > 0)
          _StatChip(icon: Icons.quiz_outlined, label: '${entry.quizCount} quiz', color: AppColors.warning, isDark: isDark),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label, required this.color, required this.isDark});

  final IconData icon;
  final String label;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w8, vertical: Dimens.h3),
      decoration: BoxDecoration(color: color.withValues(alpha: isDark ? 0.15 : 0.08), borderRadius: BorderRadius.circular(Dimens.r20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: Dimens.icon10, color: color),
          SizedBox(width: Dimens.w4),
          Text(label, style: AppStyles.labelSmall.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimens.h4),
      decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(Dimens.r16)),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: Dimens.w20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.delete_outline_rounded, color: AppColors.error, size: Dimens.icon24),
          SizedBox(height: Dimens.h2),
          Text(AppStrings.delete, style: AppStyles.labelSmall.copyWith(color: AppColors.error)),
        ],
      ),
    );
  }
}

// ─── FAB ──────────────────────────────────────────────────────────────────────

class _ScanFab extends StatelessWidget {
  const _ScanFab();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => AppNavigator.pushScanner(context),
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      icon: const Icon(Icons.document_scanner_rounded),
      label: Text(AppStrings.newScan, style: AppStyles.buttonMedium.copyWith(color: AppColors.white)),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.all(Dimens.w32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Dimens.w88,
            height: Dimens.h88,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary.withValues(alpha: 0.15), AppColors.brandPurple.withValues(alpha: 0.15)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.document_scanner_rounded, size: Dimens.icon44, color: AppColors.primary),
          ),
          SizedBox(height: Dimens.h24),
          Text(
            AppStrings.scanHistoryEmptyTitle,
            style: AppStyles.heading3.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Dimens.h8),
          Text(
            AppStrings.scanHistoryEmptyBody,
            style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Dimens.h32),
          FilledButton.icon(
            onPressed: () => AppNavigator.pushScanner(context),
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: Dimens.w24, vertical: Dimens.h14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r14)),
            ),
            icon: const Icon(Icons.document_scanner_rounded),
            label: const Text(AppStrings.scanNow),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimens.w32),
        child: Text(
          message ?? AppStrings.somethingWentWrong,
          style: AppStyles.bodyMedium.copyWith(color: AppColors.error),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
