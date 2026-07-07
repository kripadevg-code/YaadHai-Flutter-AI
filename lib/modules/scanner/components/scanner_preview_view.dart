import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class ScannerPreviewView extends StatefulWidget {
  const ScannerPreviewView({
    super.key,
    required this.capturedPages,
    required this.selectedIndex,
    required this.onSelectIndex,
    required this.onRemovePage,
    required this.onKeepTaking,
    required this.onConfirm,
    required this.onClose,
    required this.titleController,
  });

  final List<File> capturedPages;
  final int selectedIndex;
  final ValueChanged<int> onSelectIndex;
  final ValueChanged<int> onRemovePage;
  final VoidCallback onKeepTaking;
  final ValueChanged<bool> onConfirm;
  final VoidCallback onClose;
  final TextEditingController titleController;

  @override
  State<ScannerPreviewView> createState() => _ScannerPreviewViewState();
}

class _ScannerPreviewViewState extends State<ScannerPreviewView> {
  late final PageController _pageController;
  bool _generateInHindi = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.selectedIndex);
  }

  @override
  void didUpdateWidget(ScannerPreviewView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex &&
        _pageController.hasClients &&
        _pageController.page?.round() != widget.selectedIndex) {
      _pageController.animateToPage(widget.selectedIndex, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.capturedPages.isEmpty) return const SizedBox.shrink();

    final int activeIndex = widget.selectedIndex.clamp(0, widget.capturedPages.length - 1);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final systemOverlayStyle = isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemOverlayStyle.copyWith(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              _TopBar(current: activeIndex + 1, total: widget.capturedPages.length, onClose: widget.onClose),
              SizedBox(height: Dimens.h10),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.r24),
                      border: Border.all(color: isDark ? AppColors.white.withValues(alpha: 0.1) : AppColors.grey200, width: 1.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22.0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ColoredBox(color: isDark ? AppColors.darkSurface : AppColors.grey50),
                          PageView.builder(
                            controller: _pageController,
                            itemCount: widget.capturedPages.length,
                            onPageChanged: widget.onSelectIndex,
                            itemBuilder: (context, index) {
                              return InteractiveViewer(
                                clipBehavior: Clip.none,
                                maxScale: 4.0,
                                minScale: 1.0,
                                child: Image.file(
                                  widget.capturedPages[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              );
                            },
                          ),
                          // Top gradient overlay
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            height: Dimens.h56,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    (isDark ? AppColors.darkSurface : AppColors.grey50).withValues(alpha: 0.55),
                                    AppColors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: Dimens.h12,
                            right: Dimens.w12,
                            child: _DeleteChip(onRemove: () => widget.onRemovePage(activeIndex)),
                          ),
                          Positioned(top: Dimens.h12, left: Dimens.w12, child: _PageIndexLabel(index: activeIndex)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimens.h16),
              _BottomControlPanel(
                pages: widget.capturedPages,
                activeIndex: activeIndex,
                onSelectIndex: (index) {
                  widget.onSelectIndex(index);
                  _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                },
                onKeepTaking: widget.onKeepTaking,
                onConfirm: () => widget.onConfirm(_generateInHindi),
                isHindi: _generateInHindi,
                onHindiToggle: (val) {
                  setState(() {
                    _generateInHindi = val;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Top Bar ───────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({required this.current, required this.total, required this.onClose});

  final int current;
  final int total;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w20, vertical: Dimens.h8),
      child: Row(
        children: [
          _CircleIconButton(icon: Icons.close_rounded, onTap: onClose),
          Expanded(
            child: Text(
              AppStrings.reviewPages,
              textAlign: TextAlign.center,
              style: AppStyles.heading4.copyWith(color: isDark ? AppColors.white : AppColors.grey900, fontWeight: FontWeight.w700),
            ),
          ),
          _PageCountChip(current: current, total: total),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isDark ? AppColors.white.withValues(alpha: 0.1) : AppColors.grey100,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(Dimens.w10),
          child: Icon(icon, size: Dimens.icon20, color: isDark ? AppColors.white : AppColors.grey700),
        ),
      ),
    );
  }
}

class _PageCountChip extends StatelessWidget {
  const _PageCountChip({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w12, vertical: Dimens.h6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: isDark ? 0.25 : 0.1),
        borderRadius: BorderRadius.circular(Dimens.r20),
        border: Border.all(color: AppColors.primary.withValues(alpha: isDark ? 0.4 : 0.2), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.photo_library_outlined, size: 14, color: isDark ? AppColors.primaryLight : AppColors.primary),
          const SizedBox(width: 6),
          Text(
            '$current / $total',
            style: AppStyles.labelMedium.copyWith(color: isDark ? AppColors.primaryLight : AppColors.primary, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// ─── Floating Card labels ────────────────────────────────────────────────────

class _PageIndexLabel extends StatelessWidget {
  const _PageIndexLabel({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.w12, vertical: Dimens.h6),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(Dimens.r20)),
      child: Text('Page ${index + 1}', style: AppStyles.labelSmall.copyWith(color: AppColors.white, fontWeight: FontWeight.bold)),
    );
  }
}

class _DeleteChip extends StatelessWidget {
  const _DeleteChip({required this.onRemove});

  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.error,
      borderRadius: BorderRadius.circular(Dimens.r20),
      child: InkWell(
        onTap: onRemove,
        borderRadius: BorderRadius.circular(Dimens.r20),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.w12, vertical: Dimens.h6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.delete_outline_rounded, color: AppColors.white, size: 16),
              const SizedBox(width: 4),
              Text(AppStrings.delete, style: AppStyles.labelSmall.copyWith(color: AppColors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Bottom Control Panel (Dynamic Theme adaptation) ─────────────────────────

class _BottomControlPanel extends StatelessWidget {
  const _BottomControlPanel({
    required this.pages,
    required this.activeIndex,
    required this.onSelectIndex,
    required this.onKeepTaking,
    required this.onConfirm,
    required this.isHindi,
    required this.onHindiToggle,
  });

  final List<File> pages;
  final int activeIndex;
  final ValueChanged<int> onSelectIndex;
  final VoidCallback onKeepTaking;
  final VoidCallback onConfirm;
  final bool isHindi;
  final ValueChanged<bool> onHindiToggle;

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.paddingOf(context).bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h16, Dimens.w20, Dimens.h16 + bottomPadding),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.r24)),
        boxShadow: isDark ? null : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -4))],
        border: Border.all(color: isDark ? AppColors.white.withValues(alpha: 0.08) : AppColors.grey200, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Thumbnail list inside the panel
          _ThumbnailStrip(pages: pages, activeIndex: activeIndex, onSelectIndex: onSelectIndex),
          SizedBox(height: Dimens.h16),

          // 2. Page Count Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.layers_rounded, size: 16, color: isDark ? AppColors.grey400 : AppColors.grey500),
              const SizedBox(width: 6),
              Text(
                '$pageCount ${pageCount == 1 ? AppStrings.capturedPage : AppStrings.capturedPagesLabel}',
                style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey300 : AppColors.grey600, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: Dimens.h16),

          // Hindi Toggle Row
          InkWell(
            onTap: () => onHindiToggle(!isHindi),
            borderRadius: BorderRadius.circular(Dimens.r8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: isHindi,
                    onChanged: (val) {
                      if (val != null) onHindiToggle(val);
                    },
                    activeColor: AppColors.primary,
                    checkColor: AppColors.white,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Generate study pack in Hindi (हिंदी)',
                    style: AppStyles.labelMedium.copyWith(
                      color: isDark ? AppColors.grey300 : AppColors.grey700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimens.h16),

          // 3. Action buttons
          Row(
            children: [
              Expanded(child: _AddPageButton(onTap: onKeepTaking)),
              SizedBox(width: Dimens.w12),
              Expanded(flex: 2, child: _CreatePackButton(onTap: onConfirm)),
            ],
          ),
        ],
      ),
    );
  }

  int get pageCount => pages.length;
}

class _ThumbnailStrip extends StatelessWidget {
  const _ThumbnailStrip({required this.pages, required this.activeIndex, required this.onSelectIndex});

  final List<File> pages;
  final int activeIndex;
  final ValueChanged<int> onSelectIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.h72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: pages.length,
        separatorBuilder: (context, index) => SizedBox(width: Dimens.w8),
        itemBuilder:
            (context, index) =>
                _ThumbnailItem(file: pages[index], index: index, isActive: index == activeIndex, onTap: () => onSelectIndex(index)),
      ),
    );
  }
}

class _ThumbnailItem extends StatelessWidget {
  const _ThumbnailItem({required this.file, required this.index, required this.isActive, required this.onTap});

  final File file;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppStyles.crossFadeDuration,
        width: Dimens.w52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.r12),
          border: Border.all(
            color: isActive ? AppColors.primary : (isDark ? AppColors.white.withValues(alpha: 0.2) : AppColors.grey300),
            width: isActive ? 2.5 : 1.2,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(Dimens.r10), child: Image.file(file, fit: BoxFit.cover)),
            if (isActive)
              Positioned(
                bottom: Dimens.h3,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: Dimens.w16,
                    height: Dimens.h3,
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(Dimens.r2)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AddPageButton extends StatelessWidget {
  const _AddPageButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: Dimens.h16),
        side: BorderSide(color: isDark ? AppColors.white.withValues(alpha: 0.2) : AppColors.primary.withValues(alpha: 0.3), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.r14)),
        foregroundColor: isDark ? AppColors.white : AppColors.primary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add_a_photo_outlined, size: 20, color: isDark ? AppColors.white : AppColors.primary),
          const SizedBox(height: 4),
          Text(
            AppStrings.addAnotherPage,
            style: AppStyles.labelSmall.copyWith(color: isDark ? AppColors.white : AppColors.primary, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CreatePackButton extends StatelessWidget {
  const _CreatePackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.brandPurple],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(Dimens.r14),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: Dimens.r12, offset: Offset(0, Dimens.h4))],
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(Dimens.r14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Dimens.r14),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.h16, horizontal: Dimens.w16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.auto_awesome_rounded, color: AppColors.white, size: 20),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    AppStrings.createStudyPack,
                    style: AppStyles.bodyMediumBold.copyWith(color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
