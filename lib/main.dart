import 'dart:io';

import 'package:explode/constants/general.dart';
import 'package:explode/constants/routes.dart';
import 'package:explode/views/difficulty.dart';
import 'package:explode/views/game.dart';
import 'package:explode/views/game_over.dart';
import 'package:explode/views/record.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Explode',
      theme: ThemeData(
        backgroundColor: primaryColor,
      ),
      home: const MainMenu(),
      // const Record(
      //   correctAnswers: 5,
      // ),
      //     const Game(
      //   operators: ['+', '-', 'x', '/'],
      //   difficulty: '1',
      //   time: '5',
      // ),
      routes: {
        mainMenuRoute: (context) => const MainMenu(),
        difficultyRoute: (context) => const Difficulty(),
        gameRoute: (context) => const Game(
              operators: ['+', '-', 'x', '/'],
              difficulty: '1',
              time: '50',
            ),
        gameOverRoute: (context) => const GameOver(),
        recordRoute: (context) => const Record(
              correctAnswers: 1,
            ),
      },
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
          // title displayed on the main menu screen with animation of exploding
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                elevation: 15,
              ),
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              child: const Text(
                'Quit',
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
