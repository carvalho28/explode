import 'package:flutter/material.dart';

class Answers with ChangeNotifier {
  int _correctAnswers = 0;
  int _wrongAnswers = 0;

  int get correctAnswers => _correctAnswers;
  int get wrongAnswers => _wrongAnswers;

  void incrementCorrect() {
    _correctAnswers++;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void incrementWrong() {
    _wrongAnswers++;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void resetCorrect() {
    _correctAnswers = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void resetWrong() {
    _wrongAnswers = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
