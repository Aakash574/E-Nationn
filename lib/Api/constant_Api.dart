// ignore_for_file: file_names, control_flow_in_finally, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:enationn/Api/Models/LoginUserModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiClient {
  // <-------------------------- Constant Variables --------------------->
  Uri signUpURL = Uri.parse('http://13.232.155.227:8000/account/api/Signup/');
  Uri loginURL = Uri.parse('http://13.232.155.227:8000/account/api/Login/');
  Uri passKeyURL = Uri.parse('http://13.232.155.227:8000/account/api/Passkey/');

  // <--------------------- Register User ---------------------->

  Future<Object?> registerUser(
    String fullName,
    String email,
    String password,
    String fatherName,
    String college,
    String branch,
    String yearOfPassout,
    String dateOfBirth,
    String placeOfBirth,
  ) async {
    Map<String, String> userJsonBody = {
      'full_name': fullName,
      'email': email,
      'password': password,
      'father_name': fatherName,
      'college': college,
      'branch': branch,
      'year_of_passout': yearOfPassout,
      'date_of_birth': dateOfBirth,
      'place_of_birth': placeOfBirth,
    };

    Response response = await http.post(
      signUpURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userJsonBody),
    );
    log(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      if (await ApiClient().getUserData(email) != true) {
        log(response.body);
        return Users.fromJson(json.decode(response.body));
      }
    }
    return "User Already Exist";
  }

  // <------------------------ User Credential Data Post ------------------------->

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

  // <---------------------- Get user Data ---------------------------->

  Future<bool> getUserData(String email) async {
    Response response = await http.get(
      loginURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    List userData = await jsonDecode(response.body);
    log(response.statusCode.toString());
    log("email : $email");
    if (response.statusCode == 200) {
      for (var i = 0; i < userData.length; i++) {
        // log(await userData[i]['email']);
        if (await userData[i]['email'] == email) {
          log("Email Come Form API : " + await userData[i]['email']);
          return true;
        }
      }
    }
    return false;
  }

  //  <---------------------- Create Pass Key ---------------------------->

  Future createPassKey(String pinCode) async {
    Response response = await http.post(
      passKeyURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'passkey': pinCode,
      }),
    );
    log(response.body);
    if (response.statusCode == 200) {
      return await json.decode(response.body);
    } else {
      return Exception("Enter Full Password");
    }
  }

  // <-------------------------- Pass Key ------------------------->

  Future<bool> passkey(String pinCode) async {
    Response response = await http.get(
      passKeyURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    log(response.body);

    List passkeys = await jsonDecode(response.body);
    log(pinCode);
    for (var i = 0; i < passkeys.length; i++) {
      if (pinCode == await passkeys[i]['passkey']) {
        log(
          "API Passkey: " + passkeys[i]['Apply_status'],
        );
        return true;
      }
    }

    return false;
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
    for (var i = 0; i < userResponseList.length; i++) {
      if (await userResponseList[i]['email'] == email &&
          await userResponseList[i]['password'] == password) {
        return true;
      }
    }
    return false;
  }

  //-------------------------Get User Data----------------------->

  Future<String> getSpecificUserDetails(
    String email,
    String choose,
  ) async {
    Response response = await http.get(
      signUpURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    List userData = jsonDecode(response.body);
    for (var i = 0; i < userData.length; i++) {
      if (email == await userData[i]['email']) {
        log(await userData[i]['full_name']);
        switch (choose) {
          case 'name':
            return await userData[i]['full_name'];
          case 'email':
            return await userData[i]['full_name'];
          case 'father_name':
            return await userData[i]['full_name'];
          case 'college':
            return await userData[i]['full_name'];
          case 'branch':
            return await userData[i]['full_name'];
          case 'year_of_passout':
            return await userData[i]['full_name'];
          case 'date_of_birth':
            return await userData[i]['full_name'];
          case 'place_of_birth':
            return await userData[i]['full_name'];
        }
      }
    }
    return "NotFound";
  }
}
