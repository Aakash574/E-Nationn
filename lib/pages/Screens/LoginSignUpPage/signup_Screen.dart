// ignore_for_file: use_build_context_synchronously, file_names, avoid_print

import 'package:enationn/Api/constant_Api.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/FormOFSignIn/apple_Sign_In.dart';
import 'package:enationn/pages/Screens/FormOFSignIn/google_Sign_In.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/login_Screen.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/signup_Screen_Two.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisible = false;
  String fullName = "";
  String email = "";
  String password = "";

  bool isUserFound = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            height: size.height - 100,
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xff6B7280).withOpacity(0.2),
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
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: MyFont().fontSize26Bold(
                        "Create a E-Nationn\nProfile",
                        MyColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Full Name",
                          hintStyle: TextStyle(
                            color: Color(0xff9CA3AF),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            fullName = value;
                          });
                        },
                      ),
                    ),
                    // Spacer(),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Color(0xff9CA3AF),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      child: isUserFound
                          ? const Text(
                              "   User Already Exist",
                              style: TextStyle(color: Colors.red),
                            )
                          : const SizedBox(),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: !isVisible,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Color(0xff9CA3AF),
                                ),
                              ),
                              controller: _passwordController,
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: isVisible
                                ? Icon(
                                    Icons.visibility_off,
                                    color: MyColors.primaryColor,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: MyColors.primaryColor,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: size.width,
                  height: 56,
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      // print(await ApiClient.getUserData(_emailController.text));
                      if (await ApiClient()
                              .getUserData(_emailController.text) !=
                          true) {
                        if (_emailController.text.isNotEmpty &
                                _passwordController.text.isNotEmpty &&
                            _fullNameController.text.isNotEmpty) {
                          await ApiClient().loginPostData(
                            _emailController.text,
                            _passwordController.text,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignUpScreenTwo(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  fullName: _fullNameController.text,
                                );
                              },
                            ),
                          );
                        }
                      } else {
                        print("User Founded");
                        setState(() {
                          isUserFound = true;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginScreen();
                              },
                            ),
                          );
                        });
                      }
                    },
                    style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: size.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: MyColors.primaryColor.withOpacity(0.5),
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            MyColors.primaryColor,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: const Text(
                        "OR",
                        style: TextStyle(color: Color(0xff6B7280)),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ByGoogleSignIn();
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        margin: const EdgeInsets.only(left: 15),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                        child: Image.asset(
                          "./assets/Logos/google.png",
                          scale: 15,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ByAppleSignIn();
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        margin: const EdgeInsets.only(right: 15),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                        child: Image.asset(
                          "./assets/Logos/Apple.png",
                          scale: 55,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Color(0xff6B7280),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const LoginScreen(),
                            inheritTheme: true,
                            ctx: context,
                          ),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
