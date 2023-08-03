import 'package:flutter/material.dart';

class BasicVariableModel extends ChangeNotifier {
  int _index = 0;
  String _whichScreen = "";
  String _jobCode = "";
  String _verificationCode = "";
  String _plan = "";
  bool _isActive = false;

  int get index => _index;
  bool get isActive => _isActive;
  String get whichScreen => _whichScreen;
  String get plan => _plan;
  String get jobCode => _jobCode;
  String get verificationCode => _verificationCode;

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

  void setDashboardIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void setJobCode(String jobCode) {
    _jobCode = jobCode;
    notifyListeners();
  }

  void setVerificationCode(String verificationCode) {
    _verificationCode = verificationCode;
    notifyListeners();
  }
}
