import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/di/dependencies.dart';
import 'package:yaad_hai/core/router/app_navigator.dart';
import 'package:yaad_hai/modules/subjects/bloc/subjects_bloc.dart';
import 'package:yaad_hai/modules/subjects/repos/subjects_repo.dart';
import 'package:yaad_hai/shared/components/app_scaffold.dart';
import 'package:yaad_hai/shared/components/common_draggable_sheet.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubjectsBloc(repo: locator<SubjectsRepo>())..add(SubjectsEventWatch()),
      child: const _SubjectsView(),
    );
  }
}

class _SubjectsView extends StatelessWidget {
  const _SubjectsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectsBloc, SubjectsState>(
      builder: (context, state) {
        final count = state.subjects.length;
        final subtitle = count > 0 ? '$count ${count == 1 ? AppStrings.subject : AppStrings.mySubjects.toLowerCase()}' : null;

        return AppScaffold(
          hideOnScroll: true,
          title: AppStrings.mySubjects,
          subtitle: subtitle,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Dimens.w16, top: Dimens.h8, bottom: Dimens.h8),
              child: GestureDetector(
                onTap: () => _showAddSheet(context),
                child: Container(
                  padding: EdgeInsets.all(Dimens.w10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
                    borderRadius: BorderRadius.circular(Dimens.r12),
                    boxShadow: [
                      BoxShadow(color: AppColors.primary.withValues(alpha: 0.35), blurRadius: Dimens.r8, offset: Offset(0, Dimens.h3)),
                    ],
                  ),
                  child: const Icon(Icons.add_rounded, color: AppColors.white, size: Dimens.subjectAddIconSize),
                ),
              ),
            ),
          ],
          slivers: [
            if (state.status == SubjectsStatus.loading && !state.hasData)
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
            else if (!state.hasData)
              SliverFillRemaining(child: _EmptySubjectsView(onAdd: () => _showAddSheet(context)))
            else
              SliverPadding(
                padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h8, Dimens.w20, Dimens.h20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        Padding(padding: EdgeInsets.only(bottom: Dimens.h12), child: _SubjectCard(subject: state.subjects[index])),
                    childCount: state.subjects.length,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showAddSheet(BuildContext context) {
    context.read<SubjectsBloc>().add(SubjectsEventResetForm());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<SubjectsBloc>(),
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

                  return AddSubjectSheetContent(
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
}

class _SubjectCard extends StatelessWidget {
  const _SubjectCard({required this.subject});
  final Subject subject;

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

  Color get _color {
    try {
      return Color(int.parse('FF${subject.colorHex}', radix: 16));
    } catch (_) {
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = _color;
    final icon = _icons[subject.iconName] ?? Icons.menu_book_rounded;

    return GestureDetector(
      onTap: () => AppNavigator.pushChapters(context, subject),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.white,
          borderRadius: BorderRadius.circular(Dimens.r16),
          border: Border(left: BorderSide(color: color, width: Dimens.subjectBorderLeftWidth)),
          boxShadow: isDark ? null : AppStyles.cardShadow,
        ),
        padding: EdgeInsets.all(Dimens.w16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Dimens.w12),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(Dimens.r12)),
              child: Icon(icon, color: color, size: Dimens.icon24),
            ),
            SizedBox(width: Dimens.w16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.name,
                    style: AppStyles.heading4.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: Dimens.h4),
                  Row(
                    children: [
                      Icon(Icons.layers_rounded, size: Dimens.icon16, color: isDark ? AppColors.grey500 : AppColors.grey400),
                      SizedBox(width: Dimens.w4),
                      Text(
                        '${subject.totalChapters} ${AppStrings.chapters.toLowerCase()}',
                        style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimens.w8, vertical: Dimens.h4),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(Dimens.r8)),
              child: Icon(Icons.chevron_right_rounded, color: color, size: Dimens.icon20),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptySubjectsView extends StatelessWidget {
  const _EmptySubjectsView({required this.onAdd});
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
              width: Dimens.w120,
              height: Dimens.h120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(Dimens.r32),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withValues(alpha: 0.35), blurRadius: Dimens.r24, offset: Offset(0, Dimens.h12)),
                ],
              ),
              child: Icon(Icons.menu_book_rounded, size: Dimens.icon48, color: AppColors.white),
            ),
            SizedBox(height: Dimens.h32),
            Text(
              AppStrings.noSubjects,
              style: AppStyles.heading2.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Dimens.h8),
            Text(
              AppStrings.noSubjectsBody,
              textAlign: TextAlign.center,
              style: AppStyles.bodyMedium.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
            ),
            SizedBox(height: Dimens.h36),
            GestureDetector(
              onTap: onAdd,
              child: Container(
                width: double.infinity,
                height: Dimens.h54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
                  borderRadius: BorderRadius.circular(Dimens.r16),
                  boxShadow: [
                    BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: Dimens.r16, offset: Offset(0, Dimens.h8)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_rounded, color: AppColors.white, size: Dimens.subjectAddIconSize),
                    SizedBox(width: Dimens.w8),
                    Text(AppStrings.addSubject, style: AppStyles.buttonMedium.copyWith(color: AppColors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Add Subject Sheet Content ───────────────────────────────────────────────

class AddSubjectSheetContent extends StatelessWidget {
  const AddSubjectSheetContent({
    super.key,
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
