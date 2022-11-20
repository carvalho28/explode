import 'package:explode/constants/general.dart';
import 'package:explode/models/group_model.dart';
import 'package:explode/models/player_model.dart';
import 'package:explode/services/crud/group_service.dart';
import 'package:explode/services/crud/players_service.dart';
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

  final Map<String, TextEditingController> _controllers = {
    '1': TextEditingController(),
    '2': TextEditingController(),
    '3': TextEditingController(),
    '4': TextEditingController(),
    '5': TextEditingController(),
    '6': TextEditingController(),
  };

  // function to create group of players
  Future saveGroup(List<String> playersName, String groupName) async {
    // if all players name are not empty
    if (playersName.isNotEmpty) {
      print('Here');
      // create group
      GroupModel groupModel =
          await GroupService.instance.createGroup(GroupModel(
        name: groupName,
      ));
      print("Group created with id: ${groupModel.id}");
      int groupId = groupModel.id!;
      if (groupId != -1) {
        for (String playerName in playersName) {
          await PlayersService.instance.create(
            PlayerModel(name: playerName, groupId: groupId),
          );
        }
      } else {
        print('Group $groupId not found');
      }
    } else {
      print('empty');
      // if one of the players name is empty, show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the players name'),
        ),
      );
    }
  }

  // read all players with a group id
  Future readTable() async {
    try {
      final result1 = await PlayersService.instance.readAllPlayers();
      final result2 = await GroupService.instance.readAllGroups();
      print("Table Players: $result1");
      print("Table Groups: $result2");
    } catch (e) {
      print('No tables found');
    }
  }

  // delete table players
  Future deleteTables() async {
    try {
      await PlayersService.instance.deleteTable();
      await GroupService.instance.deleteTable();
    } catch (e) {
      print(e);
    }
  }

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
                List<String> playersName = [];
                for (int i = 0; i < int.parse(_selectedPlayer!); i++) {
                  if (_controllers['${i + 1}']!.text.isNotEmpty) {
                    playersName.add(_controllers['${i + 1}']!.text);
                  }
                }
                print(playersName);
                // saveGroup(playersName, 'Group 1');
                // deleteTables();
                readTable();
                // saveGroup(playersName, 'group1');
                // readTable();
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
