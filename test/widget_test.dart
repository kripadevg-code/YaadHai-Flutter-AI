import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaad_hai/modules/scanner/components/knowledge_tree_branch.dart';
import 'package:yaad_hai/modules/scanner/components/knowledge_tree_branch_column.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';

void main() {
  testWidgets('knowledge tree branch has finite width in horizontal scroll', (tester) async {
    const KnowledgeTreeBranch branch = KnowledgeTreeBranch(label: 'Branch', color: AppColors.primary, leaves: ['Leaf']);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder:
            (_, _) => const MaterialApp(
              home: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [KnowledgeTreeBranchColumn(branch: branch, isDarkTheme: false, isSingle: true)]),
              ),
            ),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}
