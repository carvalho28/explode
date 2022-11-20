import 'package:explode/constants/general.dart';
import 'package:explode/constants/routes.dart';
import 'package:explode/services/crud/group_service.dart';
import 'package:explode/services/crud/players_service.dart';
import 'package:explode/views/difficulty.dart';
import 'package:flutter/material.dart';

class GroupChoice extends StatefulWidget {
  const GroupChoice({super.key});

  @override
  State<GroupChoice> createState() => _GroupChoiceState();
}

class _GroupChoiceState extends State<GroupChoice> {
  // read groups from database
  Future<List<String>> readGroups() async {
    List<String> groups = [];
    groups = await GroupService.instance.readAllGroupNames();
    if (groups.isEmpty) {
      groups = [];
    }
    return groups;
  }

  String? _selectedGroup = 'No group';
  int _selectedGroupId = -1;
  // controller for the dropdown menu
  final TextEditingController _groupController = TextEditingController();
  // DropdownMenuItem(
  //   value: 'No group',
  //   child: Text('No group'),
  // );

  // read groups and create dropdown menu
  Future<List<DropdownMenuItem<String>>> get dropdownItems async {
    List<DropdownMenuItem<String>> menuItems = [];
    // add the 'No group' option
    menuItems.add(
      const DropdownMenuItem(
        value: 'No group',
        child: Text('No group'),
      ),
    );
    List<String> groups = await readGroups();
    if (groups.isEmpty) {
      menuItems = [];
    } else {
      for (int i = 0; i < groups.length; i++) {
        menuItems.add(
          DropdownMenuItem(
            value: groups[i],
            child: Text(groups[i]),
          ),
        );
      }
    }
    return menuItems;
  }

  // // get group id from the group name
  // Future<int> getGroupId(String groupName) async {
  //   int groupId = -1;
  //   groupId = await GroupService.instance.getGroupId(groupName);
  //   return groupId;
  // }

  // // get playersName from group using group id
  // Future<List<String>> getPlayersName(int groupId) async {
  //   if (groupId == -1) {
  //     return [];
  //   } else {
  //     List<String> playersName = [];
  //     playersName = await PlayersService.instance.readPlayersName(groupId);
  //     return playersName;
  //   }
  // }

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
            // align center
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Choose Group',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // dropdown menu
              FutureBuilder(
                future: dropdownItems,
                builder: (BuildContext context,
                    AsyncSnapshot<List<DropdownMenuItem<String>>> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        DropdownButton(
                          value: _selectedGroup,
                          items: snapshot.data,
                          onChanged: (value) {
                            setState(() {
                              _selectedGroup = value.toString();
                              _groupController.text = _selectedGroup!;
                            });
                            print(_selectedGroup);
                            print(_selectedGroupId);
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
                        // if selected group is not 'No group', show the group players
                        if (_selectedGroup != 'No group')
                          FutureBuilder(
                            future: GroupService.instance
                                .getGroupId(_selectedGroup!),
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              if (snapshot.hasData) {
                                _selectedGroupId = snapshot.data!;
                                return FutureBuilder(
                                  future: PlayersService.instance
                                      .readPlayersName(_selectedGroupId),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<String>> snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            'Players in the group:',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: fontBody,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          // show players name
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return Column(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        // in the middle of the screen
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    child: Text(
                                                      '• ${snapshot.data![i]}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontFamily: fontBody,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          const SizedBox(
                                            height: 80,
                                          ),
                                          // start game button
                                          ElevatedButton(
                                            onPressed: () {
                                              // go to game
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: secondaryColor,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 50,
                                                vertical: 20,
                                              ),
                                              // add shadow to the button
                                              elevation: 15,
                                            ),
                                            child: const Text('Start Game',
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontFamily: fontBody,
                                                )),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    }
                                  },
                                );
                              } else {
                                return const CircularProgressIndicator(
                                  color: Colors.white,
                                );
                              }
                            },
                          ),
                        const SizedBox(
                          height: 50,
                        ),
                        // button for new group
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(playersChoiceRoute);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: tertiaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              // button padding
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              // add shadow to the button
                              elevation: 15,
                            ),
                            child: const Text(
                              'New Group',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: fontBody,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // text saying there are no groups created yet and a button to create a group
                    return Column(
                      children: [
                        const Text(
                          'No groups created yet',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: fontBody,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {},
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
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
      ),
    );
  }
}
