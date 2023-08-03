// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:developer';
import 'dart:math' as math;

import 'package:enationn/const.dart';
import 'package:enationn/src/data/repos/remote/userRepository/user_repository.dart';
import 'package:enationn/src/utils/constants/Strings/branch_string.dart';
import 'package:enationn/src/utils/constants/Strings/college_string.dart';
import 'package:enationn/src/utils/constants/Strings/state_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

import '../../../provider/basic_variables_provider.dart';
import '../../../provider/user_provider.dart';
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

  bool isEmpty = false;
  bool isFound = false;
  bool isPasswordShort = false;
  bool isLoading = false;

  static const List<String> selectGender = <String>[
    'Select Gender',
    'Male',
    'Female'
  ];

  String uId = "";
  String gender = "";
  String state = "Select College State";
  String fathersName = "";
  String branch = "";
  String college = "";
  String dateOfBirth = "";
  String yearOfPassout = "";
  String placeOfBirth = "";
  String internshipStatus = "no";
  String hackathonStatus = "no";
  String eventStatus = "no";
  String genderDropdown = selectGender.first;
  String stateDropDown = ConstantString.selectState.first;
  String collegeDropDown =
      CollegesDetails.stateWiseColleges["Select College State"]!.first;
  String branchDropDown = Branches.branches.first;
  String yearOfPassoutDropDown = CollegesDetails.yearOfPassout.first;
  String placeOfBirthDropDown = ConstantString.selectState.first;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int i = 1;
    log("$i $stateDropDown");
    i += 1;
    log("$i $collegeDropDown");
    i += 1;
    log("$i $branchDropDown");
    i += 1;
    log("$i $yearOfPassoutDropDown");
    i += 1;
    log("$i $placeOfBirthDropDown");
    i += 1;
    log("$i $dateOfBirth");
    i += 1;
    log("$i $genderDropdown");
    i += 1;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final basicVariables = Provider.of<BasicVariableModel>(context);
    final userDataProvider = Provider.of<UserProvider>(context);
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
                    fontSize: 14,
                  ),
                ),

                //! Select State Drop Down ------------------------------------------------------------->

                Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: MyColors.lightGreyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: isEmpty
                          ? stateDropDown == "Select College State"
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
                        MyFont().fontSize14Weight500(
                          stateDropDown.titleCase,
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
                      fontSize: 14,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        stateDropDown = value!;
                        log(state.toString());
                        state = stateDropDown;
                        userDataProvider.setState(state.titleCase);
                      });
                    },
                    items: ConstantString.selectState
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                //! Select Colleges Drop Down ------------------------------------------------------------->

                Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: MyColors.lightGreyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: isEmpty
                          ? collegeDropDown == 'Select College'
                              ? Colors.red
                              : Colors.green
                          : MyColors.primaryColor,
                    ),
                  ),
                  child: DropdownButton<String>(
                    itemHeight: 64,
                    borderRadius: BorderRadius.circular(10),
                    underline: Row(
                      children: [
                        SizedBox(
                          width: size.width / 1.5,
                          child: Text(
                            "${collegeDropDown.titleCase}...",
                            style: TextStyle(
                              color: MyColors.lightGreyColor,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
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
                    elevation: 1,
                    style: TextStyle(
                      color: MyColors.lightGreyColor,
                      fontSize: 14,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        collegeDropDown = value!;
                        college = collegeDropDown;
                        log(college);
                        userDataProvider.setCollege(college.titleCase);
                      });
                    },
                    items: CollegesDetails.stateWiseColleges[state]!
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: size.width / 1.3,
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                //! Select Branch Drop Down ------------------------------------------------------------->

                Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: MyColors.lightGreyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: isEmpty
                          ? branchDropDown == 'Branch*'
                              ? Colors.red
                              : Colors.green
                          : MyColors.primaryColor,
                    ),
                  ),
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    underline: Row(
                      children: [
                        SizedBox(
                          width: size.width / 1.8,
                          child: Text(
                            "${branchDropDown.titleCase}...",
                            style: TextStyle(
                              color: MyColors.lightGreyColor,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
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
                    elevation: 1,
                    style: TextStyle(
                      color: MyColors.lightGreyColor,
                      fontSize: 14,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        branchDropDown = value!;
                        branch = branchDropDown;
                        log(branch);
                        userDataProvider.setBranch(branch.titleCase);
                      });
                    },
                    items: Branches.branches
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: size.width / 1.3,
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                //! Select Year Of Passout Drop Down ------------------------------------------------------------->

                Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: MyColors.lightGreyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: isEmpty
                          ? yearOfPassoutDropDown == 'Year Of Passout'
                              ? Colors.red
                              : Colors.green
                          : MyColors.primaryColor,
                    ),
                  ),
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    underline: Row(
                      children: [
                        SizedBox(
                          width: size.width / 1.8,
                          child: Text(
                            yearOfPassoutDropDown.titleCase,
                            style: TextStyle(
                              color: MyColors.lightGreyColor,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
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
                    elevation: 1,
                    style: TextStyle(
                      color: MyColors.lightGreyColor,
                      fontSize: 14,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        yearOfPassoutDropDown = value!;
                        yearOfPassout = yearOfPassoutDropDown;
                        userDataProvider
                            .setYearOfPassout(yearOfPassout.titleCase);
                      });
                    },
                    items: CollegesDetails.yearOfPassout
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: size.width / 1.3,
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                //! Select Place Of Birth Drop Down ------------------------------------------------------------->

                Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: MyColors.lightGreyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: isEmpty
                          ? placeOfBirthDropDown == 'Place Of Birth*'
                              ? Colors.red
                              : Colors.green
                          : MyColors.primaryColor,
                    ),
                  ),
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    underline: Row(
                      children: [
                        SizedBox(
                          width: size.width / 1.8,
                          child: Text(
                            placeOfBirthDropDown == "Select College State"
                                ? "Place Of Birth"
                                : placeOfBirthDropDown.titleCase,
                            style: TextStyle(
                              color: MyColors.lightGreyColor,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
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
                    elevation: 1,
                    style: TextStyle(
                      color: MyColors.lightGreyColor,
                      fontSize: 14,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        placeOfBirthDropDown = value!;
                        placeOfBirth = placeOfBirthDropDown;

                        userDataProvider
                            .setPlaceOfBirth(placeOfBirth.titleCase);
                      });
                    },
                    items: ConstantString.selectState
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: size.width / 1.3,
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                            hintText: "Date Of Birth",
                            hintStyle: TextStyle(
                              color: MyColors.lightGreyColor,
                              fontSize: 14,
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
                                userDataProvider.setDateOfBirth(
                                    _dateController.text.titleCase);
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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: MyColors.lightGreyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: isEmpty
                          ? genderDropdown == 'SELECT GENDER*'
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
                        MyFont().fontSize14Weight500(
                          genderDropdown.titleCase,
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
                      fontSize: 14,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        genderDropdown = value!;
                        gender = genderDropdown;
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
                      isLoading = true;
                      //* UID Generate...
                      if (_dateController.text.isNotEmpty &&
                          branch != "Select Your Branch" &&
                          yearOfPassout != "Year Of Passout" &&
                          placeOfBirth != "Place Of Birth" &&
                          genderDropdown != "Select Gender" &&
                          state != "Select State" &&
                          college != "Select College") {
                        String uId = "EN101${math.Random().nextInt(99999999)}";
                        userDataProvider.setUID(uId);
                        //* Singup Key Generate...

                        final signUpKey = "EN101${math.Random().nextInt(9999)}";
                        userDataProvider.setSignupKey(signUpKey);
                        userDataProvider.setPlanStatus("Null");
                        //* Settting Basic Variable...

                        basicVariables.setWhichScreen("SignUpScreen");

                        //* Getting User Data...

                        final users = await UserRepository().getUsers();

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
                                  isLoading = false;
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
                        log(branch);
                        log(gender);
                        log(state);
                        log(college);
                        log(_dateController.text);
                        log(placeOfBirth);
                        log(yearOfPassout);
                        log("Field Empty");
                        setState(() {
                          isLoading = false;
                          isEmpty = true;
                        });
                      }
                    },
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: !isLoading
                        ? const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.white,
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
          padding: const EdgeInsets.symmetric(horizontal: 12),
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
                fontSize: 14,
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
          padding: const EdgeInsets.symmetric(horizontal: 12),
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
                fontSize: 14,
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
