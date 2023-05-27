// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PaymentScreens/plan_Screen.dart';
import 'package:flutter/material.dart';

class PremiumPlanDetailScreen extends StatefulWidget {
  const PremiumPlanDetailScreen({super.key});

  @override
  State<PremiumPlanDetailScreen> createState() =>
      _PremiumPlanDetailScreenState();
}

class _PremiumPlanDetailScreenState extends State<PremiumPlanDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(
                "assets/PaymentScreenImg/paymentScreenBackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Image.asset(
                "assets/ExtrasScreens/planScreen.png",
                scale: 1.5,
              ),
            ),
            Expanded(
              child: Container(
                width: size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "All the best ",
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "Mentors.\n",
                              style: TextStyle(
                                fontSize: 26,
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: "In ",
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "One Place.",
                              style: TextStyle(
                                fontSize: 26,
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: size.width,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/ExtrasScreens/premiumPlanDetailScreen.png",
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: size.width,
                        height: 270,
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.primaryColor.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                              offset: const Offset(5, 5),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: MyFont().fontSize16Weight500(
                                "You are at the best place.  ",
                                MyColors.lightGreyColor,
                              ),
                            ),
                            planDetails(
                              Icons.foundation,
                              "Grounding and Personal Foundation.",
                            ),
                            planDetails(
                              Icons.checklist_rounded,
                              "Preparation and Planning.",
                            ),
                            planDetails(
                              Icons.brightness_auto_outlined,
                              "Negotiate and Initialize.",
                            ),
                            planDetails(
                              Icons.support_agent_outlined,
                              "Support and Enable.",
                            ),
                            planDetails(
                              Icons.celebration_rounded,
                              "Closure and Celebration.",
                            ),
                            planDetails(
                              Icons.bar_chart_rounded,
                              "enabling growth",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width / 1.5,
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const PlanScreen();
                                    },
                                  ),
                                );
                              },
                              child: MyFont()
                                  .fontSize16Bold("Start", Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row planDetails(IconData iconName, String textName) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 10),
          child: Icon(
            iconName,
            color: MyColors.primaryColor,
            size: 24,
          ),
        ),
        MyFont().fontSize12Weight700(
          textName,
          MyColors.darkGreyColor,
        ),
      ],
    );
  }
}
