import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

/// A draggable bottom sheet with a handle bar and optional title.
///
/// Rewritten to use the project's own design system (no `infinity` package).
class CommonDraggableSheet extends StatefulWidget {
  const CommonDraggableSheet({
    super.key,
    required this.title,
    required this.builder,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.25,
    this.maxChildSize = 1.0,
  });

  final String title;
  final Widget Function(BuildContext context, ScrollController scrollController) builder;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;

  @override
  State<CommonDraggableSheet> createState() => _CommonDraggableSheetState();
}

class _CommonDraggableSheetState extends State<CommonDraggableSheet> {
  late final DraggableScrollableController _sheetController;

  @override
  void initState() {
    super.initState();
    _sheetController = DraggableScrollableController();
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: widget.initialChildSize,
      minChildSize: widget.minChildSize,
      maxChildSize: widget.maxChildSize,
      expand: true,
      builder:
          (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.r24)),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onVerticalDragUpdate: (details) {
                      if (_sheetController.isAttached) {
                        final currentSize = _sheetController.size;
                        final delta = details.primaryDelta ?? 0;
                        final screenHeight = MediaQuery.of(context).size.height;
                        final newSize = (currentSize - delta / screenHeight).clamp(widget.minChildSize, widget.maxChildSize);
                        _sheetController.jumpTo(newSize);
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: Dimens.h12),
                        // ── Handle bar ──────────────────────────────────
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
                        SizedBox(height: Dimens.h16),
                        // ── Title ────────────────────────────────────────
                        if (widget.title.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimens.w20),
                            child: Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
                          ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: isDark ? AppColors.grey700 : AppColors.grey200),
                  Expanded(child: widget.builder(context, scrollController)),
                ],
              ),
            ),
          ),
    );
  }
}
