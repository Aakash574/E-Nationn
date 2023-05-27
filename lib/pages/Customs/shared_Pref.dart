// ignore_for_file: file_names, avoid_print, no_leading_underscores_for_local_identifiers
import 'dart:developer';

import 'package:enationn/ApiMap/APIs/UserEndPoints/signupAPI.dart';
import 'package:enationn/Provider/loginProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserCredentials(
  int id,
  String email,
  String password,
  // String branch,
  // String college,
  // String fullName,
  // String signupKey,
  // String fatherName,
  // String dateOfBirth,
  // String placeOfBirth,
  // String yearOfPassout,
  // String internshipStatus,
  // String hackathonStatus,
  // String eventStatus,
  bool isUserLoggedIn,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('id', id);
  await prefs.setString('email', email);
  await prefs.setString('password', password);
  // await prefs.setString('branch', branch);
  // await prefs.setString('college', college);
  // await prefs.setString('full_name', fullName);
  // await prefs.setString('father_name', fatherName);
  // await prefs.setString('date_of_birth', dateOfBirth);
  // await prefs.setString('place_of_birth', placeOfBirth);
  // await prefs.setString('year_of_passout', yearOfPassout);
  // await prefs.setString('signupkey', signupKey);
  // await prefs.setString('internship_status', internshipStatus);
  // await prefs.setString('hackathon_status', hackathonStatus);
  // await prefs.setString('event_status', eventStatus);
  await prefs.setBool('isUserLoggedIn', isUserLoggedIn);
  log(isUserLoggedIn.toString());
}

Future<Map<String, dynamic>> getUserCredentials() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  int? id = prefs.getInt('id');
  // String uId = prefs.getString('uid').toString();
  String email = prefs.getString('email').toString();
  String password = prefs.getString('password').toString();
  // String branch = prefs.getString('branch').toString();
  // String college = prefs.getString('college').toString();
  // String fullName = prefs.getString('full_name').toString();
  // String signupKey = prefs.getString('signupkey').toString();
  // String fatherName = prefs.getString('father_name').toString();
  // String dateOfBirth = prefs.getString('date_of_birth').toString();
  // String placeOfBirth = prefs.getString('place_of_birth').toString();
  // String yearOfPassout = prefs.getString('year_of_passout').toString();
  // String internshipStatus = prefs.getString('internship_status').toString();
  // String hackathonStatus = prefs.getString('hackathon_status').toString();
  // String eventStatus = prefs.getString('event_status').toString();
  // print(email);
  return {
    'id': id,
    //   'uid': uId,
    'email': email,
    //   'branch': branch,
    //   'college': college,
    'password': password,
    //   'full_name': fullName,
    //   'father_name': fatherName,
    //   'date_of_birth': dateOfBirth,
    //   'place_of_birth': placeOfBirth,
    //   'year_of_passout': yearOfPassout,
    //   'signupkey': signupKey,
    //   'internship_status': internshipStatus,
    //   'hackathon_status': hackathonStatus,
    //   'event_status': eventStatus,
  };
}

Future<Map<dynamic, dynamic>> getUserData(int id) async {
  final userData = await SignUpApiClient().getUserDataById(id);
  return userData;
}

Future<bool> getIsUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isUserLoggedIn = prefs.getBool('isUserLoggedIn');

  return isUserLoggedIn ?? false;
}

setUserLoggedIn(bool userLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isUserLoggedIn', userLoggedIn);
}

Future<bool> getShowIntroScreen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? showIntroScreen = prefs.getBool('showIntroScreen');

  return showIntroScreen ?? false;
}

Future<void> setShowIntroScreen(bool showIntroScreen) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('showIntroScreen', showIntroScreen);
}

Future<bool> authenticateUser(
    BuildContext context, String email, String password) async {
  final model = Provider.of<LoginScreenModel>(context, listen: false);
  String _email = model.email;
  String _password = model.password;
  // Simulate an authentication process by checking if the email and password match
  log("email $email password $password ");
  if (email == _email && password == _password) {
    return true; // The user is authenticated
  } else {
    return false; // The user is not authenticated
  }
}
