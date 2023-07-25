// ignore_for_file: use_build_context_synchronously, file_names, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:enationn/ApiMap/APIs/UserEndPoints/login_api.dart';
import 'package:enationn/ApiMap/Models/signup_user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class SignUpApiClient {
  //For New User --- >

  Future<Object> registerUser(
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
    BuildContext context,
  ) async {
    Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Signup/');

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
      },
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    // log(response.body);
    log("All Users ::: ${response.body}");

    final signUpKey =
        await SignUpApiClient().getUserDataByEmail(email, 'signupkey');
    log("SignUp key $signUpKey");

    if (response.statusCode == 200) {
      return SignUpUser.fromJson(json.decode(response.body));
    }
    return "User Already Exist";
  }

  Future<List<dynamic>> getUsers() async {
    Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Signup/');
    Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final userData = json.decode(response.body);
    // log("UserData :: $userData");
    return userData;
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

    final Map userData = json.decode(response.body);

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
    // log("Email Sign Up : $email");
    // log("Choose Sign Up : $choose");
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
        // Password update successful
        print('Details updated successfully');
        return true;
      } else {
        // Password update failed
        print('Details update failed');
        return false;
        // Handle the error response or show an appropriate error message
      }
    } catch (e) {
      // An error occurred
      print('Error: $e');
      return false;
      // Handle the error and show an appropriate error message
    }
  }

  Future<bool> updatePassword(
    String newPassword,
    String userId,
    String email,
  ) async {
    final loginId = await LoginApiClient().getUserDataByEmail(email, 'id');
    log(loginId);
    final signUpUrl =
        Uri.parse('http://13.232.155.227:8000/account/api/Signup/$userId/');
    final loginUrl =
        Uri.parse('http://13.232.155.227:8000/account/api/Login/$loginId/');

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
      final loginResponse = await http.patch(
        loginUrl,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      log(loginResponse.body);
      log(signUpResponse.body);

      if (signUpResponse.statusCode == 200 && loginResponse.statusCode == 200) {
        // Password update successful
        print('Password updated successfully');
        return true;
      } else {
        // Password update failed
        print('Password update failed');
        return false;
        // Handle the error response or show an appropriate error message
      }
    } catch (e) {
      // An error occurred
      print('Error: $e');
      return false;
      // Handle the error and show an appropriate error message
    }
  }

  Future<bool> deleteUser(String id) async {
    log(id);
    Uri signUpApi =
        Uri.parse('http://13.232.155.227:8000/account/api/Signup/$id/');

    Response response = await http.delete(signUpApi);

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log("Delete SuccessFully");
      return true;
    }
    return false;
  }
}
