import 'package:explode/constants/general.dart';
import 'package:explode/utilities/popup.dart';
import 'package:explode/utilities/timer.dart';
import 'package:explode/utilities/timer_multiplayer.dart';
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
  late List<int> _scores;
  late int _timeLevel;

  bool _startClock = false;

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
    _scores = List<int>.filled(_numberOfPlayers, 0);
    _timeLevel = getTimeFromLevel(_level);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (context) => PopupPlayer(
          playerName: _players[_playerNow],
          playerTime: _timeLevel,
        ),
      );
      setState(() {
        _startClock = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_groupId);
    print(_players);
    print(_numberOfPlayers);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (_startClock)
              TimerMultiplayer(
                startingTime: 5,
                onEnd: () {
                  setState(() {
                    _playerNow = (_playerNow + 1) % _numberOfPlayers;
                    _timeLevel = getTimeFromLevel(_level);
                    _startClock = false;
                  });
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    await showDialog(
                      context: context,
                      builder: (context) => PopupPlayer(
                        playerName: _players[_playerNow],
                        playerTime: _timeLevel,
                      ),
                    );
                    setState(() {
                      _startClock = true;
                    });
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
