import 'package:explode/constants/general.dart';
import 'package:explode/utilities/timer.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: TimerWidget(
              startingTime: 5,
            ),
          ),
        ],
        toolbarHeight: 50,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: const Center(
        child: Text('Game'),
      ),
    );
  }
}
