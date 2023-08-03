// ignore_for_file: file_names, prefer_const_constructors, use_build_context_synchronously

import 'dart:developer';

import 'package:enationn/const.dart';
import 'package:enationn/src/data/repos/remote/userRepository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/sendEmail.dart';
import '../../../provider/user_provider.dart';
import '../LoginScreen/login_Screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.id,
    required this.email,
  });
  final String id;
  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isVisible = true;
  bool notValidPassword = false;
  String body = "";

  void getData() async {
    final name =
        await UserRepository().getUserDataByEmail(widget.email, 'full_name');

    body = """

Hi $name,

Your Enation password has been changed. You can now log in to your account.

To log in, please use your new password: ${_confirmPasswordController.text}

Please remember to keep your password confidential and do not share it with anyone.

If you have any questions, please contact Enation support at ${widget.email}.

Thank you,

The Enation Team""";
  }

  Future<void> _resetPassword() async {
    getData();
    String userId =
        await UserRepository().getUserDataByEmail(widget.email, 'id');
    bool passwordReset = await UserRepository()
        .updatePassword(_passwordController.text, userId, widget.email);

    log("User ID : $userId");
    log("Reset Password : $passwordReset");

    if (passwordReset) {
      SendEmail.sendEmail(
        context,
        "Your Enation password has been changed",
        body,
        widget.email,
      );
      //Navigate to Login Screen

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) {
            return LoginScreen();
          },
        ),
        (route) => false,
      );
    } else {
      log("Field Empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Material(
      child: Container(
        margin: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
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
                  MyFont().fontSize16Bold("Reset Password", Colors.black),
                  const Spacer(),
                  const SizedBox(width: 30),
                ],
              ),
              const Spacer(),
              MyFont().fontSize16Bold("Enter New Password", Colors.black),
              const SizedBox(height: 20),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color:
                        notValidPassword ? Colors.red : MyColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.password,
                      color: MyColors.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        obscureText: isVisible,
                        controller: _passwordController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "New Password",
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => setState(() {}),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color:
                        notValidPassword ? Colors.red : MyColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.password,
                      color: MyColors.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        obscureText: isVisible,
                        controller: _confirmPasswordController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          // labelText: 'Email',
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => setState(() {}),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            isVisible = !isVisible;
                          },
                        );
                      },
                      icon: isVisible
                          ? Icon(
                              Icons.visibility_off_rounded,
                              color: MyColors.primaryColor,
                            )
                          : Icon(
                              Icons.remove_red_eye_outlined,
                              color: MyColors.primaryColor,
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // const Spacer(),
              InkWell(
                onTap: () async {
                  log("Password : ${_passwordController.text}");
                  log("Confirm Password ${_confirmPasswordController.text}");
                  // _resetPassword();
                  setState(() {
                    _passwordController.text ==
                                _confirmPasswordController.text &&
                            _passwordController.text.isNotEmpty &&
                            _confirmPasswordController.text.isNotEmpty
                        ? _resetPassword()
                        : notValidPassword = true;
                  });
                  await UserRepository().updatePassword(
                    _passwordController.text,
                    widget.id,
                    userProvider.email,
                  );
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
                    child: MyFont()
                        .fontSize14Weight700("Reset Password", Colors.white),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
