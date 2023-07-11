// ignore_for_file: file_names

import 'package:email_validator/email_validator.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/LoginScreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../ApiMap/APIs/UserEndPoints/login_api.dart';
import 'signup_Screen_Two.dart';

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
  bool isValid = false;
  bool isPasswordShort = false;
  bool isPasswordLong = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Material(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                  // const Spacer(),
                  const SizedBox(height: 20),
                  Container(
                    child: MyFont().fontSize26Bold(
                      "Create E-Nationn\nProfile",
                      MyColors.primaryColor,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    child: MyFont().fontSize16Weight500(
                      "Please enter the details.",
                      MyColors.darkGreyColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffF9FAFB),
                          border: Border.all(
                            width: 1,
                            color: MyColors.primaryColor,
                          ),
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
                              userProvider.setFullName(fullName);
                            });
                          },
                        ),
                      ),
                      // const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffF9FAFB),
                          border: Border.all(
                            width: 1,
                            color: _emailController.text.isEmpty
                                ? MyColors.primaryColor
                                : isValid
                                    ? Colors.green
                                    : Colors.red,
                          ),
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
                            setState(
                              () {
                                email = value.toLowerCase();
                                userProvider.setEmail(email);
                                if (EmailValidator.validate(email)) {
                                  isValid = true;
                                } else {
                                  isValid = false;
                                }
                              },
                            );
                          },
                        ),
                      ),
                      isUserFound
                          ? const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                "User Already Exist",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : const SizedBox(),
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffF9FAFB),
                          border: Border.all(
                            width: 1,
                            color: _passwordController.text.length >= 6
                                ? _passwordController.text.length <= 15
                                    ? Colors.green
                                    : Colors.red
                                : _passwordController.text.isEmpty
                                    ? MyColors.primaryColor
                                    : Colors.red,
                          ),
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
                                    userProvider.setPassword(password);
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
                      const SizedBox(height: 5),
                      MyFont().fontSize12Weight500(
                        "Note : password must be more then 6 char and less then 15",
                        MyColors.primaryColor,
                      ),
                      const SizedBox(height: 5),
                      _passwordController.text.isNotEmpty
                          ? _passwordController.text.length <= 6
                              ? MyFont().fontSize12Bold("Too short", Colors.red)
                              : const SizedBox()
                          : const SizedBox(),
                      const SizedBox(height: 5),
                      _passwordController.text.isNotEmpty
                          ? _passwordController.text.length >= 15
                              ? MyFont().fontSize12Bold("Too Long", Colors.red)
                              : const SizedBox()
                          : const SizedBox(),
                    ],
                  ),
                  // const Spacer(),
                  const SizedBox(height: 20),
                  Container(
                    width: size.width,
                    height: 56,
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (await LoginApiClient()
                                    .getUserData(_emailController.text) !=
                                true &&
                            isValid &&
                            _passwordController.text.length >= 6 &&
                            _passwordController.text.length <= 15) {
                          setState(() {
                            isPasswordShort = false;
                            isPasswordLong = false;
                          });
                          if (_emailController.text.isNotEmpty &
                                  _passwordController.text.isNotEmpty &&
                              _fullNameController.text.isNotEmpty) {
                            if (!mounted) return;

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
                          setState(() {
                            isPasswordShort = true;
                            isPasswordLong = true;
                          });
                          if (await LoginApiClient()
                              .getUserData(_emailController.text)) {
                            setState(() {
                              isUserFound = true;
                            });
                          } else {
                            isUserFound = false;
                          }
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
                  // const Spacer(),
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
                  // const Spacer(),
                  // const SizedBox(height: 50),
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
      ),
    );
  }
}
