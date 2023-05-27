// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LoginScreenModel extends ChangeNotifier {
  int _id = 0;
  String _token = '';
  String _email = '';
  String _password = '';

  int get id => _id;
  String get token => _token;
  String get email => _email;
  String get password => _password;

  void setId(int id) {
    _id = id;
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }
}
