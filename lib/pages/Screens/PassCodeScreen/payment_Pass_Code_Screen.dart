// ignore_for_file: use_build_context_synchronously

import 'package:enationn/ApiMap/APIs/UserEndPoints/passkey_api.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/ExtraScreens/thankyou_Screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentPassCodeScreen extends StatefulWidget {
  const PaymentPassCodeScreen({super.key});

  @override
  State<PaymentPassCodeScreen> createState() => _PaymentPassCodeScreenState();
}

class _PaymentPassCodeScreenState extends State<PaymentPassCodeScreen> {
  bool isActive = false;
  final keyIsFirstLoaded = 'is_first_loaded';

  List<String> pinCode = [];
  bool error = false;
  void showDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool(keyIsFirstLoaded);

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
    return Material(
      child: Container(
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
                passCodeField(
                    pinCode.isNotEmpty ? MyColors.primaryColor : Colors.white),
                passCodeField(
                    pinCode.length >= 2 ? MyColors.primaryColor : Colors.white),
                passCodeField(
                    pinCode.length >= 3 ? MyColors.primaryColor : Colors.white),
                passCodeField(
                    pinCode.length >= 4 ? MyColors.primaryColor : Colors.white),
                passCodeField(
                    pinCode.length >= 5 ? MyColors.primaryColor : Colors.white),
              ],
            ),
            SizedBox(
              child: Container(
                height: 420,
                width: 300,
                margin: const EdgeInsets.only(top: 20),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 20,
                    mainAxisExtent: 88,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    if (index + 1 == 11) {
                      return passCodeEnterNumbers(
                        nums: "0",
                        // onTap: () {},
                      );
                    }
                    if (index + 1 == 12) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (pinCode.isNotEmpty) {
                              pinCode.removeLast();
                            }
                          });
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
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                if (pinCode.length == 5 &&
                    await PasskeyApiClient().passkey(pinCode.join("")) ==
                        true) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        // if()
                        return const ThankyouScreen();
                      },
                    ),
                    (route) => false,
                  );
                } else {
                  setState(() {
                    error = true;
                    pinCode.clear();
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
    );
  }

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
}
