import 'package:enationn/Api/constant_Api.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PassCodeScreen/pass_Code_Screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpScreenTwo extends StatefulWidget {
  final String fullName;
  final String email;
  final String password;

  const SignUpScreenTwo({
    super.key,
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  State<SignUpScreenTwo> createState() => _SignUpScreenTwoState();
}

class _SignUpScreenTwoState extends State<SignUpScreenTwo> {
  bool isVisible = false;
  final TextEditingController _dateController = TextEditingController();

  String fathersName = "";
  String branch = "";
  String college = "";
  String dateOfBirth = "";
  String yearOfPassout = "";
  String placeOfBirth = "";

  void userRegisterForm() async {
    await ApiClient().registerUser(
      widget.fullName,
      widget.email,
      widget.password,
      fathersName,
      college,
      branch,
      yearOfPassout,
      dateOfBirth,
      placeOfBirth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Material(
        child: SingleChildScrollView(
          child: InkWell(
            onTap: () {
              setState(() {
                FocusScope.of(context).requestFocus(FocusNode());
              });
            },
            child: Container(
              height: size.height - 100,
              // color: Colors.red,
              margin: const EdgeInsets.all(24),
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
                  // SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SizedBox(height: 50),
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
                      // SizedBox(height: 10),
                      Text(
                        "Please Fill all the details\ncorrectly !!",
                        style: TextStyle(
                          color: MyColors.darkGreyColor,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textFieldForDetails(
                        hintText: "Father's Name",
                        onChange: (newValue) {
                          setState(() {
                            fathersName = newValue;
                          });
                        },
                      ),
                      textFieldForDetails(
                        hintText: "College",
                        onChange: (newValue) {
                          setState(() {
                            college = newValue;
                          });
                        },
                      ),
                      textFieldForDetails(
                        hintText: "Branch",
                        onChange: (newValue) {
                          setState(() {
                            branch = newValue;
                          });
                        },
                      ),
                      textFieldForDetails(
                        hintText: "Year of passout",
                        onChange: (newValue) {
                          setState(() {
                            yearOfPassout = newValue;
                          });
                        },
                      ),
                      Container(
                        // height: 50,
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                          color: MyColors.lightGreyColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _dateController,
                                keyboardType: TextInputType.emailAddress,
                                readOnly: true,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.calendar_month_sharp,
                                    color: MyColors.lightGreyColor,
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Date of birth",
                                  hintStyle: TextStyle(
                                    color: MyColors.lightGreyColor,
                                  ),
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2050),
                                  );
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    setState(() {
                                      _dateController.text = formattedDate;
                                      dateOfBirth = _dateController.text;
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      textFieldForDetails(
                        hintText: "Place of birth",
                        onChange: (newValue) {
                          setState(() {
                            placeOfBirth = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  Container(
                    width: size.width,
                    height: 56,
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: () {
                        userRegisterForm();
                        setState(() {
                          print("Set State Call");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const PassCodeScreen();
                              },
                            ),
                          );
                        });
                      },
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory),
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
      ),
    );
  }

  Container textFieldForDetails({
    required String hintText,
    required Function(String newValue) onChange,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        color: MyColors.lightGreyColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: MyColors.lightGreyColor,
          ),
        ),
        // onTap: () {},
        onChanged: (value) {
          setState(() {});
          onChange(value);
        },
      ),
    );
  }
}
