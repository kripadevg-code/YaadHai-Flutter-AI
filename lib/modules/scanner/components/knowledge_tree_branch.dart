import 'package:flutter/material.dart';

class KnowledgeTreeBranch {
  const KnowledgeTreeBranch({required this.label, required this.color, required this.leaves});

  final String label;
  final Color color;
  final List<String> leaves;
}
