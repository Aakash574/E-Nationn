// ignore_for_file: file_names

import 'package:enationn/ApiMap/APIs/JobEndPoints/job_api.dart';
import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/Dashboard/MainJobs/Fresher/fresher_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Experience/experience_section.dart';
import 'Interns/intern_section.dart';

enum CategoriesSections {
  fresher,
  intern,
  experience,
}

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  CategoriesSections activeSection = CategoriesSections.fresher;
  List jobs = [];

  void getData() async {
    jobs = await JobsApiClient().getJobsData();
  }

  @override
  void initState() {
    super.initState();
    getData();
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
                MyFont().fontSize18Bold("Jobs", Colors.black),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategorySectionButton(
                      sectionName: "Fresher",
                      sectionColor: MyColors.primaryColor,
                      isActive: activeSection == CategoriesSections.fresher
                          ? true
                          : false,
                      onTap: () {
                        setState(() {
                          activeSection = CategoriesSections.fresher;
                        });
                      },
                    ),
                    CategorySectionButton(
                      sectionName: "Intern",
                      sectionColor: MyColors.secondaryColor,
                      isActive: activeSection == CategoriesSections.intern
                          ? true
                          : false,
                      onTap: () {
                        setState(() {
                          activeSection = CategoriesSections.intern;
                        });
                      },
                    ),
                    CategorySectionButton(
                      sectionName: "Experiance",
                      sectionColor: MyColors.tealGreenColor,
                      isActive: activeSection == CategoriesSections.experience
                          ? true
                          : false,
                      onTap: () {
                        setState(() {
                          activeSection = CategoriesSections.experience;
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
                    if (activeSection == CategoriesSections.fresher)
                      const FrasherSection(),
                    if (activeSection == CategoriesSections.intern)
                      const InternSection(),
                    if (activeSection == CategoriesSections.experience)
                      const ExperianceSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
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
