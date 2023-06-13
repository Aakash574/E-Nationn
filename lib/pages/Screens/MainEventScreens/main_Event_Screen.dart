// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';

import 'EventScreens/event_screen.dart';
import 'HackathonScreens/hackathon_screen.dart';
import 'InternShipScreens/internship_screen.dart';

enum CategoriesSections {
  hackathon,
  internship,
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(
              "assets/PaymentScreenImg/paymentScreenBackground.png",
            ),
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: Colors.white),
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyFont().fontSize18Bold("Categories", Colors.black),
                  const SizedBox(height: 15),
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
                        sectionName: "Internship",
                        sectionColor: MyColors.secondaryColor,
                        isActive: activeSection == CategoriesSections.internship
                            ? true
                            : false,
                        onTap: () {
                          setState(() {
                            activeSection = CategoriesSections.internship;
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
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (activeSection == CategoriesSections.hackathon)
                        const HackathonScreen(),
                      if (activeSection == CategoriesSections.internship)
                        const InternShipScreen(),
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
