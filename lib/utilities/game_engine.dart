import 'dart:math';
import 'package:explode/constants/general.dart';
import 'package:explode/providers/answers_provider.dart';
import 'package:explode/utilities/verification_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    required this.skipEnabled,
  });

  final List<String> operators;
  final String difficulty;
  final bool skipEnabled;

  @override
  State<ExpressionGenerator> createState() => _ExpressionGeneratorState();
}

class _ExpressionGeneratorState extends State<ExpressionGenerator> {
  // variables from the Game class
  late List<String> operators = widget.operators;
  late String difficulty = widget.difficulty;
  late bool skipEnabled = widget.skipEnabled;

  // generate random numbers
  final Random number1 = Random();
  final Random number2 = Random();
  // generate random operators
  final Random operator = Random();
  late final TextEditingController _answer = TextEditingController();

  @override
  void initState() {
    // print('initState game_engine.dart');
    // Provider.of<Answers>(context, listen: false).resetCorrect();
    // Provider.of<Answers>(context, listen: false).resetWrong();
    super.initState();
  }

  @override
  void dispose() {
    _answer.dispose();
    super.dispose();
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
        if (num2 == 0) {
          return calculateResult(num1, number2.nextInt(100), op);
        }
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

    // print('refreshing game_engine.dart');

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
              autocorrect: false,
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
            height: 15,
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
              if (_answer.text.isNotEmpty &&
                  RegExp(r'^-?[0-9]+$').hasMatch(_answer.text)) {
                if (checkAnswer(result, int.parse(_answer.text))) {
                  _answer.clear();
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return const VerificationIcon(
                          correct: true,
                        );
                      },
                    ),
                  );
                  const VerificationIcon(correct: true);
                  Provider.of<Answers>(context, listen: false)
                      .incrementCorrect();
                } else {
                  _answer.clear();
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return const VerificationIcon(
                          correct: false,
                        );
                      },
                    ),
                  );
                  Provider.of<Answers>(context, listen: false).incrementWrong();
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
          // if skipEnabled is true, show the skip button else show an empty container
          if (skipEnabled)
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
                pairEquation = generateEquation();
                equation = pairEquation.s;
                result = pairEquation.x.toString();
                // new equation
                print('new equation: $equation');
                setState(() {});
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
          if (!skipEnabled) const SizedBox.shrink(),
        ],
      ),
    );
  }
}
