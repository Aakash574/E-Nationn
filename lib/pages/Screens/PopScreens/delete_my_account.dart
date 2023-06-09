// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:developer';
import 'package:enationn/ApiMap/APIs/UserEndPoints/signup_api.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Customs/shared_pref.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/LoginScreen/login_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteMyAccountPopUp extends StatefulWidget {
  const DeleteMyAccountPopUp({super.key});

  @override
  State<DeleteMyAccountPopUp> createState() => _DeleteMyAccountPopUpState();
}

class _DeleteMyAccountPopUpState extends State<DeleteMyAccountPopUp> {
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
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 100,
                  color: Colors.amber[400],
                ),
                Container(
                  width: size.width / 2,
                  height: 50,
                  alignment: Alignment.center,
                  child: MyFont().fontSize16Bold(
                    "Are You Sure?",
                    Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: size.width / 3.5,
                        height: size.height / 15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: MyFont().fontSize16Bold("No", Colors.black),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        log("Developer");
                        final id = await getUserCredentials();
                        log(id['id'].toString());
                        await SignUpApiClient().deleteUser(id['id'].toString());
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return const LoginSignupScreen();
                            },
                          ),
                          (route) => false,
                        );
                        prefs.clear();

                        setState(() {});
                      },
                      child: Container(
                        width: size.width / 3.5,
                        height: size.height / 15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: MyFont().fontSize16Bold("Yes", Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
