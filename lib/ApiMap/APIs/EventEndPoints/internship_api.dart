// ignore_for_file: file_names

import 'dart:convert';

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

    return internshipDetails;
  }

  Future<dynamic> getInternshipById(int id) async {
    Uri url =
        Uri.parse('http://13.232.155.227:8000/account/api/Internship/$id/');
    try {
      Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final internshipDetails = await jsonDecode(response.body);

      return internshipDetails;
    } catch (e) {
      return {"Error": "$e"};
    }
  }
}
