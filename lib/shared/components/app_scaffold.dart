import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

/// Reusable production-quality scrollable scaffold featuring a native collapsing
/// sliver app bar, theme adaptation, dynamic back navigation, and full custom
/// slivers content layout or nested scroll body coordination.
///
/// Fully backwards-compatible with legacy [topHeader] and [hideOnScroll] parameters.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.slivers = const [],
    this.body,
    this.title,
    this.subtitle,
    this.actions,
    this.expandedHeaderHeight,
    this.topHeader,
    this.hideOnScroll = false,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.safeAreaTop = true,
    this.safeAreaBottom = false,
  });

  final List<Widget> slivers;
  final Widget? body;
  final String? title;
  final String? subtitle;
  final List<Widget>? actions;
  final double? expandedHeaderHeight;
  final Widget? topHeader;
  final bool hideOnScroll;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool safeAreaTop;
  final bool safeAreaBottom;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canPop = Navigator.of(context).canPop();

    Widget mainContent;

    if (body != null) {
      mainContent = NestedScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // ── Sliver App Bar ───────────────────────────────────────────────
            if (title != null)
              SliverAppBar(
                expandedHeight: expandedHeaderHeight ?? 110.0,
                pinned: true,
                elevation: 0,
                scrolledUnderElevation: 0,
                backgroundColor: isDark ? AppColors.darkBackground : AppColors.grey50,
                automaticallyImplyLeading: false,
                leading:
                    canPop
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.grey800 : AppColors.grey100,
                                borderRadius: BorderRadius.circular(Dimens.r10),
                              ),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: isDark ? AppColors.white : AppColors.grey700,
                                size: Dimens.icon20,
                              ),
                            ),
                          ),
                        )
                        : null,
                actions: actions,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: canPop ? 56.0 : 20.0, bottom: 12.0),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title!,
                        style: AppStyles.heading4.copyWith(
                          color: isDark ? AppColors.white : AppColors.grey900,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500, fontSize: 10.0),
                        ),
                    ],
                  ),
                ),
              ),
            ...slivers,
          ];
        },
        body: body!,
      );
    } else {
      mainContent = CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          // ── Sliver App Bar ───────────────────────────────────────────────
          if (title != null)
            SliverAppBar(
              expandedHeight: expandedHeaderHeight ?? 110.0,
              pinned: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: isDark ? AppColors.darkBackground : AppColors.grey50,
              automaticallyImplyLeading: false,
              leading:
                  canPop
                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.grey800 : AppColors.grey100,
                              borderRadius: BorderRadius.circular(Dimens.r10),
                            ),
                            child: Icon(Icons.arrow_back_rounded, color: isDark ? AppColors.white : AppColors.grey700, size: Dimens.icon20),
                          ),
                        ),
                      )
                      : null,
              actions: actions,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: canPop ? 56.0 : 20.0, bottom: 12.0),
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title!,
                      style: AppStyles.heading4.copyWith(
                        color: isDark ? AppColors.white : AppColors.grey900,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500, fontSize: 10.0),
                      ),
                  ],
                ),
              ),
            ),

          // ── Body content slivers ─────────────────────────────────────────
          ...slivers,

          // ── Scroll spacing clearance at bottom ───────────────────────────
          SliverToBoxAdapter(child: SizedBox(height: Dimens.h100)),
        ],
      );
    }

    // If a legacy static topHeader is provided, wrap content in a Column
    if (topHeader != null) {
      mainContent = Column(children: [topHeader!, Expanded(child: mainContent)]);
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.grey50,
      extendBody: false,
      body: SafeArea(child: mainContent),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
