// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ByAppleSignIn extends StatefulWidget {
  const ByAppleSignIn({super.key});

  @override
  State<ByAppleSignIn> createState() => _ByAppleSignInState();
}

class _ByAppleSignInState extends State<ByAppleSignIn> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Apple"),
      ),
    );
  }
}
