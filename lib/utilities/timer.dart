import 'dart:async';
import 'package:explode/constants/general.dart';
import 'package:explode/providers/time_ender_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          // Change Provider value to true
          Provider.of<EndTimer>(context, listen: false).changeEndTimer(true);
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
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //   gameOverRoute,
          //   (route) => false,
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
