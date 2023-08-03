// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:enationn/src/data/repos/remote/meetRepository/basic_meet_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/basic_variables_provider.dart';
import 'Basic/basic_section.dart';
import 'Premium/premium_section.dart';

enum CategoriesSections {
  basic,
  premium,
}

class MeetScreen extends StatefulWidget {
  const MeetScreen({super.key});

  @override
  State<MeetScreen> createState() => _MeetScreenState();
}

class _MeetScreenState extends State<MeetScreen> {
  CategoriesSections activeSection = CategoriesSections.basic;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final basicVariable = Provider.of<BasicVariableModel>(context);
    return Expanded(
      child: Column(
        children: [
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.primaryColor,
                      ),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          basicVariable.setDashboardIndex(0);
                          setState(() {});
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                MyFont().fontSize18Bold("Meets", Colors.black),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CategorySectionButton(
                      sectionName: "Basic",
                      sectionColor: MyColors.primaryColor,
                      isActive: activeSection == CategoriesSections.basic
                          ? true
                          : false,
                      onTap: () {
                        setState(() {
                          activeSection = CategoriesSections.basic;
                        });
                      },
                    ),
                    CategorySectionButton(
                      sectionName: "Premium",
                      sectionColor: MyColors.secondaryColor,
                      isActive: activeSection == CategoriesSections.premium
                          ? true
                          : false,
                      onTap: () {
                        setState(() {
                          activeSection = CategoriesSections.premium;
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
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (activeSection == CategoriesSections.basic)
                      const BasicSection(),
                    if (activeSection == CategoriesSections.premium)
                      const PremiumSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Object> futureCall() async {
    return await BasicMeetRepository().getMeetData();
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
