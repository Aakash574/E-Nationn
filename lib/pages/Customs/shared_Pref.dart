// ignore_for_file: file_names

import 'dart:developer';
import 'package:enationn/ApiMap/APIs/UserEndPoints/signup_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void> saveUserCredentials(
    int id,
    String email,
    String password,
    bool isUserLoggedIn,
  ) async {
    log("Getting User Credentials.....");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', id);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('isUserLoggedIn', isUserLoggedIn);
    log(isUserLoggedIn.toString());
  }

  Future<Map<String, dynamic>> getUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt('id');
    String email = prefs.getString('email').toString();
    String password = prefs.getString('password').toString();
    return {
      'id': id,
      'email': email,
      'password': password,
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
    BuildContext context,
    String email,
    String password,
  ) async {
    // final model = Provider.of<UserProvider>(context, listen: false);
    final id = await SignUpApiClient().getUserDataByEmail(email, 'id');
    final userData = await SignUpApiClient().getUserDataById(int.parse(id));
    log(userData['email']);

    // Simulate an authentication process by checking if the email and password match
    log("email $email password $password ");

    if (email == userData['email'] && password == userData['password']) {
      return true; // The user is authenticated
    } else {
      return false; // The user is not authenticated
    }
  }
}
