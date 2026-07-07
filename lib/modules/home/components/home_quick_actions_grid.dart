import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/modules/subjects/bloc/subjects_bloc.dart';
import 'package:yaad_hai/modules/subjects/repos/subjects_repo.dart';
import 'package:yaad_hai/shared/components/common_draggable_sheet.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class HomeQuickActionsGrid extends StatelessWidget {
  const HomeQuickActionsGrid({super.key, required this.onTabSwitch});

  final ValueChanged<int> onTabSwitch;

  static const List<HomeQuickActionData> _actions = [
    HomeQuickActionData(icon: Icons.add_rounded, label: 'Add Subject', color: AppColors.primary, route: HomeQuickActionRoute.addSubject),
    HomeQuickActionData(icon: Icons.quiz_rounded, label: 'Practice Quiz', color: AppColors.brandPurple, route: HomeQuickActionRoute.quiz),
    HomeQuickActionData(
      icon: Icons.amp_stories_rounded,
      label: 'Flashcards',
      color: AppColors.warning,
      route: HomeQuickActionRoute.flashcards,
    ),
  ];

  void _onActionTap(BuildContext context, HomeQuickActionRoute route) {
    switch (route) {
      case HomeQuickActionRoute.addSubject:
        _showAddSubjectSheet(context);
      case HomeQuickActionRoute.quiz:
        _showStudySelector(context, isQuiz: true);
      case HomeQuickActionRoute.flashcards:
        _showStudySelector(context, isQuiz: false);
    }
  }

  void _showAddSubjectSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) {
        return BlocProvider(
          create: (_) => SubjectsBloc(repo: locator<SubjectsRepo>())..add(SubjectsEventResetForm()),
          child: CommonDraggableSheet(
            title: AppStrings.addSubject,
            initialChildSize: 0.75,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (sheetContext, scrollController) {
              return BlocBuilder<SubjectsBloc, SubjectsState>(
                builder: (builderContext, state) {
                  final bloc = builderContext.read<SubjectsBloc>();
                  final theme = Theme.of(sheetContext);
                  final isDark = theme.brightness == Brightness.dark;
                  final accentColor = Color(int.parse('FF${state.selectedColor}', radix: 16));

                  return _AddSubjectContent(
                    scrollController: scrollController,
                    bloc: bloc,
                    state: state,
                    isDark: isDark,
                    accentColor: accentColor,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showStudySelector(BuildContext context, {required bool isQuiz}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder:
          (sheetContext) => CommonDraggableSheet(
            title: isQuiz ? 'Start Practice Quiz' : 'Study Flashcards',
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder:
                (context, scrollController) => _StudySelectorView(
                  scrollController: scrollController,
                  onChapterSelected: (Subject subject, Chapter chapter) {
                    Navigator.pop(sheetContext);
                    if (isQuiz) {
                      AppNavigator.pushQuiz(context, chapterId: chapter.id, subjectId: subject.id);
                    } else {
                      AppNavigator.pushFlashcards(context, chapter);
                    }
                  },
                ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.quickActions,
            style: AppStyles.heading4.copyWith(
              color: Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.grey900,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: Dimens.h16),
          Row(
            children: [
              Expanded(child: HomeQuickActionCard(action: _actions[0], onTap: () => _onActionTap(context, _actions[0].route))),
              SizedBox(width: Dimens.w10),
              Expanded(child: HomeQuickActionCard(action: _actions[1], onTap: () => _onActionTap(context, _actions[1].route))),
              SizedBox(width: Dimens.w10),
              Expanded(child: HomeQuickActionCard(action: _actions[2], onTap: () => _onActionTap(context, _actions[2].route))),
            ],
          ),
        ],
      ),
    );
  }
}

enum HomeQuickActionRoute { addSubject, quiz, flashcards }

class HomeQuickActionData {
  const HomeQuickActionData({required this.icon, required this.label, required this.color, required this.route});

  final IconData icon;
  final String label;
  final Color color;
  final HomeQuickActionRoute route;
}

class HomeQuickActionCard extends StatelessWidget {
  const HomeQuickActionCard({super.key, required this.action, required this.onTap});

  final HomeQuickActionData action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.r20),
        child: Ink(
          decoration: BoxDecoration(
            color: isDarkTheme ? action.color.withValues(alpha: 0.15) : action.color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(Dimens.r20),
            border: Border.all(color: action.color.withValues(alpha: 0.2), width: 1.5),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.h18, horizontal: Dimens.w8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(Dimens.w10),
                  decoration: BoxDecoration(
                    color: action.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: action.color.withValues(alpha: 0.25), blurRadius: Dimens.r10, offset: Offset(0, Dimens.h3)),
                    ],
                  ),
                  child: Icon(action.icon, color: AppColors.white, size: Dimens.icon24),
                ),
                SizedBox(height: Dimens.h10),
                Text(
                  action.label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.bodySmallBold.copyWith(color: isDarkTheme ? AppColors.white : AppColors.grey900, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Study Selector View (Reusable draggable content) ─────────────────────────

class _StudySelectorView extends StatefulWidget {
  const _StudySelectorView({required this.scrollController, required this.onChapterSelected});

  final ScrollController scrollController;
  final Function(Subject subject, Chapter chapter) onChapterSelected;

  @override
  State<_StudySelectorView> createState() => _StudySelectorViewState();
}

class _StudySelectorViewState extends State<_StudySelectorView> {
  Subject? _selectedSubject;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final database = locator<AppDatabase>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
      child: Column(
        children: [
          if (_selectedSubject != null) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => setState(() => _selectedSubject = null),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_rounded, size: Dimens.icon18, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text('Back to Subjects', style: AppStyles.bodyMediumBold.copyWith(color: AppColors.primary)),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          Expanded(
            child:
                _selectedSubject == null
                    ? StreamBuilder<List<Subject>>(
                      stream: database.watchSubjects(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final subjects = snapshot.data!;
                        if (subjects.isEmpty) {
                          return Center(
                            child: Text(
                              'Create a subject first to get started!',
                              style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey400),
                            ),
                          );
                        }
                        return ListView.separated(
                          controller: widget.scrollController,
                          itemCount: subjects.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final subject = subjects[index];
                            final color = Color(int.parse('FF${subject.colorHex}', radix: 16));
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
                                child: Icon(Icons.menu_book_rounded, color: color, size: 18),
                              ),
                              title: Text(
                                subject.name,
                                style: AppStyles.bodyMediumBold.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
                              ),
                              trailing: Icon(Icons.chevron_right_rounded, color: isDark ? AppColors.grey600 : AppColors.grey400),
                              onTap: () => setState(() => _selectedSubject = subject),
                            );
                          },
                        );
                      },
                    )
                    : StreamBuilder<List<Chapter>>(
                      stream: database.watchChaptersBySubject(_selectedSubject!.id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final chapters = snapshot.data!;
                        if (chapters.isEmpty) {
                          return Center(
                            child: Text(
                              'No study materials scanned yet in this subject.',
                              style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey400),
                            ),
                          );
                        }
                        return ListView.separated(
                          controller: widget.scrollController,
                          itemCount: chapters.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final chapter = chapters[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.12), shape: BoxShape.circle),
                                child: const Icon(Icons.layers_rounded, color: AppColors.primary, size: 18),
                              ),
                              title: Text(
                                chapter.title,
                                style: AppStyles.bodyMediumBold.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
                              ),
                              trailing: Icon(Icons.play_arrow_rounded, color: AppColors.primary, size: Dimens.icon22),
                              onTap: () => widget.onChapterSelected(_selectedSubject!, chapter),
                            );
                          },
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

// ─── Add Subject Content (for Home Quick Actions) ────────────────────────────

class _AddSubjectContent extends StatelessWidget {
  const _AddSubjectContent({
    required this.scrollController,
    required this.bloc,
    required this.state,
    required this.isDark,
    required this.accentColor,
  });

  final ScrollController scrollController;
  final SubjectsBloc bloc;
  final SubjectsState state;
  final bool isDark;
  final Color accentColor;

  static const _colors = ['6C5CE7', '4F46E5', '0EA5E9', '00B894', 'E17055', 'FDAD52', 'FD79A8', '636E72'];

  static const _iconItems = [
    ('menu_book', Icons.menu_book_rounded, 'Book'),
    ('science', Icons.science_rounded, 'Science'),
    ('calculate', Icons.calculate_rounded, 'Math'),
    ('history_edu', Icons.history_edu_rounded, 'History'),
    ('psychology', Icons.psychology_rounded, 'Psychology'),
    ('computer', Icons.computer_rounded, 'CS'),
    ('language', Icons.language_rounded, 'Language'),
    ('palette', Icons.palette_rounded, 'Art'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.fromLTRB(Dimens.w24, Dimens.h8, Dimens.w24, MediaQuery.of(context).viewInsets.bottom + Dimens.h24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumCard(
            padding: EdgeInsets.symmetric(horizontal: Dimens.w16, vertical: Dimens.h4),
            child: TextField(
              controller: bloc.nameController,
              style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
              decoration: InputDecoration(
                hintText: AppStrings.subjectNameHint,
                hintStyle: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey500 : AppColors.grey400),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              textCapitalization: TextCapitalization.words,
            ),
          ),
          SizedBox(height: Dimens.h24),
          Text(AppStrings.subjectColor, style: AppStyles.labelLarge.copyWith(color: isDark ? AppColors.grey300 : AppColors.grey700)),
          SizedBox(height: Dimens.h12),
          Wrap(
            spacing: Dimens.w10,
            runSpacing: Dimens.h10,
            children:
                _colors.map((hex) {
                  final color = Color(int.parse('FF$hex', radix: 16));
                  final isSelected = state.selectedColor == hex;
                  return GestureDetector(
                    onTap: () => bloc.add(SubjectsEventChangeColor(hex)),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: Dimens.w36,
                      height: Dimens.h36,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: isSelected ? Border.all(color: AppColors.white, width: Dimens.subjectColorBorderWidth) : null,
                        boxShadow: isSelected ? [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: Dimens.r8)] : null,
                      ),
                      child: isSelected ? Icon(Icons.check_rounded, color: AppColors.white, size: Dimens.subjectColorCheckIconSize) : null,
                    ),
                  );
                }).toList(),
          ),
          SizedBox(height: Dimens.h24),
          Text(AppStrings.subjectIcon, style: AppStyles.labelLarge.copyWith(color: isDark ? AppColors.grey300 : AppColors.grey700)),
          SizedBox(height: Dimens.h12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  _iconItems.map((ic) {
                    final isSelected = state.selectedIcon == ic.$1;
                    return GestureDetector(
                      onTap: () => bloc.add(SubjectsEventChangeIcon(ic.$1)),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.only(right: Dimens.w10),
                        padding: EdgeInsets.all(Dimens.w12),
                        decoration: BoxDecoration(
                          color: isSelected ? accentColor.withValues(alpha: 0.12) : (isDark ? AppColors.grey800 : AppColors.grey100),
                          borderRadius: BorderRadius.circular(Dimens.r12),
                          border: Border.all(color: isSelected ? accentColor : AppColors.transparent, width: Dimens.subjectIconBorderWidth),
                        ),
                        child: Icon(
                          ic.$2,
                          color: isSelected ? accentColor : (isDark ? AppColors.grey400 : AppColors.grey500),
                          size: Dimens.icon24,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
          SizedBox(height: Dimens.h32),
          GestureDetector(
            onTap: () {
              final name = bloc.nameController.text.trim();
              if (name.isEmpty) return;
              bloc.add(SubjectsEventAdd(name: name, colorHex: state.selectedColor, iconName: state.selectedIcon));
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              height: Dimens.h54,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [accentColor, accentColor.withValues(alpha: 0.8)]),
                borderRadius: BorderRadius.circular(Dimens.r16),
                boxShadow: [BoxShadow(color: accentColor.withValues(alpha: 0.4), blurRadius: Dimens.r16, offset: Offset(0, Dimens.h8))],
              ),
              child: Center(child: Text(AppStrings.addSubject, style: AppStyles.buttonMedium.copyWith(color: AppColors.white))),
            ),
          ),
        ],
      ),
    );
  }
}
