// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HackathonRepository {
  Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Hackathon/');

  List<dynamic> hackathonDetails = [];

  Future<List<dynamic>> getHackathonDetails() async {
    Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      hackathonDetails = await jsonDecode(response.body);
    }
    return hackathonDetails;
  }
}
