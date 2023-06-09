// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserHackathonApiClient {
  Future<bool> hackathonRegistration(
    String hackathonName,
    String teamLeader,
    String email,
    String teamName,
    String noOfMembers,
    String phone,
    String applyStatus,
    String uniqueId,
  ) async {
    Uri url =
        Uri.parse('http://13.232.155.227:8000/account/api/Hackathon_account/');

    final requestBody = jsonEncode(
      {
        'hackathon_name': hackathonName,
        'team_name': teamName,
        'no_of_members': noOfMembers,
        'team_leader': teamLeader,
        'phone': phone,
        'email': email,
        'apply_status': applyStatus,
        'uniqueid': uniqueId,
      },
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    log("Registration : ${response.body}");

    log("Event Registration : ${response.statusCode.toString()}");
    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  Future<dynamic> getUserHackathonDetails() async {
    Uri url =
        Uri.parse('http://13.232.155.227:8000/account/api/Hackathon_account/');
    Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<dynamic> userHackathonData = await json.decode(response.body);

    return userHackathonData;
  }
}
