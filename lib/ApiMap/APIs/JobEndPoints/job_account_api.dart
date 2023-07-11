import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class JobsAccountApiClient {
  Uri url = Uri.parse('http://13.232.155.227:8000/account/api/Jobs_account/');

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

  Future<dynamic> postJobsData(
    String uId,
    String name,
    String email,
    String college,
    String branch,
    String jobType,
    String jobName,
    String phoneNo,
    String currentSem,
    String currentAdd,
    String resumeLink,
  ) async {
    final body = jsonEncode(
      {
        'uniqueid': uId,
        'name': name,
        'email': email,
        'college_name': college,
        'branch': branch,
        'type_of_job': jobType,
        'name_of_job': jobName,
        'phone': phoneNo,
        'current_sem': currentSem,
        'current_address': currentAdd,
        'resume_link': resumeLink,
        'apply_status': 'Applied',
      },
    );

    Response response = await http.post(
      url,
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    log(response.statusCode.toString());

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
