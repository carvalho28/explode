import 'package:flutter/material.dart';

class Answers with ChangeNotifier {
  int _correctAnswers = 0;
  int _wrongAnswers = 0;

  int get correctAnswers => _correctAnswers;
  int get wrongAnswers => _wrongAnswers;

  void incrementCorrect() {
    _correctAnswers++;
    notifyListeners();
  }

  void incrementWrong() {
    _wrongAnswers++;
    notifyListeners();
  }

  void resetCorrect() {
    _correctAnswers = 0;
    notifyListeners();
  }

  void resetWrong() {
    _wrongAnswers = 0;
    notifyListeners();
  }
}
