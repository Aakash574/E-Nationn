// ignore_for_file: file_names

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

class Users {
  String fullName;
  String email;
  String password;

  Users({
    required this.fullName,
    required this.email,
    required this.password,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        fullName: json['fullName'],
        email: json['email'],
        password: json['password'],
      );
}
