// ignore_for_file: use_build_context_synchronously, file_names, unrelated_type_equality_checks

import 'dart:developer';

import 'package:enationn/const.dart';
import 'package:enationn/src/presentation/views/LoginSignUpPage/ForgetScreen/reset_Password_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../provider/basic_variables_provider.dart';
import '../../../provider/user_provider.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
  });

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final basicVariable = Provider.of<BasicVariableModel>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OTP(
                    otpController: otp1Controller,
                    index: "0",
                  ),
                  OTP(
                    otpController: otp2Controller,
                    index: "1",
                  ),
                  OTP(
                    otpController: otp3Controller,
                    index: "2",
                  ),
                  OTP(
                    otpController: otp4Controller,
                    index: "3",
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
                      log(basicVariable.verificationCode);
                      log(otp1Controller.text +
                          otp2Controller.text +
                          otp3Controller.text +
                          otp4Controller.text);
                      if (basicVariable.verificationCode ==
                          otp1Controller.text +
                              otp2Controller.text +
                              otp3Controller.text +
                              otp4Controller.text) {
                        log("Correct Otp");
                        Fluttertoast.showToast(
                          msg: "Sending...",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(
                              id: userProvider.id,
                              email: userProvider.email,
                            ),
                          ),
                        );
                      } else {
                        log("Incorrect otp");
                        Fluttertoast.showToast(
                          msg: "Some thing went wrong...",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
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

class OTP extends StatefulWidget {
  const OTP({
    Key? key,
    required this.otpController,
    required this.index,
  }) : super(key: key);
  final TextEditingController otpController;
  final String index;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
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
        color: MyColors.primaryColor.withOpacity(0.1),
      ),
      child: TextFormField(
        controller: widget.otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1 && widget.index != "3") {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && widget.index != "0") {
            FocusScope.of(context).previousFocus();
          }
          setState(() {});
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
