import 'package:explode/constants/general.dart';
import 'package:explode/services/crud/players_service.dart';
import 'package:flutter/material.dart';

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

  late final _playerId;

  @override
  void initState() {
    _groupId = widget.groupId;
    _playerName = widget.playerName;
    _score = widget.score;
    try {
      _playerId = PlayersService.instance.getPlayerId(_playerName);
    } catch (e) {
      print(e);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(
              height: 100,
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
                  fontSize: 60,
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
              height: 50,
            ),
            // winner score
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
          ],
        ),
      ),
    );
  }
}
