// ignore_for_file: file_names

import 'package:enationn/app.dart';
import 'package:flutter/material.dart';

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({super.key});

  @override
  State<ThankyouScreen> createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {
  sendToNextScreen() {
    Future.delayed(
      const Duration(milliseconds: 1000),
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
                  // const SizedBox(height: 20),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) {
                  //           return const HomeScreen();
                  //         },
                  //       ),
                  //     );
                  //   },
                  //   child: const Text(
                  //     "Go Back",
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
