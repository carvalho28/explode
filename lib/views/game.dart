import 'dart:math';

import 'package:explode/constants/general.dart';
import 'package:explode/utilities/game_engine.dart';
import 'package:explode/utilities/timer.dart';
import 'package:explode/utilities/verification_icon.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key, required this.operators, required this.difficulty});

  final List<String> operators;
  final String difficulty;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late List<String> _operators;
  late String _difficulty;

  @override
  void initState() {
    super.initState();
    _operators = widget.operators;
    _difficulty = widget.difficulty;
    print('Difficulty: $_difficulty');
    print('Operators: $_operators');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // invisible app bar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: Column(
          children: [
            const TimerWidget(startingTime: 20),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 70,
              ),
              child: ExpressionGenerator(
                operators: _operators,
                difficulty: _difficulty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
