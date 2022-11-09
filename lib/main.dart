import 'dart:io';

import 'package:explode/constants/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Explode',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainMenu(),
    ),
  );
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // create a main menu with a button to start the game
      title: 'Explode',
      theme: ThemeData(
        backgroundColor: primaryColor,
      ),
      home: Scaffold(
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
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'PressStart2P',
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
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
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
                    fontFamily: 'PressStart2P',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
