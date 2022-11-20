import 'package:explode/constants/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PopupPlayer extends StatefulWidget {
  const PopupPlayer({
    super.key,
    required this.playerName,
    required this.playerTime,
    required this.level,
  });

  final String playerName;
  final int playerTime;
  final int level;

  @override
  State<PopupPlayer> createState() => _PopupPlayerState();
}

class _PopupPlayerState extends State<PopupPlayer> {
  late String _playerName;
  late int _playerTime;
  late int _level;

  @override
  void initState() {
    _playerName = widget.playerName;
    _playerTime = widget.playerTime;
    _level = widget.level;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // alert dialog with player name and time on tap start game pop
    // show an alert dialog with player name and time
    return AlertDialog(
      // beautiful alert dialog
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _playerName,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Level: $_level',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'You have $_playerTime seconds.',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          // button to start the game
        ),
      ),
      actions: [
        //  centered button to start
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: primaryColor,
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
            onPressed: () {
              // close the dialog
              Navigator.of(context).pop();
            },
            child: const Text(
              'Start',
              style: TextStyle(
                fontSize: 30,
                fontFamily: fontBody,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
