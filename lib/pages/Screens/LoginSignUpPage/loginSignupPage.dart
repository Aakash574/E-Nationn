// ignore_for_file: prefer_const_constructors, file_names

import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PassCodeScreen/pass_Code_Screen.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/login_Screen.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/signup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  scale: 50,
                  image: AssetImage(
                    "assets/LoginSignupScreen/loginSignupPage.png",
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: MyFont().fontSize26Bold(
                    "If opportunity doesn't \nknock, build a door",
                    Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Mentors on Prener will help you achieve your most ambitious goals. Come on, let’s smash them together!",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: [
                InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  splashColor: Colors.green,
                  highlightColor: Colors.transparent,
                  // autofocus: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: PassCodeScreen(),
                        inheritTheme: true,
                        ctx: context,
                      ),
                    );
                  },
                  child: Container(
                    width: size.width / 2,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: MyColors.primaryColor,
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  splashColor: Colors.blue,
                  // splashFactory: NoSplash.splashFactory,
                  highlightColor: Colors.transparent,
                  // autofocus: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: LoginScreen(),
                        inheritTheme: true,
                        ctx: context,
                      ),
                    );
                  },
                  child: Container(
                    width: size.width / 2,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 1,
                        color: MyColors.primaryColor.withOpacity(0.5),
                      ),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: MyColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
