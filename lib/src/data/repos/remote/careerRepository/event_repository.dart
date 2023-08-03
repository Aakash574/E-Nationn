// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class EventRepository {
  Future<List<dynamic>> getEventDetails() async {
    Uri urls = Uri.parse('http://13.232.155.227:8000/account/api/Events/');
    try {
      Response response = await http.get(
        urls,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      List<dynamic> eventDetails = await jsonDecode(response.body);
      return eventDetails;
    } catch (e) {
      return ["Error $e"];
    }
  }

  Future<dynamic> getEventById(int id) async {
    Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Events/$id/');
    try {
      Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final eventDetails = await jsonDecode(response.body);

      return eventDetails;
    } catch (e) {
      return {"Error": "$e"};
    }
  }
}
