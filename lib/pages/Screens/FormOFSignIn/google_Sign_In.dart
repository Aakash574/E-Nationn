// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ByGoogleSignIn extends StatefulWidget {
  const ByGoogleSignIn({super.key});

  @override
  State<ByGoogleSignIn> createState() => _ByGoogleSignInState();
}

class _ByGoogleSignInState extends State<ByGoogleSignIn> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Google"),
      ),
    );
  }
}
