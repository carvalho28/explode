import 'package:explode/constants/general.dart';
import 'package:explode/views/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Difficulty extends StatefulWidget {
  const Difficulty({super.key});

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
        backgroundColor: Colors.transparent,
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
            // list of all operators
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
                          // if the operator is already selected, remove it
                          if (selectedOperators.contains(operator)) {
                            selectedOperators.remove(operator);
                          } else {
                            // if the operator is not selected, add it
                            selectedOperators.add(operator);
                          }
                          // update the state
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
              // color
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
                          // if the difficulty is already selected, remove it
                          if (selectedDifficulty == difficulty) {
                            selectedDifficulty = '';
                          } else {
                            // if the difficulty is not selected, add it
                            selectedDifficulty = difficulty;
                          }
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
              // color
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
                          // if the time is already selected, remove it
                          if (selectedTime == time) {
                            selectedTime = '';
                          } else {
                            // if the time is not selected, add it
                            selectedTime = time;
                          }
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
                if (checkOperators() && selectedDifficulty != '') {
                  // navigate to the game page
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Game(
                        operators: selectedOperators,
                        difficulty: selectedDifficulty,
                        time: selectedTime,
                      ),
                    ),
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
