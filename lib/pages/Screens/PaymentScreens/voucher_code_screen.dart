// ignore_for_file: use_build_context_synchronously

import 'dart:core';
import 'dart:developer';
import 'package:enationn/ApiMap/APIs/EventEndPoints/internship_api.dart';
import 'package:enationn/ApiMap/APIs/UserEndPoints/basickey.dart';
import 'package:enationn/ApiMap/APIs/UserEndPoints/signup_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_event_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_hackathon_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_internship_api.dart';
import 'package:enationn/ApiMap/APIs/VoucherCodeEndPoint/voucher_code_api.dart';
import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/Provider/hackathon_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Customs/sendEmail.dart';
import 'package:enationn/pages/Screens/ExtraScreens/thankyou_Screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../ApiMap/APIs/UserEndPoints/premiumkey.dart';

class VoucherCodeScreen extends StatefulWidget {
  const VoucherCodeScreen({
    super.key,
    required this.name,
    required this.events,
    required this.index,
    required this.screen,
  });

  final String name;
  final List events;
  final int index;
  final String screen;

  @override
  State<VoucherCodeScreen> createState() => _VoucherCodeScreenState();
}

class _VoucherCodeScreenState extends State<VoucherCodeScreen> {
  // Date ->
  String date = DateFormat("MMMM dd, yyyy").format(DateTime.now());

  //Controllers --->
  final TextEditingController voucherController = TextEditingController();

  // Local Variables -->
  double width = 30;
  bool isValid = false;
  String eventBody = "";
  String internshipBody = "";
  String hackathonBody = "";

  //? Send Successfully Registration Email

  void sendEmail(String name) {
    hackathonBody = """
Hi $name,

We're excited to say that you've been accepted to the ${widget.name} Hackathon!

The hackathon will be held on ${widget.events[widget.index]['date_of_hackathon']} at ${widget.events[widget.index]['location']}. To confirm your attendance, please RSVP by ${widget.events[widget.index]['date_of_hackathon']} .

We'll be sending out more information in the coming weeks, including the schedule, speakers, and prizes.

In the meantime, please feel free to contact us with any questions.

We can't wait to see you there!

Sincerely,

The ${widget.name} 
E-Nationn Team
""";

    internshipBody = """
Hi $name,

We're excited to say that you've been accepted to our internship program!

We'll be sending out more information in the coming weeks, including the start date, schedule, and expectations.

In the meantime, please feel free to contact us with any questions.

We can't wait to see you there!

Sincerely,

The E-Nationn
E-Nationn Team
""";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final basicVariable =
        Provider.of<BasicVariableModel>(context, listen: false);
    final userDataProvider = Provider.of<UserProvider>(context, listen: false);
    final hackathonDataProvider =
        Provider.of<HackathonProvider>(context, listen: false);

    return SafeArea(
      child: Material(
        color: MyColors.primaryColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage(
                      "assets/PaymentScreenImg/paymentScreenBlueBackground.png",
                    ),
                    scale: 5,
                    fit: BoxFit.fitWidth,
                  ),
                  // color: Colors.green,
                ),
                child: Container(
                  height: size.width * 2 - 100,
                  margin: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.withOpacity(0.2),
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
                      Column(
                        children: [
                          Image.asset(
                            "assets/PaymentScreenImg/paymentLogo.png",
                            scale: 2,
                          ),
                          MyFont().fontSize26Bold(
                            widget.name,
                            Colors.white,
                          ),
                          const SizedBox(height: 10),
                          MyFont().fontSize14Weight500(
                            "Payment on $date",
                            Colors.white,
                          ),
                          const SizedBox(height: 70),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 1,
                                color: isValid
                                    ? Colors.red
                                    : MyColors.tealGreenColor,
                              ),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: voucherController,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Voucher Code",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(height: 20),
                          isValid
                              ? Container(
                                  width: size.width - 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.warning_amber_rounded,
                                        color: MyColors.secondaryColor,
                                        // size: 1,
                                      ),
                                      Text(
                                        "Please enter valid voucher code.",
                                        style: TextStyle(
                                          color: MyColors.secondaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                )
                              : Container(
                                  width: size.width - 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.warning_amber_rounded,
                                        color: MyColors.secondaryColor,
                                        // size: 1,
                                      ),
                                      Text(
                                        "Please Enter voucher code.",
                                        style: TextStyle(
                                          color: MyColors.tealGreenColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                      Container(
                        width: size.width,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            // ------Validating Voucher ------->
                            if (userDataProvider.planStatus != 'premium' &&
                                userDataProvider.planStatus != 'basic') {
                              log("message");
                              if (await PaymentVoucherApiClient()
                                  .validVoucherCode(voucherController.text)) {
                                log("Which Screen : ${widget.screen}");
                                log(widget.events.toString());

                                switch (widget.screen) {
                                  //Event Details Post ----------->

                                  case "EventDetailScreen":
                                    eventStatus(userDataProvider);
                                    break;

                                  //InternShip Details Post ----------->

                                  case "InternshipDetailScreen":
                                    internshipStatus(userDataProvider);
                                    break;

                                  // Hackathon Screen ------------->

                                  case "HackathonDetailScreen":
                                    hackathonStatus(hackathonDataProvider,
                                        userDataProvider);
                                    break;
                                  case "PlanScreen":
                                    planStatus(userDataProvider, basicVariable);
                                    break;
                                  default:
                                }
                              } else {
                                voucherController.clear();
                                log("Error");
                                isValid = true;
                              }
                              setState(() {});
                            } else {
                              switch (userDataProvider.planStatus) {
                                case 'basic':
                                  log("Premium Voucher Code");
                                  if (await PremiumPasskeyApiClient()
                                      .passkey(voucherController.text)) {
                                    planStatus(userDataProvider, basicVariable);
                                  }
                                  break;

                                case 'premium':
                                  log("Basic Voucher Code");
                                  if (await BasicPasskeyApiClient()
                                      .passkey(voucherController.text)) {
                                    planStatus(userDataProvider, basicVariable);
                                  }
                                  break;
                              }
                            }
                          },
                          style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: MyFont().fontSize16Bold(
                            "Apply Code",
                            MyColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //? Event Function------------------->

  void eventStatus(UserProvider userDataProvider) async {
    log("Event Screen");
    log(widget.events[widget.index]['date_of_event']);
    sendEmail(userDataProvider.fullName);
    final isRegister = await UserEventApiClient().eventRegistration(
      userDataProvider.fullName,
      userDataProvider.email,
      userDataProvider.fatherName,
      userDataProvider.dateOfBirth,
      widget.events[widget.index]['date_of_event'],
      widget.events[widget.index]['name'],
      "Applied",
      "Applied",
      widget.events[widget.index]['charge'],
      userDataProvider.uId,
    );
    log("Register : ${isRegister.toString()}");
    if (isRegister) {
      log("Registered ");
      SendEmail.sendEmail(
        context,
        "Congratulations! You're registered for ${widget.name}!",
        eventBody,
        userDataProvider.email,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ThankyouScreen();
          },
        ),
      );
    } else {
      log("Please Try Again");
    }
  }

  //? Hackathon Function------------------->

  void hackathonStatus(HackathonProvider hackathonDataProvider,
      UserProvider userDataProvider) async {
    log("Hackathon Screen");
    sendEmail(userDataProvider.fullName);
    final isRegister = await UserHackathonApiClient().hackathonRegistration(
      widget.events[widget.index]['name'],
      userDataProvider.fullName,
      userDataProvider.email,
      hackathonDataProvider.teamName,
      hackathonDataProvider.noOfMembers,
      hackathonDataProvider.phoneNo,
      "Applied",
      "Applied",
      userDataProvider.uId,
    );
    log("Register : ${isRegister.toString()}");
    if (isRegister) {
      SendEmail.sendEmail(
        context,
        "Congratulations! You're in!",
        hackathonBody,
        userDataProvider.email,
      );
      log("Registered ");
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ThankyouScreen();
          },
        ),
      );
    } else {
      log("Please Try Again");
    }
  }

  //? Internship Function------------------->

  void internshipStatus(UserProvider userDataProvider) async {
    sendEmail(userDataProvider.fullName);
    List internshipData = await InternShipApiClient().getInternshipDetails();

    log(internshipData.toString());

    log("\n \n Internship Section \n \n");
    final isRegister = await UserInternshipApiClient().internshipRegistration(
      userDataProvider.fullName,
      userDataProvider.college,
      userDataProvider.fatherName,
      userDataProvider.dateOfBirth,
      widget.events[widget.index]['date_of_interview'],
      widget.events[widget.index]['name'],
      "Applied",
      "Applied",
      widget.events[widget.index]['charge'],
      userDataProvider.uId,
    );
    log("Register : ${isRegister.toString()}");
    if (isRegister) {
      SendEmail.sendEmail(
        context,
        "Congratulations! You've been accepted to our internship program!",
        internshipBody,
        userDataProvider.email,
      );
      log("Registered ");
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ThankyouScreen();
          },
        ),
      );
    } else {
      log("Please Try Again");
    }
  }

  //? Plan Function -------->

  void planStatus(
    UserProvider userDataProvider,
    BasicVariableModel basicVariable,
  ) {
    final plan = basicVariable.plan;
    log(plan.toString());
    if (plan != "basic") {
      SignUpApiClient().updateDetails(
        'plan_status',
        'premium',
        userDataProvider.id.toString(),
        userDataProvider.email,
      );
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) {
            return const ThankyouScreen();
          },
        ),
        (route) => false,
      );
    } else {
      SignUpApiClient().updateDetails(
        'plan_status',
        'basic',
        userDataProvider.id,
        userDataProvider.email,
      );
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) {
            return const ThankyouScreen();
          },
        ),
        (route) => false,
      );
    }
  }
}
