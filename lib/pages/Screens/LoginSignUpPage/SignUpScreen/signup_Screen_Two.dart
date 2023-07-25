// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:developer';
import 'dart:math' as math;
import 'package:enationn/ApiMap/APIs/CollegeEndPoints/college_api.dart';
import 'package:enationn/ApiMap/APIs/UserEndPoints/signup_api.dart';
import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../Provider/college_provider.dart';
import '../../PassCodeScreen/pass_Code_Screen.dart';

class SignUpScreenTwo extends StatefulWidget {
  const SignUpScreenTwo({super.key});

  @override
  State<SignUpScreenTwo> createState() => _SignUpScreenTwoState();
}

class _SignUpScreenTwoState extends State<SignUpScreenTwo> {
  bool isVisible = false;

  // For Sign Up ------------>>

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _yearOfPassoutController =
      TextEditingController();
  final TextEditingController _placeOfBirthController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  bool isEmpty = false;
  bool isFound = false;
  bool isPasswordShort = false;

  // For Drop Down ----------->

  static List<String> selectCollege = [
    "College",
  ];

  static const List<String> selectGender = <String>[
    'Select gender*',
    'Male',
    'Female'
  ];
  static const List<String> selectState = [
    "State*",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Lakshadweep",
    "Puducherry"
  ];

  String uId = "";
  String gender = "";
  String state = "";
  String fathersName = "";
  String branch = "";
  String college = "";
  String dateOfBirth = "";
  String yearOfPassout = "";
  String placeOfBirth = "";
  String internshipStatus = "no";
  String hackathonStatus = "no";
  String eventStatus = "no";
  String dropdownValue = selectGender.first;
  String stateDropDown = selectState.first;
  String collegeDropDown = selectCollege.first;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final basicVariables = Provider.of<BasicVariableModel>(context);
    final userDataProvider = Provider.of<UserProvider>(context);
    final collegeProvider = Provider.of<CollegeProvier>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: MyColors.lightGreyColor,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: MyFont().fontSize26Bold(
                        "Enter Your Details",
                        MyColors.primaryColor,
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: MyColors.primaryColor,
                      ),
                      child: Transform.rotate(
                        angle: 4.7,
                        child: const Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Please Fill all the details\ncorrectly !!",
                  style: TextStyle(
                    color: MyColors.darkGreyColor,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final colleges = await CollegeApiClient().getCollege();
                    setState(() {});
                  },
                  child: const Text("Button"),
                ),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: MyColors.lightGreyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: isEmpty
                          ? stateDropDown == 'State*'
                              ? Colors.red
                              : Colors.green
                          : MyColors.primaryColor,
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
                        state = dropdownValue;
                        userDataProvider.setState(state);
                      });
                    },
                    items: selectState
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: MyColors.lightGreyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: isEmpty
                          ? collegeDropDown == 'College*'
                              ? Colors.red
                              : Colors.green
                          : MyColors.primaryColor,
                    ),
                  ),
                  child: DropdownButton<String>(
                    alignment: Alignment.centerRight,
                    borderRadius: BorderRadius.circular(10),
                    underline: Row(
                      children: [
                        MyFont().fontSize16Weight500(
                          collegeDropDown,
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
                        collegeDropDown = value!;
                        college = collegeDropDown;
                        userDataProvider.setCollege(college);
                      });
                    },
                    items: selectCollege
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                TextFieldForDetails(
                  hintText: "Branch",
                  onChange: (newValue) {
                    setState(() {
                      branch = newValue;
                      userDataProvider.setBranch(branch);
                    });
                  },
                  isEmpty: isEmpty,
                  controller: _branchController,
                  textInputType: TextInputType.text,
                ),
                TextFieldForDetails(
                  hintText: "Year of passout",
                  onChange: (newValue) {
                    setState(() {
                      yearOfPassout = newValue;
                      userDataProvider.setYearOfPassout(yearOfPassout);
                    });
                  },
                  isEmpty: isEmpty,
                  controller: _yearOfPassoutController,
                  textInputType: TextInputType.number,
                ),
                TextFieldForDetails(
                  hintText: "Place of birth",
                  onChange: (newValue) {
                    setState(() {
                      placeOfBirth = newValue;
                      userDataProvider.setPlaceOfBirth(placeOfBirth);
                    });
                  },
                  isEmpty: isEmpty,
                  controller: _placeOfBirthController,
                  textInputType: TextInputType.text,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: MyColors.lightGreyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: isEmpty
                          ? _dateController.text.isEmpty
                              ? Colors.red
                              : Colors.green
                          : MyColors.primaryColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _dateController,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.calendar_month_sharp,
                              color: MyColors.lightGreyColor,
                            ),
                            border: InputBorder.none,
                            hintText: "Date of birth*",
                            hintStyle: TextStyle(
                              color: MyColors.lightGreyColor,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            setState(() {
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat.yMMMMd('en_US')
                                        .format(pickedDate);
                                _dateController.text = formattedDate;
                                userDataProvider
                                    .setDateOfBirth(_dateController.text);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: MyColors.lightGreyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: isEmpty
                          ? dropdownValue == 'Select gender*'
                              ? Colors.red
                              : Colors.green
                          : MyColors.primaryColor,
                    ),
                  ),
                  child: DropdownButton<String>(
                    alignment: Alignment.centerRight,
                    borderRadius: BorderRadius.circular(10),
                    underline: Row(
                      children: [
                        MyFont().fontSize16Weight500(
                          dropdownValue,
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
                        dropdownValue = value!;
                        gender = dropdownValue;
                        userDataProvider.setGender(gender);
                      });
                    },
                    items: selectGender
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  width: size.width,
                  height: 56,
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      //* UID Generate...
                      if (_dateController.text.isNotEmpty &&
                          _fatherNameController.text.isNotEmpty &&
                          _branchController.text.isNotEmpty &&
                          _collegeController.text.isNotEmpty &&
                          _yearOfPassoutController.text.isNotEmpty &&
                          _placeOfBirthController.text.isNotEmpty &&
                          _contactController.text.isNotEmpty &&
                          dropdownValue.isNotEmpty) {
                        String uId = "EN101${math.Random().nextInt(99999999)}";
                        userDataProvider.setUID(uId);
                        //* Singup Key Generate...

                        final signUpKey = "EN101${math.Random().nextInt(9999)}";
                        userDataProvider.setSignupKey(signUpKey);
                        //* Settting Basic Variable...

                        basicVariables.setWhichScreen("SignUpScreen");

                        //* Getting User Data...

                        final users = await SignUpApiClient().getUsers();

                        //* Registering User...

                        setState(() {
                          for (var i = 0; i < users.length; i++) {
                            if (users[i]['uid'] != uId) {
                              isFound = true;
                            } else {
                              isFound = false;
                              uId = "EN101${math.Random().nextInt(99999999)}";
                            }
                          }
                          if (isFound) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const PassCodeScreen();
                                },
                              ),
                            );
                          } else {
                            log("Already Exist");
                          }
                          isEmpty = false;
                        });
                      } else {
                        log("Field Empty");
                        setState(() {
                          isEmpty = true;
                        });
                      }
                    },
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

  //? SuccessFully Mail Send --------->

  Column textFieldForDetails({
    required String hintText,
    required Function(String newValue) onChange,
    required bool isEmpty,
    required TextEditingController controller,
    required TextInputType textInputType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 12, right: 12),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: isEmpty
                  ? controller.text.isEmpty
                      ? Colors.red
                      : Colors.green
                  : MyColors.primaryColor,
            ),
            color: MyColors.lightGreyColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            onSubmitted: (value) => TextInputAction.next,
            keyboardType: textInputType,
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "$hintText*",
              hintStyle: TextStyle(
                color: MyColors.lightGreyColor,
                fontSize: 16,
              ),
            ),
            onChanged: (value) {
              setState(() {});
              onChange(value);
            },
          ),
        ),
        const SizedBox(height: 5),
        Container(
          child: isEmpty
              ? controller.text.isEmpty
                  ? const Text(
                      "Field Required *",
                      style: TextStyle(color: Colors.red),
                    )
                  : null
              : null,
        ),
      ],
    );
  }
}

class TextFieldForDetails extends StatefulWidget {
  const TextFieldForDetails({
    super.key,
    required this.hintText,
    required this.onChange,
    required this.isEmpty,
    required this.controller,
    required this.textInputType,
  });
  final String hintText;
  final Function(String newValue) onChange;
  final bool isEmpty;
  final TextEditingController controller;
  final TextInputType textInputType;

  @override
  State<TextFieldForDetails> createState() => _TextFieldForDetailsState();
}

class _TextFieldForDetailsState extends State<TextFieldForDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 12, right: 12),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: widget.isEmpty
                  ? widget.controller.text.isEmpty
                      ? Colors.red
                      : Colors.green
                  : MyColors.primaryColor,
            ),
            color: MyColors.lightGreyColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            onSubmitted: (value) => TextInputAction.next,
            keyboardType: widget.textInputType,
            autofocus: true,
            controller: widget.controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "${widget.hintText}*",
              hintStyle: TextStyle(
                color: MyColors.lightGreyColor,
                fontSize: 16,
              ),
            ),
            onChanged: (value) {
              setState(() {});
              widget.onChange(value);
            },
          ),
        ),
        const SizedBox(height: 5),
        Container(
          child: widget.isEmpty
              ? widget.controller.text.isEmpty
                  ? const Text(
                      "Field Required *",
                      style: TextStyle(color: Colors.red),
                    )
                  : null
              : null,
        ),
      ],
    );
  }
}
