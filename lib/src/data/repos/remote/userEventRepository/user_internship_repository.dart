// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserInternshipRepository {
  Future<bool> internshipRegistration(
    String fullName,
    String college,
    String fatherName,
    String dateOfBirth,
    String dateOfEvent,
    String internshipName,
    String applyStatus,
    String paymentStatus,
    String price,
    String uniqueId,
  ) async {
    Uri url =
        Uri.parse('http://13.232.155.227:8000/account/api/Internship_account/');

    final requestBody = jsonEncode(
      {
        'name': fullName,
        'father_name': fatherName,
        'college': college,
        'date_of_birth': dateOfBirth,
        'internship_name': internshipName,
        'apply_status': applyStatus,
        'payment_status': paymentStatus,
        'date_of_internship': dateOfEvent,
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

  Future<dynamic> getUserInternshipData() async {
    Uri url =
        Uri.parse('http://13.232.155.227:8000/account/api/Internship_account/');
    Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<dynamic> userInternshipData = await jsonDecode(response.body);

    return userInternshipData;
  }
}
