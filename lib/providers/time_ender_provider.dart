import 'package:flutter/material.dart';

class EndTimer with ChangeNotifier {
  bool _endTimer = false;

  bool get endTimer => _endTimer;

  void changeEndTimer(bool value) {
    _endTimer = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void resetEndTimer() {
    _endTimer = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
