import 'dart:math';

import 'package:explode/constants/general.dart';
import 'package:explode/utilities/verification_icon.dart';
import 'package:explode/views/record.dart';
import 'package:flutter/material.dart';

class PairExpRes {
  String s;
  int x;

  PairExpRes(this.s, this.x);
}

// widget to present random equations to the user and check if the answer is correct
class ExpressionGenerator extends StatefulWidget {
  const ExpressionGenerator({
    super.key,
    required this.operators,
    required this.difficulty,
  });

  final List<String> operators;
  final String difficulty;

  @override
  State<ExpressionGenerator> createState() => _ExpressionGeneratorState();
}

class _ExpressionGeneratorState extends State<ExpressionGenerator> {
  // variables from the Game class
  late List<String> operators = widget.operators;
  late String difficulty = widget.difficulty;

  // generate random numbers
  final Random number1 = Random();
  final Random number2 = Random();
  // generate random operators
  final Random operator = Random();
  late final TextEditingController _answer = TextEditingController();

  // variables to store the correct answer
  late int correctAnswers = 0;
  late int wrongAnswers = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _answer.dispose();
    super.dispose();
  }

  // increment the number of correct answers
  void incrementCorrect() {
    setState(() {
      correctAnswers++;
    });
  }

  // increment the number of wrong answers
  void incrementWrong() {
    setState(() {
      wrongAnswers++;
    });
  }

  // get the correct answer and wrong answers
  List<PairExpRes> getResults() {
    return <PairExpRes>[
      PairExpRes('Correct', correctAnswers),
      PairExpRes('Wrong', wrongAnswers),
    ];
  }

  // funtion to generate a random equation based on the difficulty and operators
  PairExpRes generateEquation() {
    String equation = '';
    int result = 0;
    switch (difficulty) {
      case '1':
        {
          final int num1 = number1.nextInt(10);
          final int num2 = number2.nextInt(10);
          final int op = operator.nextInt(operators.length);
          equation = '$num1 ${operators[op]} $num2';
          result = calculateResult(num1, num2, operators[op]);
        }
        break;
      case '2':
        {
          final int num1 = number1.nextInt(100);
          final int num2 = number2.nextInt(100);
          final int op = operator.nextInt(operators.length);
          equation = '$num1 ${operators[op]} $num2';
          result = calculateResult(num1, num2, operators[op]);
        }
        break;
      case '3':
        {
          final int num1 = number1.nextInt(1000);
          final int num2 = number2.nextInt(1000);
          final int op = operator.nextInt(operators.length);
          equation = '$num1 ${operators[op]} $num2';
          result = calculateResult(num1, num2, operators[op]);
        }
        break;
      case '4':
        {
          final int num1 = number1.nextInt(10000);
          final int num2 = number2.nextInt(10000);
          final int op = operator.nextInt(operators.length);
          equation = '$num1 ${operators[op]} $num2';
          result = calculateResult(num1, num2, operators[op]);
        }
        break;
    }
    return PairExpRes(equation, result);
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
    if (int.parse(answer) == result) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    PairExpRes pairEquation = generateEquation();
    String equation = pairEquation.s;
    String result = pairEquation.x.toString();

    return Center(
      child: Column(
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
          SizedBox(
            width: 150,
            height: 70,
            child: TextField(
              controller: _answer,
              // keyboard to allow numbers and negative sign and prevent the user from enterging other characters
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: false,
              ),
              // no suggestions
              autocorrect: false,
              // only numbers
              // keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              // autofocus: true,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: fontBody,
              ),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: quaternaryColor,
                    // transparent border
                    width: 0.5,
                  ),
                  // border transparency
                  // borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                // keep border on focus
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: quaternaryColor),
                ),
                // hintText: '?',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: fontBody,
                  // center the hint text
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              // button padding
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              elevation: 15,
            ),
            onPressed: () {
              if (_answer.text.isNotEmpty) {
                if (checkAnswer(result, int.parse(_answer.text))) {
                  _answer.clear();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const VerificationIcon(
                        correct: true,
                      );
                    },
                  );
                  incrementCorrect();
                } else {
                  _answer.clear();
                  incrementWrong();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const VerificationIcon(
                        correct: false,
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
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: tertiaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              // button padding
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              // add shadow to the button
              elevation: 15,
            ),
            onPressed: () {
              _answer.clear();
              setState(() {
                pairEquation = generateEquation();
                equation = pairEquation.s;
                result = pairEquation.x.toString();
              });
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: fontBody,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
