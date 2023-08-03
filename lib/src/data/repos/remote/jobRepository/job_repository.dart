import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class JobRepository {
  Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Jobs/');

  Future<dynamic> getJobsData() async {
    Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final meetData = await jsonDecode(response.body);

    return meetData;
  }
}