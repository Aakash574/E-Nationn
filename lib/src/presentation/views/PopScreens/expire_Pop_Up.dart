// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';

class ExpirePopUp extends StatefulWidget {
  const ExpirePopUp({super.key});

  @override
  State<ExpirePopUp> createState() => _ExpirePopUpState();
}

class _ExpirePopUpState extends State<ExpirePopUp> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      // backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Column(
        children: [
          Image.asset(
            "assets/PopUpScreenImages/expirePopUp.png",
          ),
          const SizedBox(height: 20),
          const Text(
            "EXPIRE",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const Text(
            "For Any Help You Can Contact",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff979797),
              fontSize: 16,
            ),
          ),
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
                "Support",
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
