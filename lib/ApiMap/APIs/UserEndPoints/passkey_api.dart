// ignore_for_file: prefer_interpolation_to_compose_strings, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PasskeyApiClient {
// <-------------------------- Constant Variables --------------------->

  Uri passKeyURL = Uri.parse('http://13.232.155.227:8000/account/api/Passkey/');

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
}
