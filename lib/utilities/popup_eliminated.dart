import 'package:flutter/material.dart';

class PopupEliminated extends StatefulWidget {
  const PopupEliminated({
    super.key,
    required this.playerNames,
  });

  final List<String> playerNames;

  @override
  State<PopupEliminated> createState() => _PopupEliminatedState();
}

class _PopupEliminatedState extends State<PopupEliminated> {
  late List<String> _playerNames;

  @override
  void initState() {
    _playerNames = widget.playerNames;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // print all the eliminated players
            for (var i = 0; i < _playerNames.length; i++)
              Text(
                _playerNames[i],
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 20),
            const Text(
              'Eliminated',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            // icon death
            const Icon(
              Icons.sentiment_very_dissatisfied,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
