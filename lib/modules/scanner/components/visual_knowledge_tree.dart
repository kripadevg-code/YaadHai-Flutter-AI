import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/shared/components/premium_card.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/app_styles.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class VisualKnowledgeTree extends StatelessWidget {
  const VisualKnowledgeTree({super.key, required this.concepts, this.pack});

  final List<ConceptData> concepts;
  final StudyPackResult? pack;

  @override
  Widget build(BuildContext context) {
    if (concepts.isEmpty) {
      return const Center(child: Text('No visual analytics available.', style: TextStyle(color: AppColors.grey500)));
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── 1. AI Content Analytics & Charts Dashboard (AT THE TOP) ────────
          Padding(
            padding: EdgeInsets.fromLTRB(Dimens.w20, Dimens.h20, Dimens.w20, Dimens.h8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(Icons.insights_rounded, color: AppColors.primary, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'AI Learning Insights',
                      style: AppStyles.heading3.copyWith(fontWeight: FontWeight.bold, color: isDark ? AppColors.white : AppColors.grey900),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Visual analysis of scanned concept metrics, load split, and recall retention projection.',
                  style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
                ),
                SizedBox(height: Dimens.h20),

                // Grid of Charts
                _ComplexityChartCard(concepts: concepts, isDark: isDark),
                SizedBox(height: Dimens.h16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _CompositionChartCard(
                        conceptsCount: concepts.length,
                        flashcardsCount: pack?.flashcards.length ?? 8,
                        quizzesCount: pack?.quizQuestions.length ?? 5,
                        isDark: isDark,
                      ),
                    ),
                    SizedBox(width: Dimens.w16),
                    Expanded(child: _RetentionCurveCard(isDark: isDark)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          Divider(
            color: isDark ? AppColors.white.withValues(alpha: 0.08) : AppColors.grey200,
            thickness: 1,
            indent: Dimens.w20,
            endIndent: Dimens.w20,
          ),

          // ─── 2. Colorful Mind Map Visual Tree (BELOW CHARTS) ────────────────
          Padding(
            padding: EdgeInsets.all(Dimens.w20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_tree_rounded, color: AppColors.primary, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'Visual Knowledge Map',
                      style: AppStyles.heading3.copyWith(fontWeight: FontWeight.bold, color: isDark ? AppColors.white : AppColors.grey900),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Hierarchical mind map of chapters and sub-concept relationships.',
                  style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey500),
                ),
                SizedBox(height: Dimens.h24),

                // Root Node of the Tree
                _RootNodeWidget(isDark: isDark),
                const SizedBox(height: 12),

                // Concept Branches
                ...List.generate(concepts.length, (index) {
                  return _buildTreeBranch(concepts[index], index, isDark);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Custom Tree Branch Builder with Colorful Elbow Connectors ─────────────

  Widget _buildTreeBranch(ConceptData concept, int index, bool isDark) {
    final colors = [AppColors.primary, AppColors.success, AppColors.brandPurple, AppColors.warning, AppColors.info];
    final color = colors[index % colors.length];

    return Padding(
      padding: const EdgeInsets.only(left: 24.0, bottom: 20.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Vertical line connector
          Positioned(left: -16, top: -24, bottom: 0, width: 2, child: Container(color: color.withValues(alpha: 0.3))),
          // Horizontal elbow connector
          Positioned(left: -16, top: 24, width: 16, height: 2, child: Container(color: color.withValues(alpha: 0.3))),
          // Branch Card
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
              boxShadow: isDark ? null : [BoxShadow(color: color.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header of concept with unique background color tint
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 11,
                        backgroundColor: color,
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          concept.title,
                          style: AppStyles.bodyMediumBold.copyWith(color: isDark ? AppColors.white : AppColors.grey900),
                        ),
                      ),
                    ],
                  ),
                ),
                // Summary & sub points
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        concept.summary,
                        style: AppStyles.bodySmall.copyWith(color: isDark ? AppColors.grey400 : AppColors.grey600, height: 1.4),
                      ),
                      if (concept.keyPoints.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        ...concept.keyPoints.map(
                          (pt) => Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.subdirectory_arrow_right_rounded, size: 14, color: color),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    pt,
                                    style: TextStyle(fontSize: 11, color: isDark ? AppColors.grey300 : AppColors.grey700, height: 1.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Mind Map Root Node Widget ───────────────────────────────────────────────

class _RootNodeWidget extends StatelessWidget {
  const _RootNodeWidget({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [AppColors.primary, AppColors.brandPurple]),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text(AppStrings.knowledgeTreeOverview, style: AppStyles.labelMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// ─── Chart 1: Concept Complexity Bar Chart (Animated & Interactive) ──────────

class _ComplexityChartCard extends StatefulWidget {
  const _ComplexityChartCard({required this.concepts, required this.isDark});

  final List<ConceptData> concepts;
  final bool isDark;

  @override
  State<_ComplexityChartCard> createState() => _ComplexityChartCardState();
}

class _ComplexityChartCardState extends State<_ComplexityChartCard> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final displayConcepts = widget.concepts.take(5).toList();
    final double maxVal = (displayConcepts.map((e) => e.keyPoints.length).fold(3, math.max) + 2).toDouble();

    return PremiumCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Concept Complexity (Key Points Density)',
            style: AppStyles.bodyMediumBold.copyWith(color: widget.isDark ? AppColors.white : AppColors.grey900),
          ),
          const SizedBox(height: 2),
          Text(
            'Tap bars to inspect points density and complexity ratios.',
            style: AppStyles.bodySmall.copyWith(color: widget.isDark ? AppColors.grey400 : AppColors.grey500, fontSize: 11),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 160,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutBack,
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, animValue, child) {
                return BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxVal,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchCallback: (FlTouchEvent event, barTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions || barTouchResponse == null || barTouchResponse.spot == null) {
                            _touchedIndex = -1;
                            return;
                          }
                          _touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                        });
                      },
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => widget.isDark ? AppColors.grey800 : AppColors.grey100,
                        tooltipPadding: const EdgeInsets.all(6),
                        tooltipMargin: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '${rod.toY.round()} Points',
                            const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 11),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final idx = value.toInt();
                            if (idx >= 0 && idx < displayConcepts.length) {
                              final title = displayConcepts[idx].title;
                              final label = title.length > 8 ? '${title.substring(0, 7)}..' : title;
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    color: widget.isDark ? AppColors.grey400 : AppColors.grey600,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(displayConcepts.length, (index) {
                      final ptCount = displayConcepts[index].keyPoints.length;
                      final isTouched = index == _touchedIndex;
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: ptCount.toDouble() * animValue,
                            color: isTouched ? AppColors.brandPurple : AppColors.primary,
                            width: isTouched ? 28 : 22,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: maxVal - 1,
                              color: widget.isDark ? AppColors.white.withValues(alpha: 0.05) : AppColors.grey200.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Chart 2: Study Pack Composition Pie Chart (Animated & Exploding) ─────────

class _CompositionChartCard extends StatefulWidget {
  const _CompositionChartCard({
    required this.conceptsCount,
    required this.flashcardsCount,
    required this.quizzesCount,
    required this.isDark,
  });

  final int conceptsCount;
  final int flashcardsCount;
  final int quizzesCount;
  final bool isDark;

  @override
  State<_CompositionChartCard> createState() => _CompositionChartCardState();
}

class _CompositionChartCardState extends State<_CompositionChartCard> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final double total = (widget.conceptsCount + widget.flashcardsCount + widget.quizzesCount).toDouble();

    return PremiumCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pack Load Split', style: AppStyles.bodyMediumBold.copyWith(color: widget.isDark ? AppColors.white : AppColors.grey900)),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutBack,
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, animValue, child) {
                return PieChart(
                  PieChartData(
                    sectionsSpace: 3,
                    centerSpaceRadius: 22,
                    startDegreeOffset: 270,
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                            _touchedIndex = -1;
                            return;
                          }
                          _touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    sections: [
                      PieChartSectionData(
                        color: AppColors.primary,
                        value: widget.conceptsCount.toDouble() * animValue,
                        title: _touchedIndex == 0 ? '${widget.conceptsCount}' : '${(widget.conceptsCount / total * 100).round()}%',
                        radius: _touchedIndex == 0 ? 22.0 : 12.0,
                        titleStyle: TextStyle(fontSize: _touchedIndex == 0 ? 11 : 8, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      PieChartSectionData(
                        color: AppColors.success,
                        value: widget.flashcardsCount.toDouble() * animValue,
                        title: _touchedIndex == 1 ? '${widget.flashcardsCount}' : '${(widget.flashcardsCount / total * 100).round()}%',
                        radius: _touchedIndex == 1 ? 22.0 : 12.0,
                        titleStyle: TextStyle(fontSize: _touchedIndex == 1 ? 11 : 8, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      PieChartSectionData(
                        color: AppColors.brandPurple,
                        value: widget.quizzesCount.toDouble() * animValue,
                        title: _touchedIndex == 2 ? '${widget.quizzesCount}' : '${(widget.quizzesCount / total * 100).round()}%',
                        radius: _touchedIndex == 2 ? 22.0 : 12.0,
                        titleStyle: TextStyle(fontSize: _touchedIndex == 2 ? 11 : 8, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _LegendRow(color: AppColors.primary, label: 'Concepts (${widget.conceptsCount})', isDark: widget.isDark),
          const SizedBox(height: 6),
          _LegendRow(color: AppColors.success, label: 'Cards (${widget.flashcardsCount})', isDark: widget.isDark),
          const SizedBox(height: 6),
          _LegendRow(color: AppColors.brandPurple, label: 'Quizzes (${widget.quizzesCount})', isDark: widget.isDark),
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.color, required this.label, required this.isDark});
  final Color color;
  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isDark ? AppColors.grey400 : AppColors.grey600),
          ),
        ),
      ],
    );
  }
}

// ─── Chart 3: Active Recall Retention Curve (Animated Line Chart) ─────────────

class _RetentionCurveCard extends StatefulWidget {
  const _RetentionCurveCard({required this.isDark});
  final bool isDark;

  @override
  State<_RetentionCurveCard> createState() => _RetentionCurveCardState();
}

class _RetentionCurveCardState extends State<_RetentionCurveCard> {
  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Retention Curve', style: AppStyles.bodyMediumBold.copyWith(color: widget.isDark ? AppColors.white : AppColors.grey900)),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, animValue, child) {
                return LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    lineTouchData: LineTouchData(
                      enabled: true,
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (_) => widget.isDark ? AppColors.grey800 : AppColors.grey100,
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            return LineTooltipItem(
                              '${spot.y.round()}%',
                              const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 10),
                            );
                          }).toList();
                        },
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 1,
                    maxX: 7,
                    minY: 10,
                    maxY: 100,
                    lineBarsData: [
                      // YaadHai Active Recall
                      LineChartBarData(
                        spots: [
                          FlSpot(1, 100),
                          FlSpot(2, 60 + (32 * animValue)),
                          FlSpot(3, 40 + (49 * animValue)),
                          FlSpot(4, 25 + (66 * animValue)),
                          FlSpot(5, 18 + (77 * animValue)),
                          FlSpot(6, 12 + (80 * animValue)),
                          FlSpot(7, 10 + (84 * animValue)),
                        ],
                        isCurved: true,
                        color: AppColors.success,
                        barWidth: 2.5,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: false),
                      ),
                      // Passive Reading Forgetting Curve
                      LineChartBarData(
                        spots: [
                          FlSpot(1, 100),
                          FlSpot(2, 100 - (40 * animValue)),
                          FlSpot(3, 100 - (60 * animValue)),
                          FlSpot(4, 100 - (75 * animValue)),
                          FlSpot(5, 100 - (82 * animValue)),
                          FlSpot(6, 100 - (88 * animValue)),
                          FlSpot(7, 100 - (90 * animValue)),
                        ],
                        isCurved: true,
                        color: AppColors.error,
                        barWidth: 1.5,
                        isStrokeCapRound: true,
                        dashArray: [4, 4],
                        dotData: const FlDotData(show: false),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _LegendRow(color: AppColors.success, label: 'YaadHai Recall (94%)', isDark: widget.isDark),
          const SizedBox(height: 6),
          _LegendRow(color: AppColors.error, label: 'Passive Reading (10%)', isDark: widget.isDark),
          const SizedBox(height: 6),
          Text(
            'Active recall retains 9.4x more.',
            style: TextStyle(fontSize: 8.5, fontStyle: FontStyle.italic, color: widget.isDark ? AppColors.grey500 : AppColors.grey500),
          ),
        ],
      ),
    );
  }
}
