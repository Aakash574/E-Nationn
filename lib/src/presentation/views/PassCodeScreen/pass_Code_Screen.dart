// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'dart:developer';

import 'package:enationn/src/data/repos/remote/userRepository/pass_key_repository.dart';
import 'package:enationn/src/data/repos/remote/userRepository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../const.dart';
import '../../../utils/constants/Strings/email_strings.dart';
import '../../../utils/constants/sendEmail.dart';
import '../../../utils/constants/shared_Pref.dart';
import '../../provider/basic_variables_provider.dart';
import '../../provider/user_provider.dart';
import '../ExtraScreens/thankyou_Screen.dart';
import '../ExtraScreens/welcome_Screen.dart';

class PassCodeScreen extends StatefulWidget {
  const PassCodeScreen({super.key});

  @override
  State<PassCodeScreen> createState() => _PassCodeScreenState();
}

class _PassCodeScreenState extends State<PassCodeScreen> {
  bool isActive = false;
  final keyIsFirstLoaded = 'is_first_loaded';

  List<String> pinCode = [];
  bool error = false;

  String body = "";

  void showDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    print(context.widget.toString());
    if (isFirstLoaded == null &&
        context.widget.toStringShort() == "SignUpScreen") {}
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      showDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screen = Provider.of<BasicVariableModel>(context);

    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: size.height - 100,
            margin: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    MyFont().fontSize16Bold("Pass-Key", Colors.black),
                    const SizedBox(
                      width: 45,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                MyFont().fontSize14Bold(
                  "Please Enter Your",
                  MyColors.lightGreyColor,
                ),
                MyFont().fontSize14Bold(
                  "Pass key",
                  MyColors.lightGreyColor,
                ),
                const SizedBox(height: 10),
                MyFont().fontSize14Light(
                  "Enter Pin Code (5-digit)",
                  MyColors.lightGreyColor,
                ),
                const SizedBox(height: 10),
                error == true
                    ? const Text("Enter Correct PassKey")
                    : const Text(""),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    passCodeField(pinCode.isNotEmpty
                        ? MyColors.primaryColor
                        : Colors.white),
                    passCodeField(pinCode.length >= 2
                        ? MyColors.primaryColor
                        : Colors.white),
                    passCodeField(pinCode.length >= 3
                        ? MyColors.primaryColor
                        : Colors.white),
                    passCodeField(pinCode.length >= 4
                        ? MyColors.primaryColor
                        : Colors.white),
                    passCodeField(pinCode.length >= 5
                        ? MyColors.primaryColor
                        : Colors.white),
                  ],
                ),
                Expanded(
                  child: Container(
                    height: size.height - 400,
                    width: size.width,
                    margin: const EdgeInsets.all(15),
                    child: GridView.builder(
                      shrinkWrap: false,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        if (index + 1 == 11) {
                          return passCodeEnterNumbers(
                            nums: "0",
                          );
                        }

                        if (index + 1 == 12) {
                          return InkWell(
                            onTap: () {
                              setState(
                                () {
                                  if (pinCode.isNotEmpty) {
                                    pinCode.removeLast();
                                    print(pinCode);
                                  }
                                },
                              );
                            },
                            borderRadius: BorderRadius.circular(50),
                            splashColor: MyColors.primaryColor,
                            highlightColor: Colors.transparent,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  width: 1,
                                  color: MyColors.lightGreyColor,
                                ),
                              ),
                              child: const Icon(Icons.backspace),
                            ),
                          );
                        }
                        if (index + 1 == 10) {
                          return Container();
                        } else {
                          return passCodeEnterNumbers(
                            nums: (index + 1).toString(),
                          );
                        }
                        // return null;
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (pinCode.length == 5 &&
                        await PasskeyRepository().passkey(pinCode.join(""))) {
                      log(screen.whichScreen);
                      switch (screen.whichScreen) {
                        case "VoucherScreen":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const WelcomeScreen();
                              },
                            ),
                          );
                          break;
                        case "LoginScreen":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const WelcomeScreen();
                              },
                            ),
                          );
                          break;
                        case "SignUpScreen":
                          log('Sign Up Screen');
                          final success = await userRegisterForm(screen);
                          if (success) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const WelcomeScreen();
                                },
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Something went wrong...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                          break;
                        case "PaymentScreen":
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ThankyouScreen();
                              },
                            ),
                            (route) => false,
                          );
                          break;

                        default:
                      }
                    } else {
                      setState(() {
                        error = true;
                        pinCode.clear();
                        print("PinCode : $pinCode");
                        print("object");
                      });
                    }
                  },
                  child: Container(
                    width: size.width / 3,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: MyColors.primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.primaryColor.withOpacity(0.3),
                          blurRadius: 70,
                        ),
                      ],
                    ),
                    child: const Text(
                      "GO",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Mail Send Successfully...

  Container passCodeField(Color colors) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: error == true
            ? Border.all(width: 1, color: Colors.red)
            : Border.all(width: 1, color: Colors.grey),
        color: colors,
      ),
    );
  }

  InkWell passCodeEnterNumbers({
    required String nums,
  }) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: MyColors.primaryColor,
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        setState(() {
          if (pinCode.length < 5) {
            pinCode.add(nums);
            print("Code Returns");
            print(pinCode);
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: 1,
            color: MyColors.lightGreyColor,
          ),
        ),
        child: Text(
          nums,
          style: TextStyle(
            color: Colors.black.withOpacity(0.9),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void onPasskeyButtonPressed(
    UserProvider userDataProvider,
    String id,
  ) async {
    String email = userDataProvider.email;
    String password = userDataProvider.password;
    log("ID :: $id");
    await SharedPref().saveUserCredentials(id, email, password, true);
  }

  Future<bool> userRegisterForm(
    BasicVariableModel basicVariable,
  ) async {
    final userDataProvider = Provider.of<UserProvider>(context, listen: false);
    String id = "";

    //? Sign up Email Body....
    body = Emails.singupEmails(userDataProvider);

    if (!(await UserRepository().getUserData(userDataProvider.email))) {
      log("User Not Found");

      log("Sending Successfully Registration Email...");

      //* Sending Successfully Registration Email...

      SendEmail().sendMail(
        basicVariable,
        userDataProvider,
        body,
        "Welcome to eNationn: Unlocking Endless Opportunities!",
      );

      await UserRepository().userRegisterRepository(
        userDataProvider.uId,
        userDataProvider.email,
        userDataProvider.gender,
        userDataProvider.branch,
        userDataProvider.college,
        userDataProvider.password,
        userDataProvider.fullName,
        userDataProvider.signupkey,
        userDataProvider.fatherName,
        userDataProvider.dateOfBirth,
        userDataProvider.placeOfBirth,
        userDataProvider.yearOfPassout,
        "Not Applied",
        "Not Applied",
        "Not Applied",
        userDataProvider.contact.toString(),
        userDataProvider.state,
        context,
      );
      id = await UserRepository()
          .getUserDataByEmail(userDataProvider.email, 'id');
      onPasskeyButtonPressed(userDataProvider, id);
      log('Register SuccessFully');
      return true;
    } else {
      log("User Already Exist");
      return false;
    }
  }
}
