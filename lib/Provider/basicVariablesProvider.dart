// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BasicVariableModel extends ChangeNotifier {
  String _whichScreen = "";

  String get whichScreen => _whichScreen;

  void setWhichScreen(String screen) {
    _whichScreen = screen;
    notifyListeners();
  }
}
