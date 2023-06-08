import 'dart:core';
import 'dart:developer';
import 'package:enationn/ApiMap/APIs/EventEndPoints/internship_api.dart';
import 'package:enationn/ApiMap/APIs/UserEndPoints/signup_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_event_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_hackathon_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_internship_api.dart';
import 'package:enationn/ApiMap/APIs/VoucherCodeEndPoint/voucher_code_api.dart';
import 'package:enationn/Provider/basic_Variables_Provider.dart';
import 'package:enationn/Provider/hackathon_Provider.dart';
import 'package:enationn/Provider/user_Provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/ExtraScreens/thankyou_Screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  String date = DateFormat("MMMM dd, yyyy").format(DateTime.now());
  final TextEditingController voucherController = TextEditingController();
  double width = 30;

  @override
  void initState() {
    super.initState();
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
                          Container(
                            width: size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.white,
                                  // size: 1,
                                ),
                                Text(
                                  "Lorem ipsum is placeholder text",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 10),
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

                            if (await PaymentVoucherApiClient()
                                .validVoucherCode(voucherController.text)) {
                              log("Which Screen : ${widget.screen}");
                              log(widget.events.toString());

                              switch (widget.screen) {
                                //Event Details Post ----------->

                                case "EventDetailScreen":
                                  log("Event Screen");
                                  final isRegister = await UserEventApiClient()
                                      .eventRegistration(
                                    userDataProvider.fullName,
                                    userDataProvider.email,
                                    userDataProvider.fatherName,
                                    userDataProvider.dateOfBirth,
                                    widget.events[widget.index]
                                        ['date_of_event'],
                                    widget.events[widget.index]['name'],
                                    "active",
                                    "active",
                                    widget.events[widget.index]['charge'],
                                  );
                                  log("Register : ${isRegister.toString()}");
                                  if (isRegister) {
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
                                  break;

                                //InternShip Details Post ----------->

                                case "InternshipDetailScreen":
                                  List internshipData =
                                      await InternShipApiClient()
                                          .getInternshipDetails();

                                  log(internshipData.toString());

                                  log("\n \n Internship Section \n \n");
                                  final isRegister =
                                      await UserInternshipApiClient()
                                          .internshipRegistration(
                                    userDataProvider.fullName,
                                    userDataProvider.college,
                                    userDataProvider.fatherName,
                                    userDataProvider.dateOfBirth,
                                    widget.events[widget.index]
                                        ['date_of_interview'],
                                    widget.events[widget.index]['name'],
                                    "Applied",
                                    "Applied",
                                    widget.events[widget.index]['charge'],
                                  );
                                  log("Register : ${isRegister.toString()}");
                                  if (isRegister) {
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
                                  break;

                                // Hackathon Screen ------------->

                                case "HackathonDetailScreen":
                                  log("Hackathon Screen");
                                  final isRegister =
                                      await UserHackathonApiClient()
                                          .hackathonRegistration(
                                    widget.events[widget.index]['name'],
                                    userDataProvider.fullName,
                                    userDataProvider.email,
                                    hackathonDataProvider.teamName,
                                    hackathonDataProvider.noOfMembers,
                                    hackathonDataProvider.phoneNo,
                                    "Applied",
                                  );
                                  log("Register : ${isRegister.toString()}");
                                  if (isRegister) {
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
                                  break;
                                case "PlanScreen":
                                  final plan = basicVariable.plan;
                                  log(plan);
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

                                  break;
                                default:
                              }
                            }
                            setState(() {});
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
}
