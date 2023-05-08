// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/loginSignupPage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  sendToNextScreen() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginSignupScreen();
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    sendToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: const SafeArea(
        child: Center(
          child: Text(
            "E-nationn",
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
