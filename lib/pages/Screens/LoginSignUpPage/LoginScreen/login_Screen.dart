// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'package:enationn/ApiMap/APIs/UserEndPoints/loginAPI.dart';
import 'package:enationn/Provider/basicVariablesProvider.dart';
import 'package:enationn/Provider/loginProvider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Customs/shared_Pref.dart';
import 'package:enationn/pages/Screens/PassCodeScreen/pass_Code_Screen.dart';
import 'package:enationn/pages/Screens/FormOFSignIn/apple_Sign_In.dart';
import 'package:enationn/pages/Screens/FormOFSignIn/google_Sign_In.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/SignUpScreen/signup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../ForgetScreen/forget_Password_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var _userName = "";
  var _password = "";

  bool isVisible = false;
  bool isfound = false;

  // Stay Login --------------------------->

  void _onLoginButtonPressed() async {
    // int id = ;
    String email = _emailController.text;
    String password = _passwordController.text;
    // log(id.toString());
    // Authenticate the user and save the credentials if successful
    bool isAuthenticated = await authenticateUser(context, email, password);

    if (isAuthenticated) {
      // await saveUserCredentials(id, email, password, true);
      // Navigate to the home screen
      Navigator.pushReplacementNamed(
          context, '/lib/pages/Screens/Dashboard/dashboard.dart');
    } else {
      // Show an error message
      // _showErrorDialog();``
      print("user logged Out");
    }
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginScreenModel>(context);
    final basicVariables = Provider.of<BasicVariableModel>(context);
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          height: size.height,
          margin: const EdgeInsets.all(24),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // height: 50,
                      padding: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                        border: isfound
                            ? Border.all(width: 1, color: Colors.red)
                            : const Border(
                                bottom: BorderSide.none,
                              ),
                      ),
                      child: TextField(
                        // key: _formKey,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Color(0xff9CA3AF),
                          ),
                        ),
                        controller: _emailController,
                        onChanged: (value) {
                          setState(() {
                            _userName = value;
                            model.setEmail(_userName);
                          });
                        },
                      ),
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
                              // key: _formKey,
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
                              onChanged: (value) {
                                setState(() {
                                  _password = value;
                                  model.setPassword(_password);
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ForgetPasswordScreen();
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
                    if (await LoginApiClient().login(_userName, _password) ==
                        true) {
                      setState(() {
                        _onLoginButtonPressed();
                        basicVariables.setWhichScreen("LoginScreen");
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const PassCodeScreen();
                            },
                          ),
                          (route) => false,
                        );
                      });
                    } else {
                      setState(() {
                        isfound = true;
                      });
                    }
                  },
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserNotAvailable extends StatelessWidget {
  const UserNotAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("User Not Found"));
  }
}
