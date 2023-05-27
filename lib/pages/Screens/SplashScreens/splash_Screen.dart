// ignore_for_file: file_names, avoid_print

import 'package:enationn/app.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Customs/shared_Pref.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/LoginScreen/login_SignUp_Page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  sendToNextScreen() async {
    bool isUserLoggedIn = await getIsUserLoggedIn();
    print(isUserLoggedIn);
    if (isUserLoggedIn) {
      Future.delayed(
        const Duration(milliseconds: 2000),
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const HomeScreen();
              },
            ),
          );
        },
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 1000),
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LoginSignupScreen();
              },
            ),
            (route) => false,
          );
        },
      );
    }
  }

  @override
  void initState() {
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
