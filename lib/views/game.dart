import 'dart:math';

import 'package:explode/constants/general.dart';
import 'package:explode/utilities/timer.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class Pair {
  String s;
  int x;

  Pair(this.s, this.x);
}

// widget to present random equations to the user and check if the answer is correct
class ExpressionGenerator extends StatefulWidget {
  const ExpressionGenerator({super.key});

  @override
  State<ExpressionGenerator> createState() => _ExpressionGeneratorState();
}

class _ExpressionGeneratorState extends State<ExpressionGenerator> {
  // list of all the possible operators
  final List<String> operators = <String>['+', '-', '*', '/'];
  // generate random numbers between 0 and 10
  final Random number1 = Random();
  final Random number2 = Random();
  // generate random operators
  final Random operator = Random();
  late final TextEditingController _answer = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _answer.dispose();
    super.dispose();
  }

  // function to generate random equation
  Pair generateEquation() {
    // generate random numbers between 0 and 10
    final int num1 = number1.nextInt(10);
    final int num2 = number2.nextInt(10);
    // generate random operator
    final String op = operators[operator.nextInt(4)];

    final String expression = '$num1 $op $num2';

    // if division by zero, generate new equation
    if (op == '/' && num2 == 0) {
      return generateEquation();
    }

    // get the result of the equation
    final int result = calculateResult(num1, num2, op);

    return Pair(expression, result);
  }

  // function to calculate the result of the equation
  int calculateResult(int num1, int num2, String op) {
    int result = 0;
    switch (op) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 ~/ num2;
        break;
    }
    return result;
  }

  // function to check if the answer is correct
  bool checkAnswer(String answer, int result) {
    print('answer: $answer');
    print('result: $result');
    if (int.parse(answer) == result) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Pair pairEquation = generateEquation();
    String equation = pairEquation.s;
    String result = pairEquation.x.toString();
    return Column(
      children: [
        Text(
          equation,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontFamily: fontBody,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        TextField(
          controller: _answer,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: fontBody,
          ),
          decoration: const InputDecoration(
            hintText: 'Enter your answer',
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
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
              borderRadius: BorderRadius.circular(32.0),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 20,
            ),
            // add shadow to the button
            elevation: 15,
          ),
          onPressed: () {
            if (_answer.text.isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Please enter an answer'),
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
            }
            if (_answer.text.isNotEmpty) {
              if (checkAnswer(result, int.parse(_answer.text))) {
                _answer.clear();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Correct!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: fontBody,
                        ),
                      ),
                      backgroundColor: correctColor,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: fontBody,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
                setState(() {
                  pairEquation = generateEquation();
                  equation = pairEquation.s;
                  result = pairEquation.x.toString();
                });
              } else {
                _answer.clear();
                // pretty alert to show the user that the answer is wrong
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Wrong!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: fontBody,
                        ),
                      ),
                      backgroundColor: incorrectColor,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: fontBody,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            }
          },
          child: const Text(
            'Check',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: fontBody,
            ),
          ),
        ),
      ],
    );
  }
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // invisible app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const TimerWidget(startingTime: 5),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 80,
            ),
            child: const ExpressionGenerator(),
          ),
        ],
      ),
    );
  }
}
