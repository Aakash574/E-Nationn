// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ForgetPassworScreen extends StatefulWidget {
  const ForgetPassworScreen({super.key});

  @override
  State<ForgetPassworScreen> createState() => _ForgetPassworScreenState();
}

class _ForgetPassworScreenState extends State<ForgetPassworScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("ForgetScreen"),
      )),
    );
  }
}
