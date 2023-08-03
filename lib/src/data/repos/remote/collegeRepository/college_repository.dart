import 'dart:convert';

import 'package:enationn/src/domain/models/collegeModels/college_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CollegeRepository {
  Uri urls = Uri.parse("http://13.232.155.227:8000/account/api/College/");
  Future<Colleges> fatchCollege() async {
    Response response = await http.get(
      urls,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> listOfCollege =
          List.from(json.decode(response.body));
      return Colleges.fromListOfColleges(listOfCollege);
    } else {
      throw Exception('Failed to load college');
    }
  }
}
