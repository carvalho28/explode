import 'package:explode/constants/general.dart';
import 'package:explode/models/group_model.dart';
import 'package:explode/models/score_model.dart';
import 'package:explode/services/crud/group_service.dart';
import 'package:explode/services/crud/players_service.dart';
import 'package:explode/services/crud/score_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/player_model.dart';

class ScoresMultiplayer extends StatefulWidget {
  const ScoresMultiplayer({super.key});

  @override
  State<ScoresMultiplayer> createState() => _ScoresMultiplayerState();
}

class _ScoresMultiplayerState extends State<ScoresMultiplayer> {
  String? _selectedGroup = 'No group';
  // build dropdown menu with all groups from database
  Future<List<DropdownMenuItem<String>>> _buildDropdownMenuItems() async {
    List<GroupModel> groups = await GroupService.instance.readAllGroups();
    List<DropdownMenuItem<String>> items = [];
    items.add(
      const DropdownMenuItem(
        value: 'No group',
        child: Text('No group'),
      ),
    );
    for (GroupModel group in groups) {
      items.add(
        DropdownMenuItem(
          value: group.name,
          child: Text(group.name),
        ),
      );
    }
    return items;
  }

  // get highest score and player name from database
  Future<Map<int, String>> _getHighestScore() async {
    int _groupId = await GroupService.instance.getGroupId(_selectedGroup!);
    ScoreModel scores = await ScoresService.instance.getBestScore(_groupId);
    print(scores);
    if (scores.playerId == -1) {
      return {-1: 'No scores yet'};
    } else {
      String playerName =
          await PlayersService.instance.getPlayerName(scores.playerId);
      return {scores.score: playerName};
    }
  }

  // print all tables
  Future<void> _printAllTables() async {
    List<PlayerModel> players = await PlayersService.instance.readAllPlayers();
    print(players);
    List<GroupModel> groups = await GroupService.instance.readAllGroups();
    print(groups);
    List<ScoreModel> scores = await ScoresService.instance.readAllScores();
    print(scores);
  }

  @override
  Widget build(BuildContext context) {
    // _printAllTables();
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Scores',
              style: TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontFamily: fontBody,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // show dropdown menu, on selected group show highest score
            FutureBuilder<List<DropdownMenuItem<String>>>(
              future: _buildDropdownMenuItems(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      DropdownButton<String>(
                        value: _selectedGroup,
                        items: snapshot.data,
                        onChanged: (value) {
                          setState(() {
                            _selectedGroup = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      if (_selectedGroup != 'No group')
                        FutureBuilder<Map<int, String>>(
                          future: _getHighestScore(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data!.keys.first == -1) {
                              return const Text(
                                'No scores yet',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: fontBody,
                                ),
                              );
                            } else if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Text(
                                    'Highest score: ${snapshot.data!.keys.first}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontFamily: fontBody,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Highest scorer: ${snapshot.data!.values.first}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontFamily: fontBody,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
