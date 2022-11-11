import 'package:flutter/material.dart';

class EndTimer with ChangeNotifier {
  bool _endTimer = false;

  bool get endTimer => _endTimer;

  void changeEndTimer(bool value) {
    _endTimer = value;
    notifyListeners();
  }
}
