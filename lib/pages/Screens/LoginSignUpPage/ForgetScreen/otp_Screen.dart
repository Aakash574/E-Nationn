// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:developer';
import 'dart:async';

import 'package:email_otp/email_otp.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/ForgetScreen/reset_Password_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTP extends StatelessWidget {
  const OTP({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(8),
        // color: Colors.grey.withOpacity(0.1),
        color: MyColors.primaryColor.withOpacity(0.1),
      ),
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
          border: InputBorder.none,
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
    required this.myauth,
    required this.email,
    required this.id,
  }) : super(key: key);

  final EmailOTP myauth;
  final String email;
  final String id;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";
  String userEmail = "";

  Future<void> resetPassword() async {
    final String email = widget.email.trim();

    log("Email : $email");

    EmailOTP myAuth = EmailOTP();

    //Sending Opt With this Credentials ---

    myAuth.setConfig(
      appEmail: "contact@enationn.com",
      appName: "Enationn",
      userEmail: email,
      otpLength: 4,
      otpType: OTPType.digitsOnly,
    );
    log("Status : ${myAuth.sendOTP()}");
    bool status = await myAuth.sendOTP();
    if (status) {
      // For Success and Error Massages ---

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP Resend Successfully"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OOPS! OTP sent Failed"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log(emailController);
    log("EmailController: ${widget.email}");

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
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
                  MyFont().fontSize16Bold("Verify Code", Colors.black),
                  const Spacer(),
                  const SizedBox(),
                ],
              ),
              const Spacer(),
              MyFont().fontSize16Bold("Verification Code", Colors.black),
              const SizedBox(height: 5),
              MyFont().fontSize14Weight500(
                  "We have sent the code Verification", Colors.grey),
              const SizedBox(height: 5),
              MyFont().fontSize14Weight500("to ${widget.email}", Colors.grey),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OTP(
                    otpController: otp1Controller,
                  ),
                  OTP(
                    otpController: otp2Controller,
                  ),
                  OTP(
                    otpController: otp3Controller,
                  ),
                  OTP(
                    otpController: otp4Controller,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      // resetPassword(context, widget.email);
                    },
                    child: Container(
                      width: size.width / 2.5,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: MyFont()
                            .fontSize14Weight700("Resend", Colors.black),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (await widget.myauth.verifyOTP(
                              otp: otp1Controller.text +
                                  otp2Controller.text +
                                  otp3Controller.text +
                                  otp4Controller.text) ==
                          true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("OTP is verified"),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(
                              id: widget.id,
                              email: widget.email,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Invalid OTP"),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: size.width / 2.5,
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
                        child: MyFont()
                            .fontSize14Weight700("Confirm", Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
