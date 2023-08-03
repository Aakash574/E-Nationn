import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../../domain/models/userModels/user_model.dart';

class UserRepository {
  Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Signup/');

  Future<UserModel> userRegisterRepository(
    String uId,
    String email,
    String gender,
    String branch,
    String college,
    String password,
    String fullName,
    String signupKey,
    String fatherName,
    String dateOfBirth,
    String placeOfBirth,
    String yearOfPassout,
    String internshipStatus,
    String hackathonStatus,
    String eventStatus,
    String contact,
    String state,
    BuildContext context,
  ) async {
    final requestBody = jsonEncode(
      {
        'uid': uId,
        'email': email,
        'gender': gender,
        'branch': branch,
        'college': college,
        'password': password,
        'full_name': fullName,
        'father_name': fatherName,
        'date_of_birth': dateOfBirth,
        'place_of_birth': placeOfBirth,
        'year_of_passout': yearOfPassout,
        'signupkey': signupKey,
        'internship_status': internshipStatus,
        'hackathon_status': hackathonStatus,
        'event_status': eventStatus,
        'contact': contact,
        'state': state,
      },
    );

    log(requestBody.toString());

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<dynamic>> getUsers() async {
    Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Signup/');
    Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return ["No Found"];
    }
  }

  // Get Specific Data of User -->

  Future<Map<dynamic, dynamic>> getUserDataById(int id) async {
    Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Signup/$id/');
    Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final Map userData = jsonDecode(response.body);
    return userData;
  }

  Future<String> getUserDataByEmail(String email, String choose) async {
    // log("Getting User Data By Email :::: ");

    Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Signup/');
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
    return "Id Not Found";
  }

  Future<bool> updateDetails(
    String key,
    String value,
    String userId,
    String email,
  ) async {
    log("Key : $key,\nValue : $value,\nUserId : $userId,\nEmail : $email,");
    final signUpUrl =
        Uri.parse('http://13.232.155.227:8000/account/api/Signup/$userId/');

    // Create the request body as a JSON object
    final requestBody = jsonEncode({
      key: value,
    });

    try {
      final signUpResponse = await http.patch(
        signUpUrl,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      log(signUpResponse.body);

      if (signUpResponse.statusCode == 200) {
        log("Update State");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePassword(
    String newPassword,
    String userId,
    String email,
  ) async {
    final signUpUrl =
        Uri.parse('http://13.232.155.227:8000/account/api/Signup/$userId/');

    // Create the request body as a JSON object
    final requestBody = jsonEncode({
      'password': newPassword,
    });

    try {
      final signUpResponse = await http.patch(
        signUpUrl,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      log(signUpResponse.body);

      if (signUpResponse.statusCode == 200) {
        print('Password updated successfully');
        return true;
      } else {
        print('Password update failed');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> getUserData(String email) async {
    Uri signUpApi = Uri.parse('http://13.232.155.227:8000/account/api/Signup/');

    Response response = await http.get(
      signUpApi,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final userData = await jsonDecode(response.body);

    if (response.statusCode == 200) {
      log("Getting User Data .........");
      for (var i = 0; i < userData.length; i++) {
        if (userData[i]['email'] == email) {
          log("UserFounded");
          return true;
        }
      }
    } else {
      log("User Not Found");
    }
    return false;
  }

  // --------- Login ------------------>

  Future<bool> login(String email, String password) async {
    Uri signUpApi = Uri.parse('http://13.232.155.227:8000/account/api/Signup/');
    Response response = await http.get(
      signUpApi,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List userResponseList = await json.decode(response.body);

    if (response.statusCode == 200) {
      log("Status Code :: ${response.statusCode}");
      for (var i = 0; i < userResponseList.length; i++) {
        if (userResponseList[i]['email'] == email &&
            userResponseList[i]['password'] == password) {
          return true;
        }
      }
    }
    return false;
  }
}
