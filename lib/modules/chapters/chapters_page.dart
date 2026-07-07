import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/modules/chapters/bloc/chapters_bloc.dart';
import 'package:yaad_hai/modules/chapters/repos/chapters_repo.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ChaptersPage extends StatelessWidget {
  const ChaptersPage({super.key, required this.subject});
  final Subject subject;

  Color get _subjectColor {
    try {
      return Color(int.parse('FF${subject.colorHex}', radix: 16));
    } catch (_) {
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChaptersBloc(repo: locator<ChaptersRepo>())..add(ChaptersEventWatch(subject.id)),
      child: _ChaptersView(subject: subject, subjectColor: _subjectColor),
    );
  }
}

class _ChaptersView extends StatelessWidget {
  const _ChaptersView({required this.subject, required this.subjectColor});
  final Subject subject;
  final Color subjectColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChaptersBloc, ChaptersState>(
      builder: (context, state) {
        return AppScaffold(
          hideOnScroll: true,
          topHeader: _ChaptersHeader(
            subject: subject,
            subjectColor: subjectColor,
            chapterCount: state.chapters.length,
            onAdd: () => _showAddSheet(context),
          ),
          slivers: [
            if (state.status == ChaptersStatus.loading && !state.hasData)
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
            else if (!state.hasData)
              SliverFillRemaining(child: _EmptyChaptersView(onAdd: () => _showAddSheet(context)))
            else
              SliverPadding(
                padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h8, Dimens.w20, Dimens.h20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: Dimens.h12),
                      child: _ChapterCard(chapter: state.chapters[index], subjectColor: subjectColor, index: index + 1),
                    ),
                    childCount: state.chapters.length,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showAddSheet(BuildContext context) {
    context.read<ChaptersBloc>().add(ChaptersEventResetForm());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => BlocProvider.value(value: context.read<ChaptersBloc>(), child: _AddChapterSheet(subjectId: subject.id)),
    );
  }
}

class _ChaptersHeader extends StatelessWidget {
  const _ChaptersHeader({required this.subject, required this.subjectColor, required this.chapterCount, required this.onAdd});
  final Subject subject;
  final Color subjectColor;
  final int chapterCount;
  final VoidCallback onAdd;

  static const _icons = <String, IconData>{
    'menu_book': Icons.menu_book_rounded,
    'science': Icons.science_rounded,
    'calculate': Icons.calculate_rounded,
    'history_edu': Icons.history_edu_rounded,
    'psychology': Icons.psychology_rounded,
    'computer': Icons.computer_rounded,
    'language': Icons.language_rounded,
    'palette': Icons.palette_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final icon = _icons[subject.iconName] ?? Icons.menu_book_rounded;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark ? [AppColors.darkSurface, AppColors.darkBackground] : [subjectColor, subjectColor.withValues(alpha: 0.75)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(Dimens.w8),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(Dimens.r10),
                      ),
                      child: const Icon(Icons.arrow_back_rounded, color: AppColors.white, size: 20),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      padding: EdgeInsets.all(Dimens.w8),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(Dimens.r10),
                      ),
                      child: const Icon(Icons.add_rounded, color: AppColors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h8, Dimens.w20, Dimens.h24),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimens.w12),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(Dimens.r14),
                    ),
                    child: Icon(icon, color: AppColors.white, size: Dimens.icon24),
                  ),
                  SizedBox(width: Dimens.w16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subject.name, style: AppStyles.heading2.copyWith(color: AppColors.white, fontWeight: FontWeight.w700)),
                        SizedBox(height: Dimens.h4),
                        Text(
                          '$chapterCount ${AppStrings.chapters.toLowerCase()}',
                          style: AppStyles.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.75)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChapterCard extends StatelessWidget {
  const _ChapterCard({required this.chapter, required this.subjectColor, required this.index});
  final Chapter chapter;
  final Color subjectColor;
  final int index;

  static const _masteryLabels = ['—', 'Learning', 'Familiar', 'Good', 'Mastered', 'Expert'];
  static const _masteryColors = [
    AppColors.grey300,
    AppColors.error,
    AppColors.warning,
    AppColors.info,
    AppColors.success,
    AppColors.primary,
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final level = chapter.masteryLevel.clamp(0, 5);
    final masteryColor = _masteryColors[level];
    final masteryLabel = _masteryLabels[level];
    final progress = level / 5.0;

    return PremiumCard(
      onTap: () {
        if (chapter.description != null && chapter.description!.isNotEmpty) {
          AppNavigator.pushStudyPack(context, chapterId: chapter.id, chapterTitle: chapter.title, subjectId: chapter.subjectId);
        } else {
          AppNavigator.pushConcepts(context, chapter);
        }
      },
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimens.w16),
            child: Row(
              children: [
                Container(
                  width: Dimens.w40,
                  height: Dimens.h40,
                  decoration: BoxDecoration(color: subjectColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r10)),
                  child: Center(child: Text('$index', style: AppStyles.bodyMediumBold.copyWith(color: subjectColor))),
                ),
                SizedBox(width: Dimens.w14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chapter.title,
                        style: AppStyles.heading4.copyWith(
                          color: isDark ? AppColors.white : AppColors.grey900,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (chapter.description != null && chapter.description!.isNotEmpty) ...[
                        SizedBox(height: Dimens.h4),
                        Text(
                          chapter.description!,
                          style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: Dimens.w12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.w8, vertical: Dimens.h4),
                  decoration: BoxDecoration(color: masteryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r8)),
                  child: Text(masteryLabel, style: AppStyles.labelSmall.copyWith(color: masteryColor, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(Dimens.w16, 0, Dimens.w16, Dimens.h12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.r4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: Dimens.h6,
                    backgroundColor: isDark ? AppColors.grey800 : AppColors.grey100,
                    valueColor: AlwaysStoppedAnimation<Color>(masteryColor),
                  ),
                ),
                SizedBox(height: Dimens.h10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => AppNavigator.pushConcepts(context, chapter),
                      child: _ActionChip(icon: Icons.lightbulb_rounded, label: AppStrings.concepts, color: AppColors.primary),
                    ),
                    SizedBox(width: Dimens.w8),
                    GestureDetector(
                      onTap: () => AppNavigator.pushFlashcards(context, chapter),
                      child: _ActionChip(icon: Icons.style_rounded, label: AppStrings.flashcards, color: AppColors.accent),
                    ),
                    SizedBox(width: Dimens.w8),
                    GestureDetector(
                      onTap: () => AppNavigator.pushQuiz(context, chapterId: chapter.id, subjectId: chapter.subjectId),
                      child: _ActionChip(icon: Icons.quiz_rounded, label: AppStrings.quiz, color: AppColors.warning),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({required this.icon, required this.label, required this.color});

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w10, vertical: Dimens.h6),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: Dimens.icon16, color: color),
          SizedBox(width: Dimens.w4),
          Text(label, style: AppStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _EmptyChaptersView extends StatelessWidget {
  const _EmptyChaptersView({required this.onAdd});
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(Dimens.w32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(Dimens.w24),
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.layers_rounded, size: Dimens.icon48, color: AppColors.primary),
            ),
            SizedBox(height: Dimens.h24),
            Text(
              AppStrings.noChapters,
              style: AppStyles.heading2.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Dimens.h8),
            Text(
              AppStrings.noChaptersBody,
              textAlign: TextAlign.center,
              style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
            ),
            SizedBox(height: Dimens.h32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add_rounded, color: AppColors.white),
                label: Text(AppStrings.addChapter, style: AppStyles.labelLarge.copyWith(color: AppColors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: Dimens.h16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddChapterSheet extends StatelessWidget {
  const _AddChapterSheet({required this.subjectId});
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bloc = context.read<ChaptersBloc>();

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
            AppStrings.addChapter,
            style: AppStyles.heading3.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: Dimens.h24),
          PremiumCard(
            padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h4),
            child: TextField(
              controller: bloc.titleController,
              style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
              decoration: InputDecoration(
                hintText: AppStrings.chapterTitleHint,
                hintStyle: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey400),
                prefixIcon: const Icon(Icons.layers_rounded, color: AppColors.primary),
                border: InputBorder.none,
              ),
              textCapitalization: TextCapitalization.words,
            ),
          ),
          SizedBox(height: Dimens.h16),
          PremiumCard(
            padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h4),
            child: TextField(
              controller: bloc.descController,
              style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
              decoration: InputDecoration(
                hintText: AppStrings.chapterDescription,
                hintStyle: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey400),
                prefixIcon: const Icon(Icons.short_text_rounded, color: AppColors.grey400),
                border: InputBorder.none,
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          SizedBox(height: Dimens.h32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final title = bloc.titleController.text.trim();
                if (title.isEmpty) return;
                bloc.add(
                  ChaptersEventAdd(
                    subjectId: subjectId,
                    title: title,
                    description: bloc.descController.text.trim().isEmpty ? null : bloc.descController.text.trim(),
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: Dimens.h16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r16)),
              ),
              child: Text(AppStrings.addChapter, style: AppStyles.labelLarge.copyWith(color: AppColors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
