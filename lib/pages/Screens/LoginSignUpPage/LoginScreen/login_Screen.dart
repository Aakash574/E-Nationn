// ignore_for_file: file_names

import 'dart:developer';

import 'package:enationn/ApiMap/APIs/UserEndPoints/login_api.dart';
import 'package:enationn/ApiMap/APIs/UserEndPoints/signup_api.dart';
import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Customs/shared_pref.dart';
import 'package:enationn/pages/Screens/ExtraScreens/welcome_screen.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/ForgetScreen/forget_password_screen.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/SignUpScreen/signup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isVisible = false;
  bool emailfound = true;
  bool passwordfound = true;

  // Stay Login --------------------------->

  void _onLoginButtonPressed() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Authenticate the user and save the credentials if successful
    log("Email :: $email");
    bool isAuthenticated = await SharedPref().authenticateUser(email, password);
    String id = await SignUpApiClient().getUserDataByEmail(email, 'id');

    if (isAuthenticated) {
      await SharedPref().saveUserCredentials(id, email, password, true);
      // Navigate to the home screen
      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        '/lib/pages/Screens/Dashboard/dashboard.dart',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final basicVariables =
        Provider.of<BasicVariableModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Material(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              height: size.height - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Text(
                    "Hi There! 👋",
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Welcome back, Sign In to your account",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    child: Column(
                      key: formKey,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xffF9FAFB),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color: emailfound
                                  ? MyColors.tealGreenColor
                                  : Colors.red,
                            ),
                          ),
                          child: TextField(
                            onChanged: (value) async {
                              final loginStatus =
                                  await LoginApiClient().getUserData(value);
                              setState(() {
                                if (loginStatus) {
                                  emailfound = true;
                                } else {
                                  emailfound = false;
                                }
                              });
                            },
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: Color(0xff9CA3AF),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xffF9FAFB),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color: passwordfound
                                  ? MyColors.tealGreenColor
                                  : Colors.red,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onChanged: (value) async {
                                    if (await SignUpApiClient()
                                            .getUserDataByEmail(
                                                _emailController.text,
                                                'password') ==
                                        value) {
                                      passwordfound = true;
                                    } else {
                                      passwordfound = false;
                                    }
                                    setState(() {});
                                  },
                                  obscureText: !isVisible,
                                  keyboardType: TextInputType.visiblePassword,
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: Color(0xff9CA3AF),
                                    ),
                                  ),
                                  controller: _passwordController,
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
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ForgetPasswordScreen(
                                    title: "Forget Password",
                                  );
                                },
                              ),
                            );
                          },
                          style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory),
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: MyColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: size.width,
                          height: 56,
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),

                          // -------------Login API Section---------->

                          child: TextButton(
                            onPressed: () async {
                              final loginStatus = await LoginApiClient().login(
                                  _emailController.text,
                                  _passwordController.text);
                              final signupEmailStatus = await SignUpApiClient()
                                      .getUserDataByEmail(
                                          _emailController.text, "email") ==
                                  _emailController.text;
                              bool signupPasswordStatus = false;
                              if (signupEmailStatus) {
                                signupPasswordStatus = await SignUpApiClient()
                                        .getUserDataByEmail(
                                            _emailController.text,
                                            "password") ==
                                    _passwordController.text;
                              }

                              if (loginStatus &&
                                  signupPasswordStatus &&
                                  signupEmailStatus) {
                                log("Correct Login email Password");
                                _onLoginButtonPressed();
                                basicVariables.setWhichScreen("LoginScreen");
                                if (!mounted) return;

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const WelcomeScreen();
                                    },
                                  ),
                                  (route) => false,
                                );
                                setState(() {});
                              } else {
                                setState(() {
                                  log("Wrong Email Password");
                                  _passwordController.clear();
                                });
                              }
                            },
                            style: const ButtonStyle(
                                splashFactory: NoSplash.splashFactory),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Stack(
                        //   alignment: Alignment.center,
                        //   children: [
                        //     Container(
                        //       height: 1,
                        //       width: size.width,
                        //       alignment: Alignment.center,
                        //       decoration: BoxDecoration(
                        //         color: MyColors.primaryColor.withOpacity(0.5),
                        //         gradient: LinearGradient(
                        //           colors: [
                        //             Colors.transparent,
                        //             MyColors.primaryColor,
                        //             Colors.transparent,
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //       width: 40,
                        //       height: 40,
                        //       alignment: Alignment.center,
                        //       color: Colors.white,
                        //       child: const Text(
                        //         "OR",
                        //         style: TextStyle(color: Color(0xff6B7280)),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) {
                        //               return const ByGoogleSignIn();
                        //             },
                        //           ),
                        //         );
                        //       },
                        //       child: Container(
                        //         width: 150,
                        //         height: 50,
                        //         margin: const EdgeInsets.only(left: 15),
                        //         padding: const EdgeInsets.all(12),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(16),
                        //           border: Border.all(
                        //             width: 1,
                        //             color: Colors.grey.withOpacity(0.2),
                        //           ),
                        //         ),
                        //         child: Image.asset(
                        //           "./assets/Logos/google.png",
                        //           scale: 15,
                        //         ),
                        //       ),
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) {
                        //               return const ByAppleSignIn();
                        //             },
                        //           ),
                        //         );
                        //       },
                        //       child: Container(
                        //         width: 150,
                        //         height: 50,
                        //         margin: const EdgeInsets.only(right: 15),
                        //         padding: const EdgeInsets.all(12),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(16),
                        //           border: Border.all(
                        //             width: 1,
                        //             color: Colors.grey.withOpacity(0.2),
                        //           ),
                        //         ),
                        //         child: Image.asset(
                        //           "./assets/Logos/Apple.png",
                        //           scale: 55,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
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
                                    child: const SignUpScreen(),
                                    inheritTheme: true,
                                    ctx: context,
                                  ),
                                );
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: MyColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
