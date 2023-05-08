// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';

class SelectedPopUp extends StatefulWidget {
  const SelectedPopUp({super.key});

  @override
  State<SelectedPopUp> createState() => _SelectedPopUpState();
}

class _SelectedPopUpState extends State<SelectedPopUp> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Column(
        children: [
          const SizedBox(height: 30),
          Image.asset(
            "assets/PopUpScreenImages/selectedPopUp.png",
            scale: 10,
          ),
          const SizedBox(height: 20),
          const Text(
            "SELECTED",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff29D697),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "You Are Eligible For The Plan\nApply Within",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff979797),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "14 days :23 hrs : 59 min",
            style: TextStyle(
              // color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: size.width / 2,
            height: 56,
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextButton(
              onPressed: () {},
              style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
              child: const Text(
                "Enroll Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
