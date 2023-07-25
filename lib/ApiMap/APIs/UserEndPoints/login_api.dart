// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:enationn/ApiMap/Models/login_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginApiClient {
  Uri loginURL = Uri.parse('http://13.232.155.227:8000/account/api/Login/');

  Future<dynamic> getAllUsers() async {
    Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Login/');
    Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final userData = json.decode(response.body);

    return userData;
  }

  // Get user Data ---------------------------->

  Future<Map<dynamic, dynamic>> getUserDataById(int id) async {
    Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Login/$id/');
    Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final Map userData = json.decode(response.body);

    return userData;
  }

  Future<String> getUserDataByEmail(String email, String choose) async {
    Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Login/');
    Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final userData = await jsonDecode(response.body);
    for (var i = 0; i < userData.length; i++) {
      if (await userData[i]['email'] == email) {
        return userData[i][choose].toString();
      }
    }
    return "0";
  }

  Future<bool> getUserData(String choose) async {
    Response response = await http.get(
      loginURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final userData = await jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (var i = 0; i < userData.length; i++) {
        if (await userData[i]['email'] == choose) {
          return true;
        }
      }
    }
    return false;
  }

  // User Credential Data Post ------------------------->

  Future loginPostData(
    String email,
    String password,
  ) async {
    Map<String, String> userEPBody = {
      'email': email,
      'password': password,
    };
    Response response = await http.post(
      loginURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userEPBody),
    );
    log(response.body);
    try {
      if (response.statusCode == 201) {
        return Users.fromJson(json.decode(response.body));
      } else {
        return Exception("We Found Some Error");
      }
    } catch (e) {
      return e;
    }
  }

  // <-------------------- Login User --------------------------->

  Future<bool> login(String email, String password) async {
    Response response = await http.get(
      loginURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    List userResponseList = await jsonDecode(response.body);
    log(email.toString());
    for (var i = 0; i < userResponseList.length; i++) {
      if (await userResponseList[i]['email'] == email &&
          await userResponseList[i]['password'] == password) {
        return true;
      }
    }
    return false;
  }

  // <------------- Logout User ------------------->

  Future<void> logoutUser(String token) async {
    final url = Uri.parse('https://your-api.com/logout');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      // Successful logout
    } else {
      // Handle error
    }
  }

  Future<bool> deleteUserCredentials(String id) async {
    log(id);
    Uri signUpApi =
        Uri.parse('http://13.232.155.227:8000/account/api/Login/$id/');

    Response response = await http.delete(signUpApi);

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log("Delete SuccessFully");
      return true;
    }
    return false;
  }
}
