import 'package:explode/utilities/game_engine_multiplayer.dart';
import 'package:explode/views/game.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'game_engine.dart';

class Levels extends StatefulWidget {
  const Levels({
    super.key,
    required this.level,
    required this.correct,
  });

  final int level;
  final Function correct;

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
      return ExpressionGeneratorMultiplayer(
        operators: ['+', '-'],
        difficulty: '1',
        skipEnabled: false,
        onEndCorrect: () {
          widget.correct();
        },
      );
    } else if (_level == 2) {
      return ExpressionGeneratorMultiplayer(
        operators: const ['+', '-', 'x'],
        difficulty: '2',
        skipEnabled: false,
        onEndCorrect: () {
          widget.correct();
        },
      );
    } else if (_level == 3) {
      return ExpressionGeneratorMultiplayer(
        operators: ['+', '-', 'x', '/'],
        difficulty: '2',
        skipEnabled: false,
        onEndCorrect: () {
          widget.correct();
        },
      );
    } else {
      return ExpressionGeneratorMultiplayer(
        operators: ['+', '-', 'x', '/'],
        difficulty: '3',
        skipEnabled: false,
        onEndCorrect: () {
          widget.correct();
        },
      );
    }
  }
}
