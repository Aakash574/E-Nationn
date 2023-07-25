import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class CollegeApiClient {
  Future<dynamic> getCollege() async {
    Uri urls = Uri.parse("http://13.232.155.227:8000/account/api/College/");

    Response response = await http.get(
      urls,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load college');
    }
  }
}
