import 'package:flutter/material.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

class SummaryResponsiveRow extends StatelessWidget {
  const SummaryResponsiveRow({
    super.key,
    required this.isWide,
    required this.leftFlex,
    required this.rightFlex,
    required this.left,
    required this.right,
  });

  final bool isWide;
  final int leftFlex;
  final int rightFlex;
  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    if (isWide) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Expanded(flex: leftFlex, child: left), SizedBox(width: Dimens.w14), Expanded(flex: rightFlex, child: right)],
        ),
      );
    }

    return Column(children: [left, SizedBox(height: Dimens.h14), right]);
  }
}
