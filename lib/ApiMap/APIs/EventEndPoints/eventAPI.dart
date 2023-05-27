// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class EventApiClient {
  Uri eventApi = Uri.parse('http://13.232.155.227:8000/account/api/Events/');

  Future<List<dynamic>> getEventDetails() async {
    Response response = await http.get(
      eventApi,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<dynamic> eventDetails = await jsonDecode(response.body);

    return eventDetails;
  }
}
