// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserEventApiClient {
  Future<bool> eventRegistration(
    String fullName,
    String college,
    String fatherName,
    String dateOfBirth,
    String dateOfEvent,
    String eventName,
    String applyStatus,
    String paymentStatus,
    String price,
    String uniqueId,
  ) async {
    Uri url =
        Uri.parse('http://13.232.155.227:8000/account/api/Event_account/');

    final requestBody = jsonEncode(
      {
        'name': fullName,
        'father_name': fatherName,
        'college': college,
        'date_of_birth': dateOfBirth,
        'date_of_hackathon': dateOfEvent,
        'event_name': eventName,
        'apply_status': applyStatus,
        'payment_status': paymentStatus,
        'price': price,
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

  Future<dynamic> getUserEventDetails() async {
    Uri url =
        Uri.parse('http://13.232.155.227:8000/account/api/Event_account/');
    Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<dynamic> userEventData = await json.decode(response.body);

    return userEventData;
  }
}
