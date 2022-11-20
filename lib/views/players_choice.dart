import 'package:explode/constants/general.dart';
import 'package:flutter/material.dart';

class PlayersChoice extends StatefulWidget {
  const PlayersChoice({super.key});

  @override
  State<PlayersChoice> createState() => _PlayersChoiceState();
}

class _PlayersChoiceState extends State<PlayersChoice> {
  final List<String> _players = ['2', '3', '4', '5', '6'];
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        value: _players[0],
        child: Text(_players[0]),
      ),
      DropdownMenuItem(
        value: _players[1],
        child: Text(_players[1]),
      ),
      DropdownMenuItem(
        value: _players[2],
        child: Text(_players[2]),
      ),
      DropdownMenuItem(
        value: _players[3],
        child: Text(_players[3]),
      ),
      DropdownMenuItem(
        value: _players[4],
        child: Text(_players[4]),
      ),
    ];
    return menuItems;
  }

  String? _selectedPlayer = '2';

  Map<String, TextEditingController> _controllers = {
    '1': TextEditingController(),
    '2': TextEditingController(),
    '3': TextEditingController(),
    '4': TextEditingController(),
    '5': TextEditingController(),
    '6': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    // let the user choose the number of players and prompt them to enter their names
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Players',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: fontBody,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // dropdown must select one of the options, matching color scheme
            DropdownButton(
              value: _selectedPlayer,
              items: dropdownItems,
              onChanged: (value) {
                setState(() {
                  _selectedPlayer = value as String;
                });
              },
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: fontBody,
              ),
              // on selected, the dropdown must match the color scheme
              dropdownColor: primaryColor,
              iconEnabledColor: Colors.white,
            ),
            // prompt user to enter their names
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Enter your names:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: fontBody,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // create a TextController for each player
            for (int i = 0; i < int.parse(_selectedPlayer!); i++)
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _controllers['${i + 1}'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: fontBody,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Player ${i + 1}',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: fontBody,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 50,
            ),
            // button to start the game
            ElevatedButton(
              onPressed: () {
                // navigate to the game screen
                // Navigator.pushNamed(context, '/game');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: const Text(
                'Create Group',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
