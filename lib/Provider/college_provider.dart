import 'package:flutter/widgets.dart';

class CollegeProvier extends ChangeNotifier {
  List _colleges = [];

  List get colleges => _colleges;

  void setColleges(List colleges) {
    _colleges = colleges;
    notifyListeners();
  }
}
