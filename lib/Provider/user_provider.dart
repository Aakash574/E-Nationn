// ignore_for_file: file_names

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _id = '';
  String _fullName = '';
  String _email = '';
  String _password = '';
  String _fatherName = '';
  String _college = '';
  String _branch = '';
  String _yearOfPassout = '';
  String _dateOfBirth = '';
  String _placeOfBirth = '';
  String _uId = '';
  String _internshipStatus = '';
  String _eventStatus = '';
  String _hackathonStatus = '';
  String _signupkey = '';
  String _applyStatus = '';
  String _planStatus = '';

  String get id => _id;
  String get fullName => _fullName;
  String get email => _email;
  String get password => _password;
  String get fatherName => _fatherName;
  String get college => _college;
  String get branch => _branch;
  String get yearOfPassout => _yearOfPassout;
  String get dateOfBirth => _dateOfBirth;
  String get placeOfBirth => _placeOfBirth;
  String get uId => _uId;
  String get internshipStatus => _internshipStatus;
  String get eventStatus => _eventStatus;
  String get hackathonStatus => _hackathonStatus;
  String get signupkey => _signupkey;
  String get applyStatus => _applyStatus;
  String get planStatus => _planStatus;

  void setID(String id) {
    _id = id;
    notifyListeners();
  }

  void setFullName(String fullName) {
    _fullName = fullName;
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

  void setFatherName(String fatherName) {
    _fatherName = fatherName;
    notifyListeners();
  }

  void setCollege(String college) {
    _college = college;
    notifyListeners();
  }

  void setBranch(String branch) {
    _branch = branch;
    notifyListeners();
  }

  void setYearOfPassout(String yearOfPassout) {
    _yearOfPassout = yearOfPassout;
    notifyListeners();
  }

  void setDateOfBirth(String dateOfBirth) {
    _dateOfBirth = dateOfBirth;
    notifyListeners();
  }

  void setPlaceOfBirth(String placeOfBirth) {
    _placeOfBirth = placeOfBirth;
    notifyListeners();
  }

  void setUID(String uId) {
    _uId = uId;
    notifyListeners();
  }

  void setEventStatus(String eventStatus) {
    _eventStatus = eventStatus;
    notifyListeners();
  }

  void setInternshipStatus(String internshipStatus) {
    _internshipStatus = internshipStatus;
    notifyListeners();
  }

  void setHackathonStatus(String hackathonStatus) {
    _hackathonStatus = hackathonStatus;
    notifyListeners();
  }

  void setSignupKey(String signupkey) {
    _signupkey = signupkey;
    notifyListeners();
  }

  void setApplyStatus(String applyStatus) {
    _applyStatus = applyStatus;
    notifyListeners();
  }

  void setPlanStatus(String planStatus) {
    _planStatus = planStatus;
    notifyListeners();
  }
}
