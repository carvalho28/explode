import 'dart:math';
import 'package:explode/constants/general.dart';
import 'package:explode/constants/routes.dart';
import 'package:explode/utilities/levels.dart';
import 'package:explode/utilities/popup.dart';
import 'package:explode/utilities/popup_eliminated.dart';
import 'package:explode/utilities/timer_multiplayer.dart';
import 'package:explode/views/end_screen_multiplayer.dart';
import 'package:flutter/material.dart';

class GameMultiplayer extends StatefulWidget {
  const GameMultiplayer({
    super.key,
    required this.groupId,
    required this.playerNames,
  });

  final int groupId;
  final List<String> playerNames;

  @override
  State<GameMultiplayer> createState() => _GameMultiplayerState();
}

class _GameMultiplayerState extends State<GameMultiplayer> {
  late int _groupId;
  late List<String> _players;
  late int _numberOfPlayers;
  late int _level = 1;
  late int _playerNow = 0;
  // late List<int> _scores;
  late int _timeLevel;

  bool _startClock = false;

  // make a map, with the player name as key and the score as value
  final Map<String, int> _scoreMap = {};

  // widget of Expression
  // late Widget _expression;

  // get timer value from level
  int getTimeFromLevel(int level) {
    if (level == 1) {
      return 60;
    } else if (level == 2) {
      return 40;
    } else if (level == 3) {
      return 20;
    } else {
      return 10;
    }
  }

  @override
  void initState() {
    _groupId = widget.groupId;
    _players = widget.playerNames;
    _numberOfPlayers = _players.length;
    // _scores = List<int>.filled(_numberOfPlayers, 0);
    _timeLevel = getTimeFromLevel(_level);
    _scoreMap.addAll({
      for (int i = 0; i < _numberOfPlayers; i++) _players[i]: 0,
    });
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (context) => PopupPlayer(
          playerName: _scoreMap.keys.elementAt(_playerNow),
          playerTime: _timeLevel,
          level: _level,
        ),
      );
      setState(() {
        _startClock = true;
      });
    });
  }

  Future sleep1() {
    return Future.delayed(const Duration(seconds: 1), () => "1");
  }

  @override
  Widget build(BuildContext context) {
    // print("scores: $_scoreMap");
    // print("Player now: $_playerNow");
    // print("Level: $_level");

    // print("scoreMap: $_scoreMap");

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            // cross icon
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, mainMenuRoute, (route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (_startClock)
              Column(
                children: [
                  TimerMultiplayer(
                    startingTime: _timeLevel,
                    onEnd: () {
                      // go to next player
                      // if no players left, go to next level
                      if (_playerNow == _numberOfPlayers - 1) {
                        // check if there is a minimum in the scores
                        int scoreMin = _scoreMap.values.reduce(min);
                        // if all elements are equal, then there is no minimum
                        if (_scoreMap.values
                            .every((element) => element == scoreMin)) {
                        } else {
                          // show popup with the players that will be eliminated
                          List<String> playersEliminated = [];
                          _scoreMap.forEach((key, value) {
                            if (value == scoreMin) {
                              playersEliminated.add(key);
                            }
                          });
                          _scoreMap
                              .removeWhere((key, value) => value == scoreMin);
                          _numberOfPlayers = _scoreMap.length;
                          Future.delayed(const Duration(milliseconds: 300), () {
                            showDialog(
                              context: context,
                              builder: (context) => PopupEliminated(
                                playerNames: playersEliminated,
                              ),
                            );
                          });
                          // wait for the popup to be closed
                          sleep1();

                          // if there is only one player left, then he wins
                          if (_scoreMap.length == 1) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    EndScreenMultiplayer(
                                  groupId: _groupId,
                                  playerName: _scoreMap.keys.first,
                                  score: _scoreMap.values.first,
                                ),
                              ),
                              (route) => false,
                            );
                            return;
                          }
                        }
                        setState(() {
                          _playerNow = 0;
                          _level = _level + 1;
                          _timeLevel = getTimeFromLevel(_level);
                          _scoreMap.updateAll((key, value) => 0);
                          _startClock = false;
                        });
                      } else {
                        setState(() {
                          _playerNow = _playerNow + 1;
                          _startClock = false;
                        });
                      }
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        await showDialog(
                          context: context,
                          builder: (context) => PopupPlayer(
                            playerName: _scoreMap.keys.elementAt(_playerNow),
                            playerTime: _timeLevel,
                            level: _level,
                          ),
                        );
                        setState(() {
                          _startClock = true;
                        });
                      });
                    },
                  ),
                  // present the expression to the player
                  const SizedBox(height: 50),
                  Levels(
                    level: _level,
                    correct: () {
                      setState(() {
                        _scoreMap.update(_scoreMap.keys.elementAt(_playerNow),
                            (value) => value + 1);
                      });
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
