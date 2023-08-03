import 'dart:developer';

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/basic_variables_provider.dart';
import '../../provider/user_provider.dart';
import 'voucher_code_screen.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  bool isActive = false;

  forPremium(whatsapp) async {
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  forBaisc(whatsapp) async {
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer2<UserProvider, BasicVariableModel>(
      builder: (context, userProvider, basicVariable, child) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
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
                                      color: MyColors.darkGreyColor
                                          .withOpacity(0.5),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                const Text(
                                  "Select Your Plan Type",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 45,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 280,
                        width: size.width,
                        color: isActive
                            ? MyColors.primaryColor.withOpacity(0.2)
                            : MyColors.secondaryColor.withOpacity(0.2),
                        // color: Colors.red,
                        alignment: Alignment.center,

                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Is Active Status
                                Container(
                                  height: 180,
                                  width: size.width / 2.5,
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 30,
                                    left: 10,
                                    right: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: isActive ? 3 : 1,
                                      color: MyColors.primaryColor,
                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: MyColors.primaryColor
                                            .withOpacity(0.2),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: InkWell(
                                    onTap: () {
                                      basicVariable.setPlan("basic");
                                      log(basicVariable.plan);

                                      setState(() {
                                        isActive = true;
                                      });
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: MyColors.primaryColor
                                                .withOpacity(0.2),
                                          ),
                                          child: Icon(
                                            Icons.star_border_rounded,
                                            color: MyColors.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "Basic\nPlan",
                                          style: TextStyle(
                                            color: MyColors.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 180,
                                      width: size.width / 2.5,
                                      margin: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 30,
                                        left: 10,
                                        right: 10,
                                      ),
                                      // color: Colors.white,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          width: isActive ? 1 : 3,
                                          color: MyColors.secondaryColor,
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 10,
                                            color: MyColors.secondaryColor
                                                .withOpacity(0.2),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      child: InkWell(
                                        onTap: () {
                                          basicVariable.setPlan("premium");
                                          log(basicVariable.plan);

                                          setState(() {
                                            isActive = false;
                                          });
                                        },
                                        child: SizedBox(
                                          width: 180,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: MyColors.secondaryColor
                                                      .withOpacity(0.3),
                                                ),
                                                child: Icon(
                                                  Icons
                                                      .workspace_premium_outlined,
                                                  color:
                                                      MyColors.secondaryColor,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                "Premium\nPlan",
                                                style: TextStyle(
                                                  color:
                                                      MyColors.secondaryColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 70,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: MyColors.secondaryColor,
                                      ),
                                      child: const Text(
                                        "For You",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: MyFont().fontSize14Weight900(
                                "Select Your Subscription Type",
                                MyColors.darkGreyColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 350,
                        margin: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Container(
                              width: size.width / 1.2,
                              height: 124,
                              padding: const EdgeInsets.all(16),
                              // color: Colors.pink,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: isActive
                                      ? MyColors.primaryColor
                                      : MyColors.secondaryColor,
                                ),
                                // color: Colors.amber,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyFont().fontSize14Bold(
                                    isActive ? "Basic Plan" : "Premium Plan",
                                    isActive
                                        ? MyColors.primaryColor
                                        : MyColors.secondaryColor,
                                  ),
                                  const SizedBox(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyFont().fontSize14Bold(
                                        "Eligible For This Plan",
                                        MyColors.darkGreyColor,
                                      ),
                                      Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.green,
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyFont().fontSize14Bold(
                                        "Status",
                                        MyColors.lightGreyColor,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 80,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: !isActive &&
                                                  userProvider.planStatus ==
                                                      'premium'
                                              ? MyColors.secondaryColor
                                              : isActive &&
                                                      userProvider.planStatus ==
                                                          'basic'
                                                  ? MyColors.primaryColor
                                                  : MyColors.lightGreenColor,
                                        ),
                                        child: MyFont().fontSize12Bold(
                                          !isActive &&
                                                  userProvider.planStatus ==
                                                      'premium'
                                              ? "Activated"
                                              : isActive &&
                                                      userProvider.planStatus ==
                                                          'basic'
                                                  ? "Activated"
                                                  : "Eligible",
                                          Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                isActive
                                    ? forBaisc('+919302707264')
                                    : forPremium('+919302707264');
                              },
                              child: Container(
                                height: 64,
                                width: size.width,
                                margin: const EdgeInsets.all(10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: isActive
                                        ? MyColors.primaryColor
                                        : MyColors.secondaryColor,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MyFont().fontSize16Bold(
                                          'For More Enquiry',
                                          MyColors.darkGreyColor,
                                        ),
                                        const SizedBox(height: 5),
                                        MyFont().fontSize12Bold(
                                          '+91 9302707264',
                                          MyColors.lightGreyColor,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const FaIcon(FontAwesomeIcons.angleRight)
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: size.width,
                              height: 56,
                              decoration: BoxDecoration(
                                color: !isActive
                                    ? userProvider.planStatus == 'premium'
                                        ? MyColors.lightGreyColor
                                        : MyColors.primaryColor
                                    : userProvider.planStatus == 'basic'
                                        ? MyColors.lightGreyColor
                                        : MyColors.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  if (isActive) {
                                    basicVariable.setPlan('basic');
                                  } else if (isActive) {
                                    basicVariable.setPlan('premium');
                                  } else {
                                    basicVariable.setPlan('Not Active');
                                  }
                                  log(isActive.toString());
                                  isActive && userProvider.planStatus != 'basic'
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return VoucherCodeScreen(
                                                name: basicVariable.plan ==
                                                        "basic"
                                                    ? "Basic Plan"
                                                    : "Premium Plan",
                                                events: const [],
                                                index: 0,
                                                screen: "PlanScreen",
                                              );
                                            },
                                          ),
                                        )
                                      : !isActive &&
                                              userProvider.planStatus !=
                                                  'premium'
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return VoucherCodeScreen(
                                                    name: basicVariable.plan ==
                                                            "basic"
                                                        ? "Basic Plan"
                                                        : "Premium Plan",
                                                    events: const [],
                                                    index: 0,
                                                    screen: "PlanScreen",
                                                  );
                                                },
                                              ),
                                            )
                                          : log('dkjsfh');
                                },
                                child: MyFont().fontSize16Bold(
                                  !isActive &&
                                          userProvider.planStatus == 'premium'
                                      ? "Activated"
                                      : isActive &&
                                              userProvider.planStatus == 'basic'
                                          ? "Activated"
                                          : "Apply",
                                  Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
