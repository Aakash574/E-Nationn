// ignore_for_file: file_names

import 'dart:convert';

SignUpUser usersFromJson(String str) => SignUpUser.fromJson(json.decode(str));

class SignUpUser {
  String fullName;
  String email;
  String password;
  String fatherName;
  String college;
  String branch;
  String yearOfPassout;
  String dateOfBirth;
  String placeOfBirth;

  SignUpUser({
    required this.fullName,
    required this.email,
    required this.password,
    required this.fatherName,
    required this.college,
    required this.branch,
    required this.yearOfPassout,
    required this.dateOfBirth,
    required this.placeOfBirth,
  });

  factory SignUpUser.fromJson(Map<String, dynamic> json) => SignUpUser(
        fullName: json['fullName'],
        email: json['email'],
        password: json['password'],
        fatherName: json['fatherName'],
        college: json['college'],
        branch: json['branch'],
        yearOfPassout: json['yearOfPassout'],
        dateOfBirth: json['dateOfBirth'],
        placeOfBirth: json['placeOfBirth'],
      );
}
