// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/EventScreens/event_Screen.dart';
import 'package:enationn/pages/Screens/EventScreens/workShop_Screen.dart';
import 'package:flutter/material.dart';

import 'hackathon_Screen.dart';

enum CategoriesSections {
  hackathon,
  workshop,
  event,
}

class MainEventScreen extends StatefulWidget {
  const MainEventScreen({super.key});

  @override
  State<MainEventScreen> createState() => _MainEventScreenState();
}

class _MainEventScreenState extends State<MainEventScreen> {
  CategoriesSections activeSection = CategoriesSections.hackathon;

  @override
  Widget build(BuildContext context) {
    return Material(
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
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Image.asset(
                "assets/ExtrasScreens/eventScreen.png", scale: 1.5,
                // scale: 1,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: const Text(
                      "Categories",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategorySectionButton(
                        sectionName: "Hackathon",
                        sectionColor: MyColors.primaryColor,
                        isActive: activeSection == CategoriesSections.hackathon
                            ? true
                            : false,
                        onTap: () {
                          setState(() {
                            activeSection = CategoriesSections.hackathon;
                          });
                        },
                      ),
                      CategorySectionButton(
                        sectionName: "Workshop",
                        sectionColor: MyColors.secondaryColor,
                        isActive: activeSection == CategoriesSections.workshop
                            ? true
                            : false,
                        onTap: () {
                          setState(() {
                            activeSection = CategoriesSections.workshop;
                          });
                        },
                      ),
                      CategorySectionButton(
                        sectionName: "Event",
                        sectionColor: MyColors.tealGreenColor,
                        isActive: activeSection == CategoriesSections.event
                            ? true
                            : false,
                        onTap: () {
                          setState(() {
                            activeSection = CategoriesSections.event;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (activeSection == CategoriesSections.hackathon)
                        const HackathonScreen(),
                      if (activeSection == CategoriesSections.workshop)
                        const WorkShopScreen(),
                      if (activeSection == CategoriesSections.event)
                        const EventScreen(),
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
}

class CategorySectionButton extends StatelessWidget {
  const CategorySectionButton({
    super.key,
    required this.sectionName,
    required this.sectionColor,
    required this.isActive,
    required this.onTap,
  });
  final String sectionName;
  final Color sectionColor;
  final bool isActive;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 40,
        width: 105,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: 1,
            color: sectionColor,
          ),
          color: isActive ? sectionColor : Colors.white,
        ),
        child: Text(
          sectionName,
          style: TextStyle(
            color: isActive ? Colors.white : sectionColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
