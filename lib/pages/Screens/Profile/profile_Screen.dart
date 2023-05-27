// ignore_for_file: file_names, use_build_context_synchronously

import 'package:enationn/const.dart';
import 'package:enationn/pages/Customs/shared_Pref.dart';
import 'package:enationn/pages/Screens/LoginSignUpPage/LoginScreen/login_Screen.dart';
import 'package:enationn/pages/Screens/Profile/Sections/help_Screen.dart';
import 'package:enationn/pages/Screens/Profile/Sections/privacy_Policy_Screen.dart';
import 'package:enationn/pages/Screens/Profile/Sections/security_Screen.dart';
import 'package:flutter/material.dart';

import 'Sections/personal_Info_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String userEmail = "";
  String userBranch = "";
  String userCollege = "";
  var userData = {};
  void userCredentials() async {
    var loginCredentials = await getUserCredentials();
    userData = await getUserData(loginCredentials['id']);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    userCredentials();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: Container(
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage("assets/ProfileScreen/profileBackground.png"),
          ),
        ),
        child: Column(
          children: [
            Container(
              // height: size.height,
              margin: const EdgeInsets.all(24),
              child: Row(
                children: [
                  const Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: size.width,
                    margin: const EdgeInsets.only(top: 45),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 35),
                          const Text(
                            "General",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PersonalInfoScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 38,
                                    width: 38,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.blue[100],
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: MyColors.primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyFont().fontSize14Bold(
                                          "Personal Info", Colors.black),
                                      const SizedBox(height: 5),
                                      MyFont().fontSize12Weight500(
                                        "Name : ${userData['full_name']}",
                                        Colors.black.withOpacity(0.5),
                                      ),
                                      const SizedBox(height: 2),
                                      MyFont().fontSize12Weight500(
                                        "Email : ${userData['email']}",
                                        Colors.black.withOpacity(0.5),
                                      ),
                                      const SizedBox(height: 2),
                                      MyFont().fontSize12Weight500(
                                        "Branch : ${userData['branch']}",
                                        Colors.black.withOpacity(0.5),
                                      ),
                                      const SizedBox(height: 2),
                                      MyFont().fontSize12Weight500(
                                        "College : ${userData['college']}",
                                        Colors.black.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          profileSection(
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SecurityScreen(),
                                ),
                              );
                            },
                            "Security",
                            "Account Security",
                            Icon(
                              Icons.shield_moon,
                              color: MyColors.primaryColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          profileSection(
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PrivacyPolicyScreen(),
                                ),
                              );
                            },
                            "Privacy policy",
                            "Your Account Privacy",
                            Icon(
                              Icons.privacy_tip_outlined,
                              color: MyColors.primaryColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          profileSection(
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HelpScreen(),
                                ),
                              );
                            },
                            "Help",
                            "Need More Help",
                            Icon(
                              Icons.help,
                              color: MyColors.primaryColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              setState(() {
                                setUserLoggedIn(false);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return const LoginScreen();
                                    },
                                  ),
                                  (route) => false,
                                );
                              });
                            },
                            child: Container(
                              height: 72,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.transparent,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 38,
                                    width: 38,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.blue[100],
                                    ),
                                    child: Icon(
                                      Icons.logout_outlined,
                                      color: MyColors.primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  MyFont().fontSize14Bold(
                                    "Logout",
                                    Colors.black,
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    radius: 45,
                    backgroundImage: const AssetImage(
                      "assets/ProfileScreen/profile.png",
                      // scale: 2,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.transparent,
                        border: Border.all(
                          width: 5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell profileSection(
    Function onTap,
    String mainHeading,
    String secondaryHeading,
    Icon sectionIcon,
  ) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: 72,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            width: 1,
            color: Colors.grey.shade300,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue[100],
              ),
              child: sectionIcon,
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyFont().fontSize14Bold(mainHeading, Colors.black),
                const SizedBox(height: 5),
                MyFont().fontSize12Weight500(
                  secondaryHeading,
                  Colors.black.withOpacity(0.5),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
