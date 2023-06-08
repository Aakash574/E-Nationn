import 'package:flutter/material.dart';

class HackathonProvider with ChangeNotifier {
  String _teamName = "";
  String _noOfMembers = "";
  String _phoneNo = "";

  String get teamName => _teamName;
  String get noOfMembers => _noOfMembers;
  String get phoneNo => _phoneNo;

  void setTeamName(String teamName) {
    _teamName = teamName;
    notifyListeners();
  }

  void setNoOfMembers(String noOfMembers) {
    _noOfMembers = noOfMembers;
    notifyListeners();
  }

  void setPhoneNo(String phoneNo) {
    _phoneNo = phoneNo;
    notifyListeners();
  }
}
