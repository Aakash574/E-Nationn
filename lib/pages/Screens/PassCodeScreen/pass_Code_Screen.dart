// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'dart:developer';

import 'package:enationn/ApiMap/APIs/UserEndPoints/passkey_api.dart';
import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/ExtraScreens/thankyou_Screen.dart';
import 'package:enationn/pages/Screens/ExtraScreens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ApiMap/APIs/UserEndPoints/login_api.dart';
import '../../../ApiMap/APIs/UserEndPoints/signup_api.dart';
import '../../Customs/sendEmail.dart';
import '../../Customs/shared_Pref.dart';

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
                      physics: const NeverScrollableScrollPhysics(),
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
                        await PasskeyApiClient().passkey(pinCode.join(""))) {
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
                          userRegisterForm(screen);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const WelcomeScreen();
                              },
                            ),
                          );
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
    // Navigate to the home screen
    // Navigator.pushReplacementNamed(
    //   context,
    //   '/lib/pages/Screens/Dashboard/dashboard.dart',
    // );
  }

  void userRegisterForm(
    BasicVariableModel basicVariable,
  ) async {
    final userDataProvider = Provider.of<UserProvider>(context, listen: false);
    String id = "";

    //? Sign up Email Body....
    body = """
Dear ${userDataProvider.fullName}\n\n
    
Welcome to eNationn! We're thrilled to have you as a registered student. Get
ready to explore a world of endless opportunities in your educational journey with
us.\n\n

At eNationn, we believe in providing holistic learning experiences. In addition to
our diverse course offerings, we offer a range of exciting opportunities to
enhance your skills and propel your career forward. Here's what you can look
forward to:\n\n

      ●     Internship Programs: Gain valuable real-world experience through our
              internship programs. We partner with leading companies to offer
              internships that align with your interests and career aspirations.\n
      ●     Hackathons: Put your problem-solving skills to the test by participating in
              our exhilarating hackathons. Collaborate with like-minded individuals,
              unleash your creativity, and showcase your innovative solutions.\n
      ●     Events and Workshops: Attend our dynamic events and workshops
              conducted by industry experts. Stay updated with the latest trends, learn
              new techniques, and expand your professional network.\n
      ●     Job Opportunities: Our extensive network of partner organizations
              provides exclusive job opportunities for eNationn students. Take
              advantage of our connections to jumpstart your career and land your
              dream job.\n\n

We're committed to supporting your growth and success. Should you have any
questions, require guidance, or need assistance in exploring these opportunities,
our dedicated support team is here to help.\n\n

Thank you for choosing eNationn as your preferred learning platform. We're
excited to see you thrive academically and professionally. Let's unlock a world of
opportunities together!\n\n

Best regards, Enationn Team""";

    if (!(await LoginApiClient().getUserData(userDataProvider.email))) {
      await LoginApiClient().loginPostData(
        userDataProvider.email,
        userDataProvider.password,
      );
      // if (!mounted) return;

      log("Sending Successfully Registration Email...");

      //* Sending Successfully Registration Email...

      SendEmail().sendMail(
        basicVariable,
        userDataProvider,
        body,
        "Welcome to eNationn: Unlocking Endless Opportunities!",
      );

      await SignUpApiClient().registerUser(
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
        userDataProvider.contact,
        context,
      );
      id = await SignUpApiClient()
          .getUserDataByEmail(userDataProvider.email, 'id');
    } else {
      log("User Already Exist");
    }
    onPasskeyButtonPressed(userDataProvider, id);
  }
}
