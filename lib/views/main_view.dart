import 'dart:async';
import 'dart:math';

import 'package:explode/constants/general.dart';
import 'package:explode/main.dart';
import 'package:explode/views/game_over.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

// create a timer widget to display the time left
class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  // create a timer widget to display the time left
  int _timeLeft = 5;

  @override
  void initState() {
    super.initState();
    // start the timer
    startTimer();
  }

  void startTimer() {
    // start the timer
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (_timeLeft < 1) {
        timer.cancel();
        // if the time is up, go to the game over screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GameOver(),
          ),
        );
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_timeLeft',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontFamily: fontBody,
      ),
    );
  }
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: primaryColor,
      child: const Center(
        // present the timer on the upper right corner
        child: TimerWidget(),
      ),
    ));
  }
}
