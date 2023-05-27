// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HackathonApiClient {
  Uri hackathonApi =
      Uri.parse('http://13.232.155.227:8000/account/api/Hackathon/');

  Future<List<dynamic>> getHackathonDetails() async {
    Response response = await http.get(
      hackathonApi,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<dynamic> hackathonDetails = await jsonDecode(response.body);

    return hackathonDetails;
  }
}
