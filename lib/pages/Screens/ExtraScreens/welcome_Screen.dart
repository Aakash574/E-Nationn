// ignore_for_file: file_names

import 'package:enationn/app.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  sendToNextScreen() {
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ),
          (route) => false,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    sendToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/PopUpScreenImages/thankyou.png",
                    scale: 1.8,
                  ),
                  const SizedBox(height: 30),
                  MyFont().fontSize26Weight900("Welcome", Colors.black),
                  const SizedBox(height: 20),
                  MyFont().fontSize26Weight900("To", Colors.black),
                  const SizedBox(height: 20),
                  MyFont().fontSize26Weight900("Enationn", Colors.black),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
