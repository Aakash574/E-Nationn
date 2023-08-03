// ignore_for_file: file_names, use_build_context_synchronously

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';
import 'package:share_plus/share_plus.dart';

import '../../provider/user_provider.dart';
import '../PopScreens/logout_pop_up.dart';
import 'Sections/help_screen.dart';
import 'Sections/personal_Info_screen.dart';
import 'Sections/privacy_policy_screen.dart';
import 'Sections/security_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      'https://play.google.com/store/apps/details?id=com.enationn.enationn',
      subject:
          'https://play.google.com/store/apps/details?id=com.enationn.enationn',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userDataProvider = Provider.of<UserProvider>(context, listen: false);
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
                  Container(
                    // height: 30,
                    // width: 100,
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cruelty_free,
                          color: MyColors.secondaryColor,
                        ),
                        const Text(
                          " 0 ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => _onShare(context),
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
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 35),
                          Row(
                            children: [
                              MyFont()
                                  .fontSize16Bold("General Info", Colors.black),
                              const Spacer(),
                              MyFont().fontSize12Weight700(
                                "UID : ${userDataProvider.uId}",
                                Colors.black,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Visibility(
                            visible: userDataProvider.state == "Null",
                            child: Container(
                              height: 64,
                              width: size.width,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.red,
                                ),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Note ::  Please update your state.",
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    "Personal Info >> Last Drop Down >> Select Your State..",
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const RemarkField(),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              // userDataProvider.removeListener(() {});
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
                                  SizedBox(
                                    width: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyFont().fontSize14Bold(
                                            "Personal Info", Colors.black),
                                        const SizedBox(height: 5),
                                        MyFont().fontSize12Weight500(
                                          "Name : ${userDataProvider.fullName.titleCase}",
                                          Colors.black.withOpacity(0.5),
                                        ),
                                        const SizedBox(height: 2),
                                        MyFont().fontSize12Weight500(
                                          "Email : ${userDataProvider.email}",
                                          Colors.black.withOpacity(0.5),
                                        ),
                                        const SizedBox(height: 2),
                                        MyFont().fontSize12Weight500(
                                          "Branch : ${userDataProvider.branch.titleCase}",
                                          Colors.black.withOpacity(0.5),
                                        ),
                                        const SizedBox(height: 2),
                                        MyFont().fontSize12Weight500(
                                          "College : ${userDataProvider.college.titleCase}",
                                          Colors.black.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
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
                            onTap: () async {
                              LogoutPopups().scaleDialog(context);
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

class RemarkField extends StatefulWidget {
  const RemarkField({super.key});

  @override
  State<RemarkField> createState() => _RemarkFieldState();
}

class _RemarkFieldState extends State<RemarkField> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // height: 50,
          width: size.width,
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: Colors.grey.shade300,
            ),
          ),
          child: Text(
            userProvider.remark == 'Null'
                ? 'Remark : Remark pending...'
                : 'Remark : ${userProvider.remark}',
            style: TextStyle(
              color: userProvider.remark == "Null"
                  ? Colors.amber
                  : MyColors.darkGreyColor,
            ),
          ),
        ),
      ],
    );
  }
}
