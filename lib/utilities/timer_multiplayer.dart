// timer widget that onend do somthing

import 'dart:async';

import 'package:explode/constants/general.dart';
import 'package:flutter/material.dart';

class TimerMultiplayer extends StatefulWidget {
  // init time and function to do on end
  const TimerMultiplayer(
      {super.key, required this.startingTime, required this.onEnd});

  final int startingTime;
  final Function onEnd;

  @override
  State<TimerMultiplayer> createState() => _TimerMultiplayerState();
}

class _TimerMultiplayerState extends State<TimerMultiplayer> {
  late Timer _timer;
  late int _timeRemaining;

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.startingTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          timer.cancel();
          widget.onEnd();
        }
      });
    });
  }

  // function to freeze the timer
  void freezeTimer() {
    _timer.cancel();
  }

  // function to unfreeze the timer
  void unfreezeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          timer.cancel();
          widget.onEnd();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CircularProgressIndicator(
              value: _timeRemaining / widget.startingTime,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(secondaryColor),
            ),
          ),
          Center(
            child: Text(
              _timeRemaining.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: fontBody,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
