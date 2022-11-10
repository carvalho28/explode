import 'dart:math';

import 'package:explode/constants/general.dart';
import 'package:explode/main.dart';
import 'package:explode/utilities/game_engine.dart';
import 'package:explode/utilities/timer.dart';
import 'package:explode/utilities/verification_icon.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({
    super.key,
    required this.operators,
    required this.difficulty,
    required this.time,
  });

  final List<String> operators;
  final String difficulty;
  final String time;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late List<String> _operators;
  late String _difficulty;
  late int _time;

  @override
  void initState() {
    super.initState();
    _operators = widget.operators;
    _difficulty = widget.difficulty;
    _time = int.parse(widget.time);
    print('Difficulty: $_difficulty');
    print('Operators: $_operators');
    print('Time: $_time');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // invisible app bar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // icon to go back to the main menu on the top right corner
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app_outlined),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainMenu(),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: primaryColor,
        body: Column(
          children: [
            TimerWidget(
              startingTime: _time,
            ),
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
