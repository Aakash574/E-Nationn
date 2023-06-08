// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:developer';

import 'package:email_otp/email_otp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:enationn/ApiMap/APIs/UserEndPoints/login_api.dart';
import 'package:enationn/ApiMap/APIs/UserEndPoints/signup_api.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/ForgetScreen/otp_screen.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool isSendingOTP = false;
  bool isFound = false;

  Future<void> isOtpSending() async {
    // Simulating an asynchronous task
    setState(() {
      isSendingOTP = true;
    });

    // Simulating OTP sending process
    await Future.delayed(const Duration(seconds: 8));

    setState(() {
      isSendingOTP = false;
    });
  }

  Future<void> resetPassword() async {
    final String email = _emailController.text.trim();

    log("Email : $email");

    EmailOTP myAuth = EmailOTP();

    //Get User Credentials ----

    // log(await LoginApiClient().getUserData(email));
    final userFound = await LoginApiClient().getUserData(email);
    final userId = await SignUpApiClient().getUserDataByEmail(email, 'id');

    // Checking Valid User ---
    log("UserId : $userId");
    // log("UserEmail $userEmail");
    log("Email Valid : ${EmailValidator.validate(email).toString()}");

    if (EmailValidator.validate(email) && userFound) {
      //Sending Opt With this Credentials ---

      myAuth.setConfig(
        appEmail: "contact@enationn.com",
        appName: "Enationn",
        userEmail: email,
        otpLength: 4,
        otpType: OTPType.digitsOnly,
      );
      bool status = await myAuth.sendOTP();
      if (status) {
        log("OTP Send Successfully");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return OTPScreen(
                myauth: myAuth,
                email: email,
                id: userId,
              );
            },
          ),
        );

        // For Success and Error Massages ---

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("OTP sent Successfully"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("OOPS! OTP sent Failed"),
          ),
        );
      }
    } else {
      log("InvalidEmail");
    }

    // /
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  const Spacer(),
                  MyFont().fontSize16Bold(widget.title, Colors.black),
                  const Spacer(),
                  const SizedBox(width: 30),
                ],
              ),
              const Spacer(),
              MyFont().fontSize16Bold("Enter Your Email", Colors.black),
              const SizedBox(height: 20),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: isFound
                      ? Border.all(
                          width: 1,
                          color: EmailValidator.validate(_emailController.text)
                              ? isFound
                                  ? Colors.green
                                  : Colors.red
                              : MyColors.primaryColor,
                        )
                      : _emailController.text.isEmpty
                          ? Border.all(
                              width: 1,
                              color: MyColors.primaryColor,
                            )
                          : Border.all(
                              width: 1,
                              color: Colors.red,
                            ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withOpacity(0.10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: MyColors.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) async {
                          log("Email Found : ${await LoginApiClient().getUserDataByEmail(_emailController.text, 'email') == _emailController.text}");
                          if (await LoginApiClient().getUserDataByEmail(
                                  _emailController.text, 'email') ==
                              _emailController.text) {
                            isFound = true;
                          } else {
                            isFound = false;
                          }
                          setState(
                            () {},
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    EmailValidator.validate(_emailController.text)
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : _emailController.text.isEmpty
                            ? Container()
                            : const Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerRight,
                child: isFound
                    ? MyFont().fontSize14Bold("Verified", Colors.green)
                    : null,
              ),
              // const SizedBox(height: 20.0),
              const Spacer(),
              InkWell(
                onTap: () async {
                  resetPassword();
                  isOtpSending();
                  await Future.delayed(const Duration(seconds: 8));
                  log("Button Pressed");
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: MyColors.primaryColor,
                  ),
                  child: Center(
                    child: isSendingOTP
                        ? const CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: Colors.white,
                          )
                        : MyFont()
                            .fontSize14Weight700("Send Code", Colors.white),
                  ),
                ),
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
