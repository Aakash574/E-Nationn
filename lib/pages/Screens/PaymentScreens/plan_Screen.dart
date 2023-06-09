// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:developer';
import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'voucher_code_screen.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  bool isActive = false;

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
                                          color: Colors.green,
                                        ),
                                        child: MyFont().fontSize12Bold(
                                          basicVariable.plan == "premium"
                                              ? "Active"
                                              : "Not Eligible",
                                          Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            userProvider.planStatus == "premium"
                                ? Container(
                                    width: size.width / 1.2,
                                    height: 124,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: isActive
                                            ? MyColors.primaryColor
                                            : MyColors.secondaryColor,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyFont().fontSize14Bold(
                                          isActive
                                              ? "Basic Plan"
                                              : "Premium Plan",
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
                                                color: Colors.red,
                                              ),
                                              child: const Icon(
                                                Icons.clear,
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
                                            const Text(
                                              "Status",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 80,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.red,
                                              ),
                                              child: MyFont().fontSize12Bold(
                                                "Not Eligible",
                                                Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            const Spacer(),
                            Container(
                              width: size.width,
                              height: 56,
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor,
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

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return VoucherCodeScreen(
                                          name: basicVariable.plan == "basic"
                                              ? "Basic Plan"
                                              : "Premium Plan",
                                          events: const [],
                                          index: 0,
                                          screen: "PlanScreen",
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: MyFont().fontSize16Bold(
                                  "Apply",
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
