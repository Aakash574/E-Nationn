import 'package:flutter/material.dart';

class BasicVariableModel extends ChangeNotifier {
  String _whichScreen = "";
  String _plan = "";
  bool _isActive = false;

  bool get isActive => _isActive;
  String get whichScreen => _whichScreen;
  String get plan => _plan;

  void setWhichScreen(String screen) {
    _whichScreen = screen;
    notifyListeners();
  }

  void setPlanIsActive(bool isActive) {
    _isActive = isActive;
    notifyListeners();
  }

  void setPlan(String plan) {
    _plan = plan;
    notifyListeners();
  }
}
