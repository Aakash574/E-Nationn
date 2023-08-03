// ignore_for_file: file_names

import 'dart:developer';

import 'package:enationn/const.dart';
import 'package:enationn/src/data/repos/remote/userRepository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/shared_Pref.dart';
import '../../../provider/basic_variables_provider.dart';
import '../ForgetScreen/forget_Password_Screen.dart';
import '../SignUpScreen/signup_Screen.dart';

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
  bool loginStatus = false;
  bool validEmail = false;
  bool validPassword = false;
  bool isLoading = false;

  // Stay Login --------------------------->

  void _onLoginButtonPressed() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Authenticate the user and save the credentials if successful
    log("Email :: $email");
    bool isAuthenticated = await SharedPref().authenticateUser(email, password);
    String id = await UserRepository().getUserDataByEmail(email, 'id');

    log("Login Crede id :: $id");

    if (isAuthenticated) {
      await SharedPref().saveUserCredentials(id, email, password, true);

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/welcome',
        (route) => false,
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
                              color: _emailController.text.isNotEmpty
                                  ? validEmail
                                      ? MyColors.tealGreenColor
                                      : Colors.red
                                  : MyColors.primaryColor,
                            ),
                          ),
                          child: TextField(
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
                              color: _passwordController.text.isNotEmpty
                                  ? validPassword
                                      ? MyColors.tealGreenColor
                                      : Colors.red
                                  : MyColors.primaryColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
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
                              validEmail = await UserRepository()
                                      .getUserDataByEmail(
                                          _emailController.text, 'email') ==
                                  _emailController.text;
                              validPassword = await UserRepository()
                                      .getUserDataByEmail(
                                          _emailController.text, 'password') ==
                                  _passwordController.text;

                              setState(() {
                                isLoading = true;
                                if (!validEmail &&
                                    _emailController.text.isNotEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "Not Register",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                } else {
                                  if (!validPassword &&
                                      _passwordController.text.isNotEmpty) {
                                    _passwordController.clear();
                                    Fluttertoast.showToast(
                                      msg: "Incorrect Password",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Loading...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                }
                              });
                              loginStatus = await UserRepository().login(
                                _emailController.text,
                                _passwordController.text,
                              );
                              setState(() {
                                if (loginStatus) {
                                  basicVariables.setWhichScreen("LoginScreen");
                                  isLoading = false;
                                  _onLoginButtonPressed();
                                } else {
                                  isLoading = false;
                                }
                              });
                            },
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  )
                                : const Text(
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
