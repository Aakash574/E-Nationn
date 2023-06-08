// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:enationn/pages/Customs/shared_Pref.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/ForgetScreen/forget_Password_Screen.dart';
import 'package:enationn/pages/Screens/PopScreens/delete_My_Account.dart';
import 'package:flutter/material.dart';

import '../../../../const.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => SecurityScreenState();
}

class SecurityScreenState extends State<SecurityScreen> {
  var userData;
  String userName = "";
  String userEmail = "";
  String dateOfBirth = "";
  // final  = "";

  void _scaleDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: const DeleteMyAccountPopUp(),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  void userCredentials() async {
    var loginCredentials = await getUserCredentials();
    userData = await getUserData(loginCredentials['id']);
    userName = userData['full_name'];
    userEmail = userData['email'];
    dateOfBirth = userData['date_of_birth'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    userCredentials();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            height: size.height - 100,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: MyColors.lightGreyColor.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    MyFont().fontSize16Bold("Settings", Colors.black),
                    const SizedBox(
                      width: 45,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return const ForgetPasswordScreen(
                              title: "Reset Password");
                        },
                      ),
                    );
                  },
                  child: fieldForUserCredential(
                    size,
                    "Change Password",
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _scaleDialog();
                  },
                  child: fieldForUserCredential(
                    size,
                    "Delete My Account",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fieldForUserCredential(Size size, String data) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 60,
      width: size.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
      child: MyFont().fontSize14Bold(
        data,
        Colors.black,
      ),
    );
    // SizedBox(height: 10),
  }
}
