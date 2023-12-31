// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => PersonalInfoScreenState();
}

class PersonalInfoScreenState extends State<PersonalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            height: size.height - 100,
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
                    MyFont().fontSize16Bold("Edit Profile", Colors.black),
                    const SizedBox(
                      width: 45,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                        width: 3,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MyFont().fontSize16Bold(
                  userDataProvider.fullName,
                  Colors.black,
                ),
                const SizedBox(height: 3),
                MyFont().fontSize12Weight500(
                  "UID : ${userDataProvider.uId}",
                  Colors.black.withOpacity(0.5),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
                const SizedBox(height: 20),
                fieldForUserCredential(
                  size,
                  userDataProvider.fullName,
                  "Full Name",
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    fieldForUserCredential(
                      size / 2.4,
                      "Male",
                      "Gender",
                    ),
                    fieldForUserCredential(
                      size / 2.4,
                      userDataProvider.dateOfBirth,
                      "Date of Birth",
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                fieldForUserCredential(
                  size,
                  userDataProvider.email,
                  "Email",
                ),
                const SizedBox(height: 20),
                fieldForUserCredential(
                  size,
                  "@${userDataProvider.fullName}",
                  "User Name",
                ),
                const Spacer(),
                Container(
                  width: size.width,
                  height: 56,
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: () async {},
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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

  Container fieldForUserCredential(Size size, String data, String fieldName) {
    return Container(
      height: 60,
      width: size.width,
      // color: Colors.red,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyFont().fontSize12Weight500(
            fieldName,
            Colors.grey.withOpacity(0.8),
          ),
          MyFont().fontSize14Bold(
            data,
            Colors.black,
          ),
        ],
      ),
    );
    // SizedBox(height: 10),
  }
}
