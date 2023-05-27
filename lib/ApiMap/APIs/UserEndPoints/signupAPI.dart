// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:enationn/ApiMap/Models/SignUpUSerModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class SignUpApiClient {
  //For New User --- >

  Future<Object> registerUser(
    String uId,
    String email,
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
    BuildContext context,
  ) async {
    Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Signup/');

    final requestBody = jsonEncode(
      {
        'uid': uId,
        'email': email,
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
      },
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    log(response.body);

    final signUpKey =
        await SignUpApiClient().getUserDataByEmail(email, 'signupkey');
    log("SignUp key $signUpKey");

    if (response.statusCode == 200) {
      return SignUpUser.fromJson(json.decode(response.body));
    }
    return "User Already Exist";
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
    Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Signup/');
    Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final userData = await jsonDecode(response.body);
    // log(userData.toString());
    for (var i = 0; i < userData.length; i++) {
      if (userData[i]['email'] == email) {
        switch (choose) {
          case 'id':
            return userData[i]['id'].toString();

          case 'email':
            return await userData[i]['email'];

          case 'full_name':
            return userData[i]['full_name'];

          case 'college':
            return userData[i]['college'];

          case 'branch':
            return userData[i]['branch'];

          case 'father_name':
            return userData[i]['father_name'];

          case 'date_of_birth':
            return userData[i]['date_of_birth'];

          case 'year_of_passout':
            return userData[i]['year_of_passout'];

          case 'place_of_birth':
            return userData[i]['place_of_birth'];

          case 'signupkey':
            return userData[i]['signupkey'];

          default:
        }
        // return userData[i]['id'];
      }
    }
    return "0";
    // log(userData[2]['email']);
  }
}
