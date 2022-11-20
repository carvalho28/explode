import 'package:explode/views/game.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'game_engine.dart';

class Levels extends StatefulWidget {
  const Levels({super.key, required this.level});

  final int level;

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  late int _level;

  @override
  void initState() {
    _level = widget.level;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_level == 1) {
      return const ExpressionGenerator(
        operators: ['+', '-'],
        difficulty: '1',
        skipEnabled: false,
      );
    } else if (_level == 2) {
      return const ExpressionGenerator(
        operators: ['+', '-', 'x'],
        difficulty: '2',
        skipEnabled: false,
      );
    } else if (_level == 3) {
      return const ExpressionGenerator(
        operators: ['+', '-', 'x', '/'],
        difficulty: '2',
        skipEnabled: false,
      );
    } else {
      return const ExpressionGenerator(
        operators: ['+', '-', 'x', '/'],
        difficulty: '3',
        skipEnabled: false,
      );
    }
  }
}
