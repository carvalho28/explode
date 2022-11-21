import 'package:explode/constants/general.dart';
import 'package:explode/constants/routes.dart';
import 'package:explode/models/score_model.dart';
import 'package:explode/services/crud/players_service.dart';
import 'package:explode/services/crud/score_service.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class EndScreenMultiplayer extends StatefulWidget {
  const EndScreenMultiplayer({
    super.key,
    required this.groupId,
    required this.playerName,
    required this.score,
  });

  final int groupId;
  final String playerName;
  final int score;

  @override
  State<EndScreenMultiplayer> createState() => _EndScreenMultiplayerState();
}

class _EndScreenMultiplayerState extends State<EndScreenMultiplayer> {
  late final int _groupId;
  late final String _playerName;
  late final int _score;

  late int _playerId = -1;

  // read table scores
  // Future<void> _printScores() async {
  //   List<ScoreModel> scores = await ScoresService.instance.readAllScores();
  //   print(scores);
  // }

  // // read table players
  // Future<void> _printPlayers() async {
  //   List<PlayerModel> players = await PlayersService.instance.readAllPlayers();
  //   print(players);
  // }

  // // read table groups
  // Future<void> _printGroups() async {
  //   List<GroupModel> groups = await GroupService.instance.readAllGroups();
  //   print(groups);
  // }

  // add score to table scores
  Future _addScore() async {
    try {
      _playerId =
          (await PlayersService.instance.getPlayerId(_playerName, _groupId));
    } catch (e) {
      // print('Error on converting name to id: $e');
    }
    if (_playerId != -1) {
      try {
        await ScoresService.instance.create(ScoreModel(
          playerId: _playerId,
          groupId: _groupId,
          score: _score,
        ));
      } catch (e) {
        // print('Error on adding score: $e');
      }
    } else {
      // print('Error on adding score: player id not found');
    }
  }

  @override
  void initState() {
    _groupId = widget.groupId;
    _playerName = widget.playerName;
    _score = widget.score;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _printScores();
    // _printPlayers();
    // _printGroups();
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 3),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: const Icon(
                Icons.emoji_events,
                color: Colors.white,
                size: 120,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 3),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: const Text(
                'Winner',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontFamily: fontGameOver,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // winner name
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 3),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Text(
                _playerName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontFamily: fontBody,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // share button
            Row(
              // score text and share icon
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(seconds: 3),
                  builder: (context, double value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: Text(
                    'Score: $_score',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: fontBody,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(seconds: 3),
                  builder: (context, double value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: IconButton(
                    onPressed: () {
                      Share.share(
                          'I just scored $_score points aginst my friends in Explode! Can you beat me?');
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            // button to go to home
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 3),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: ElevatedButton(
                onPressed: () {
                  _addScore();
                  // _printScores();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    mainMenuRoute,
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  // add shadow to the button
                  elevation: 15,
                ),
                child: const Text(
                  'Back to Main Menu',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: fontBody,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
