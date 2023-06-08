// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';

class HackathonDetailProvider extends ChangeNotifier {
  String _name = '';
  String _hackathonDate = '';
  String _hackathonLastDate = '';
  String _charge = '';
  String _applyStatus = '';

  String get name => _name;
  String get hackathonDate => _hackathonDate;
  String get hackathonLastDate => _hackathonLastDate;
  String get charge => _charge;
  String get applyStatus => _applyStatus;

  void setName(String name) {
    _name = name;
    log(_name);
    notifyListeners();
  }

  void sethackathonDate(String hackathonDate) {
    _hackathonDate = hackathonDate;
    notifyListeners();
  }

  void sethackathonLastDate(String hackathonLastDate) {
    _hackathonLastDate = hackathonLastDate;
    notifyListeners();
  }

  void setCharge(String charge) {
    _charge = charge;
    notifyListeners();
  }

  void setApplyStatus(String applyStatus) {
    _applyStatus = applyStatus;
    notifyListeners();
  }
}
