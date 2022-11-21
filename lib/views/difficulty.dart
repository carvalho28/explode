import 'package:explode/constants/general.dart';
import 'package:explode/views/game.dart';
import 'package:flutter/material.dart';

class Difficulty extends StatefulWidget {
  const Difficulty({
    super.key,
  });

  @override
  State<Difficulty> createState() => _DifficultyState();
}

class _DifficultyState extends State<Difficulty> {
  // list with all operators
  final List<String> operators = <String>['+', '-', '*', '/'];
  // list with all difficulties
  final List<String> difficulties = <String>['1', '2', '3', '4'];
  // list with all possible times
  final List<String> times = <String>['20', '60', '90', '120'];

  // selected operators
  List<String> selectedOperators = <String>[];
  // selected difficulty
  String selectedDifficulty = '';
  // selected time
  String selectedTime = '';

  @override
  void initState() {
    selectedOperators.add(operators[0]);
    selectedOperators.add(operators[1]);
    selectedDifficulty = difficulties[0];
    selectedTime = times[0];
    super.initState();
  }

  // function to check if the user selected at least one operator
  bool checkOperators() {
    if (selectedOperators.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // scaffold for user to choose the difficulty and the operators
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            //  text with choose operations
            const Text(
              'Operations:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: fontBody,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              // color
              children: operators
                  .map(
                    (String operator) => Container(
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedOperators.contains(operator)
                              ? secondaryColor
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 20,
                          ),
                          // add shadow to the button
                          elevation: 15,
                        ),
                        onPressed: () {
                          // if the operator is already selected, remove it from the list unless there is only one operator selected
                          if (selectedOperators.contains(operator) &&
                              selectedOperators.length > 1) {
                            setState(() {
                              selectedOperators.remove(operator);
                            });
                          } else {
                            // if the operator is not selected, add it to the list if not there
                            if (!selectedOperators.contains(operator)) {
                              setState(() {
                                selectedOperators.add(operator);
                              });
                            }
                          }
                          setState(() {});
                          print(selectedOperators);
                        },
                        child: Text(
                          operator,
                          style: TextStyle(
                            color: selectedOperators.contains(operator)
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                            fontFamily: fontBody,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Difficulty:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: fontBody,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // difficulty choice using stars
            Wrap(
              // force one to be selected
              children: difficulties
                  .map(
                    (String difficulty) => Container(
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedDifficulty == difficulty
                              ? secondaryColor
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 20,
                          ),
                          // add shadow to the button
                          elevation: 15,
                        ),
                        onPressed: () {
                          // set the selected difficulty
                          selectedDifficulty = difficulty;
                          // update the state
                          setState(() {});
                          print(selectedDifficulty);
                        },
                        child: Text(
                          difficulty,
                          style: TextStyle(
                            color: selectedDifficulty == difficulty
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                            fontFamily: fontBody,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 50,
            ),
            // time choice
            const Text(
              'Time:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: fontBody,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // time choice
            Wrap(
              // force one to be selected
              children: times
                  .map(
                    (String time) => Container(
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedTime == time
                              ? secondaryColor
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 20,
                          ),
                          // add shadow to the button
                          elevation: 15,
                        ),
                        onPressed: () {
                          // set the selected time
                          selectedTime = time;
                          // update the state
                          setState(() {});
                          print(selectedTime);
                        },
                        child: Text(
                          time,
                          style: TextStyle(
                            color: selectedTime == time
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                            fontFamily: fontBody,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 50,
            ),
            // button to start the game
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
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
                print('start game');
                print(selectedOperators);
                print(selectedDifficulty);
                print(selectedTime);
                if (selectedOperators.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content:
                            const Text('Please select at least one operator'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else if (selectedDifficulty.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a difficulty'),
                    ),
                  );
                } else if (selectedTime.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a time'),
                    ),
                  );
                }
                // if the user selected at least one operator and a difficulty
                if (checkOperators() &&
                    selectedDifficulty != '' &&
                    selectedTime != '') {
                  // navigate to the game page without button to go back
                  selectedOperators.sort();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Game(
                        operators: selectedOperators,
                        difficulty: selectedDifficulty,
                        time: selectedTime,
                      ),
                    ),
                    (route) => false,
                  );
                }
              },
              child: const Text(
                'Start',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
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
