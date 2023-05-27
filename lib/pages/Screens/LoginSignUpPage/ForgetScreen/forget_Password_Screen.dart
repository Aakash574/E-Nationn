// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:developer';

import 'package:email_otp/email_otp.dart';
import 'package:email_validator/email_validator.dart';
import 'package:enationn/ApiMap/APIs/UserEndPoints/signupAPI.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';

import 'otp_Screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> resetPassword() async {
    final String email = _emailController.text.trim();

    log("Email : $email");

    EmailOTP myAuth = EmailOTP();

    //Get User Credentials ----

    // log(await SignUpApiClient().getUserData(email));
    final userEmail =
        await SignUpApiClient().getUserDataByEmail(email, 'email');
    final userId = await SignUpApiClient().getUserDataByEmail(email, 'id');

    // Checking Valid User ---
    log("UserEmail $userEmail");
    log("Email Valid : ${EmailValidator.validate(email).toString()}");

    if (EmailValidator.validate(email) && email == userEmail) {
      //Sending Opt With this Credentials ---

      myAuth.setConfig(
        appEmail: "contact@enationn.com",
        appName: "Enationn",
        userEmail: email,
        otpLength: 4,
        otpType: OTPType.digitsOnly,
      );
      log("Status : ${await myAuth.sendOTP()}");
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
    } else {}

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
                  MyFont().fontSize16Bold("Forget Password", Colors.black),
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
                  border: Border.all(
                    width: 1,
                    color: EmailValidator.validate(_emailController.text) ||
                            _emailController.text.isEmpty
                        ? MyColors.primaryColor
                        : Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: MyColors.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          // labelText: 'Email',
                          hintText: "Email",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => setState(() {}),
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
              // const SizedBox(height: 20.0),
              const Spacer(),
              InkWell(
                onTap: () async {
                  resetPassword();
                  log("Button Pressed");
                  // log(await SignUpApiClient()
                  //     .getSpecificUserDetails(_emailController.text, 'email'));
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
                    child:
                        MyFont().fontSize14Weight700("Send Code", Colors.white),
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
