import 'dart:io';

import 'package:explode/constants/general.dart';
import 'package:explode/constants/routes.dart';
import 'package:explode/providers/answers_provider.dart';
import 'package:explode/providers/time_ender_provider.dart';
import 'package:explode/views/difficulty.dart';
import 'package:explode/views/end_screen_multiplayer.dart';
import 'package:explode/views/game.dart';
import 'package:explode/views/game_multiplayer.dart';
import 'package:explode/views/game_over.dart';
import 'package:explode/views/group_choice.dart';
import 'package:explode/views/players_choice.dart';
import 'package:explode/views/record.dart';
import 'package:explode/views/scores_multiplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EndTimer()),
        ChangeNotifierProvider(create: (_) => Answers()),
      ],
      child: MaterialApp(
        title: 'Explode',
        theme: ThemeData(
          backgroundColor: primaryColor,
        ),
        // home: const GameMultiplayer(
        //   groupId: 1,
        //   playerNames: ['Player 1', 'Player 2'],
        // ),
        // const Game(
        //   operators: ['+', '-', 'x', '/'],
        //   difficulty: '1',
        //   time: '2',
        // ),
        // home: const EndScreenMultiplayer(
        //   groupId: 1,
        //   playerName: 'Diogo',
        //   score: 10,
        // ),
        // home: const MainMenu(),
        home: const EndScreenMultiplayer(
          groupId: 1,
          playerName: 'bbbbb',
          score: 10,
        ),
        routes: {
          mainMenuRoute: (context) => const MainMenu(),
          difficultyRoute: (context) => const Difficulty(),
          gameRoute: (context) => const Game(
                operators: ['+', '-'],
                difficulty: '1',
                time: '2',
              ),
          gameOverRoute: (context) => const GameOver(),
          recordRoute: (context) => const Record(
                correctAnswers: 10,
                wrongAnswers: 2,
                difficulty: '1',
                operators: ['+', '-'],
                time: 2,
              ),
          groupChoiceRoute: (context) => const GroupChoice(),
          playersChoiceRoute: (context) => const PlayersChoice(),
          gameMultiplayerRoute: (context) => const GameMultiplayer(
                groupId: 1,
                playerNames: ['Player 1', 'Player 2'],
              ),
          scoresMultiplayerRoute: (context) => const ScoresMultiplayer(),
        },
      ),
    ),
  );
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Explode',
              style: TextStyle(
                color: Colors.white,
                fontSize: 120,
                fontFamily: fontTitle,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
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
              onPressed: () {
                Navigator.of(context).pushNamed(groupChoiceRoute);
              },
              child: const Text(
                'New Game',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: fontBody,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // button to start the game
            ElevatedButton(
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
              onPressed: () {
                Navigator.of(context).pushNamed(difficultyRoute);
              },
              child: const Text(
                'Practice',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: fontBody,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // button to see the records
            ElevatedButton(
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
              onPressed: () {
                Navigator.of(context).pushNamed(scoresMultiplayerRoute);
              },
              child: const Text(
                'Records',
                style: TextStyle(
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
