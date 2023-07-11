// ignore_for_file: file_names

import 'dart:developer';
import 'package:enationn/ApiMap/APIs/UserEndPoints/signup_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void> saveUserCredentials(
    String id,
    String email,
    String password,
    bool isUserLoggedIn,
  ) async {
    log("Getting User Credentials.....");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('isUserLoggedIn', isUserLoggedIn);
  }

  Future<Map<String, dynamic>> getUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String id = prefs.getString('id').toString();
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
    String email,
    String password,
  ) async {
    log("User AuthenticateUser :: ");

    final id = await SignUpApiClient().getUserDataByEmail(email, 'id');
    final userData = await SignUpApiClient().getUserDataById(int.parse(id));
    log("ID :: $id");

    // Simulate an authentication process by checking if the email and password match
    log("Email :: $email \nPassword :: $password ");

    if (email == userData['email'] && password == userData['password']) {
      return true; // The user is authenticated
    } else {
      return false; // The user is not authenticated
    }
  }
}
