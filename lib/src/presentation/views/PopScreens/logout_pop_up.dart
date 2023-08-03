// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../const.dart';
import '../../../utils/constants/shared_Pref.dart';

class LogoutPopups {
  scaleDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: const LogoutPopUp(),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

class LogoutPopUp extends StatefulWidget {
  const LogoutPopUp({super.key});

  @override
  State<LogoutPopUp> createState() => _LogoutPopUpState();
}

class _LogoutPopUpState extends State<LogoutPopUp> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: size.height / 1.2,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/PopUpScreenImages/rejectedPopUp.png",
                scale: 1.8,
              ),
              const SizedBox(height: 20),
              const Text(
                "Are You Sure?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 48,
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    // -------------Login API Section---------->

                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: const Text(
                        "No",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 48,
                    decoration: BoxDecoration(
                      color: MyColors.tealGreenColor,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    // -------------Login API Section---------->

                    child: TextButton(
                      onPressed: () async {
                        log("Logout....");

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        log(prefs.toString());
                        setState(() {
                          SharedPref().setUserLoggedIn(false);
                          prefs.clear();
                          log("User Credentials is clear");
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        });
                      },
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: const Text(
                        "Yes",
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
            ],
          ),
        ),
      ),
    );
  }
}
