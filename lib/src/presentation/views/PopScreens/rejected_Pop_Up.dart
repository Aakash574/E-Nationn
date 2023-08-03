// ignore_for_file: file_names

import 'package:flutter/material.dart';

class RejectedPopUp extends StatefulWidget {
  const RejectedPopUp({super.key});

  @override
  State<RejectedPopUp> createState() => _RejectedPopUpState();
}

class _RejectedPopUpState extends State<RejectedPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/PopUpScreenImages/rejectedPopUp.png",
            scale: 1.8,
          ),
          const SizedBox(height: 20),
          const Text(
            "REJECTED",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "You Are Not Eligible For The Plan Apply After",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff979797),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "14 days :23 hrs : 59 min",
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
