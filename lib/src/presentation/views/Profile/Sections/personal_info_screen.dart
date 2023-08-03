// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:enationn/src/data/repos/remote/userRepository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/constants/Strings/state_strings.dart';
import '../../../provider/user_provider.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => PersonalInfoScreenState();
}

class PersonalInfoScreenState extends State<PersonalInfoScreen> {
  String state = "";
  String stateDropDown = ConstantString.selectState.first;

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
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
                      const SizedBox(width: 45),
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
                    userDataProvider.fullName.titleCase,
                    Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyFont().fontSize12Weight500(
                        "UID : ${userDataProvider.uId}",
                        Colors.black.withOpacity(0.5),
                      ),
                      IconButton(
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: userDataProvider.uId),
                          );
                        },
                        icon: Icon(
                          Icons.copy,
                          size: 12,
                          color: MyColors.darkGreyColor,
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    fieldForUserCredential(
                      size,
                      userDataProvider.fullName.titleCase,
                      "Full Name",
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        fieldForUserCredential(
                          size / 2.4,
                          userDataProvider.gender.titleCase,
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
                      userDataProvider.contact,
                      "Phone No.",
                    ),
                    const SizedBox(height: 20),
                    fieldForUserCredential(
                      size,
                      userDataProvider.email.toString(),
                      "Email",
                    ),
                    const SizedBox(height: 20),
                    fieldForUserCredential(
                      size,
                      userDataProvider.branch.titleCase,
                      "Branch",
                    ),
                    const SizedBox(height: 20),
                    fieldForUserCredential(
                      size,
                      userDataProvider.college.titleCase,
                      "College",
                    ),
                    const SizedBox(height: 20),
                    fieldForUserCredential(
                      size,
                      userDataProvider.yearOfPassout,
                      "Year of passout",
                    ),
                    const SizedBox(height: 20),
                    fieldForUserCredential(
                      size,
                      userDataProvider.fatherName.titleCase,
                      "Father's Name",
                    ),
                    const SizedBox(height: 20),
                    userDataProvider.state == 'Null'
                        ? Container(
                            height: 60,
                            width: size.width,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            child: DropdownButton<String>(
                              alignment: Alignment.centerRight,
                              borderRadius: BorderRadius.circular(10),
                              underline: Row(
                                children: [
                                  MyFont().fontSize16Weight500(
                                    stateDropDown,
                                    MyColors.lightGreyColor,
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.arrow_drop_down_rounded,
                                    size: 32,
                                    color: MyColors.lightGreyColor,
                                  ),
                                ],
                              ),
                              iconSize: 0.0,
                              elevation: 16,
                              style: TextStyle(
                                color: MyColors.lightGreyColor,
                                fontSize: 16,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  stateDropDown = value!;
                                  state = stateDropDown;
                                  userDataProvider.setState(state);
                                  UserRepository().updateDetails(
                                    'state',
                                    state,
                                    userDataProvider.id,
                                    userDataProvider.email,
                                  );
                                });
                              },
                              items: ConstantString.selectState
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )
                        : fieldForUserCredential(
                            size,
                            userDataProvider.state.titleCase,
                            "State",
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 30,
              thickness: 1.5,
            ),
            GestureDetector(
              onTap: () {
                _updateDataRequest(userDataProvider);
              },
              child: Container(
                height: 64,
                width: size.width - 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: MyFont()
                    .fontSize16Bold("Request for Update Data", Colors.white),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Container fieldForUserCredential(
    Size size,
    String data,
    String fieldName,
  ) {
    return Container(
      height: 60,
      width: size.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Column(
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
          const Spacer(),
        ],
      ),
    );
  }

  void _updateDataRequest(UserProvider userProvider) async {
    final url = Uri.parse(
        'mailto:support@enationn.com?subject="Request For Update User Data of ${userProvider.uId}"&body=\nUId :: ${userProvider.uId}\nName :: ${userProvider.fullName}\nCollege :: ${userProvider.college}\nPhone :: ${userProvider.contact}\nState :: ${userProvider.state} \n\nPlease mention what do you want to update in this format ::\n Email -> Current Email\n Update Email -> New Email.\n\n\n Note :: Do not provide false data or request. \n Thankyou');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
