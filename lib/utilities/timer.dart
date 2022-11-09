import 'dart:async';

import 'package:explode/constants/general.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key, required this.startingTime});

  final int startingTime;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const GameOver(),
          //   ),
          // );
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
    return Text(
      'Time Left: $_timeRemaining',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontFamily: fontBody,
      ),
    );
  }
}
