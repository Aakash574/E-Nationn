// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class InternShipApiClient {
  Uri internshipApi =
      Uri.parse('http://13.232.155.227:8000/account/api/Internship/');

  Future<List<dynamic>> getInternshipDetails() async {
    Response response = await http.get(
      internshipApi,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<dynamic> internshipDetails = await jsonDecode(response.body);
    log(internshipDetails.length.toString());

    return internshipDetails;
  }
}
