// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/ExtraScreens/plan_Screen.dart';
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: SizedBox(
            height: 280,
            child: Column(
              children: [
                Image.asset(
                  "assets/PopUpScreenImages/subscribePopUp.png",
                ),
                const Text(
                  "You Have Not Applied For Any Plan",
                  style: TextStyle(
                    color: Color(0xff979797),
                    fontSize: 16,
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
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlanScreen(),
                          ),
                        );
                      });
                    },
                    style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory),
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
