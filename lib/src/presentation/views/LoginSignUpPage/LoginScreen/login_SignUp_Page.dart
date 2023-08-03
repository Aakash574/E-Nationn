// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../provider/basic_variables_provider.dart';
import '../SignUpScreen/signup_Screen.dart';
import 'login_screen.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  @override
  Widget build(BuildContext context) {
    final screen = Provider.of<BasicVariableModel>(context);
    final size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: size.height / 3,
              decoration: const BoxDecoration(
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
                const SizedBox(height: 20),
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
                    setState(() {
                      screen.setWhichScreen("SignUpScreen");
                    });
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const SignUpScreen(),
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
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                        type: PageTransitionType.fade,
                        child: const LoginScreen(),
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
