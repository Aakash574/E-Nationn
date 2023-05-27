// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PaymentScreens/plan_Screen.dart';
import 'package:flutter/material.dart';

class SubscribePopUp extends StatefulWidget {
  const SubscribePopUp({super.key});

  @override
  State<SubscribePopUp> createState() => _SubscribePopUpState();
}

class _SubscribePopUpState extends State<SubscribePopUp> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => Navigator.pop(context),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: SizedBox(
            height: size.height / 3.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/PopUpScreenImages/subscribePopUp.png",
                  scale: size.height / 250,
                ),
                Text(
                  "You Have Not Applied For Any Plan",
                  style: TextStyle(
                    color: const Color(0xff979797),
                    fontSize: size.height / 50,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    setState(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlanScreen(),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: size.width / 2,
                    height: size.height / 15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Apply",
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
          ),
        ),
      ),
    );
  }
}
