import 'dart:developer';

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'internship_team_detail_screen.dart';

class InternshipDetailsScreen extends StatefulWidget {
  final int index;
  final List internship;
  final bool isApplied;
  const InternshipDetailsScreen({
    super.key,
    required this.index,
    required this.internship,
    required this.isApplied,
  });

  @override
  State<InternshipDetailsScreen> createState() =>
      _InternshipDetailsScreenState();
}

class _InternshipDetailsScreenState extends State<InternshipDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dateFormat =
        DateTime.parse(widget.internship[widget.index]['date_of_interview']);
    final dateOfInternship =
        (DateFormat.yMMMd('en_US').format(dateFormat)).toString();

    return Material(
      child: SizedBox(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 262,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Logos/TeamLogin.jpg"),
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height - 220,
                  margin: const EdgeInsets.only(top: 220),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 46,
                          height: 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),

                        MyFont().fontSize16Weight500(
                          widget.internship[widget.index]['name'].toString(),
                          MyColors.darkGreyColor,
                        ),

                        const SizedBox(height: 15),
                        MyFont().fontSize16Weight500(
                          widget.internship[widget.index]['title'].toString(),
                          Colors.black.withOpacity(0.8),
                        ),

                        const SizedBox(height: 15),
                        MyFont().fontSize14Weight500(
                          widget.internship[widget.index]['desc'].toString(),
                          MyColors.darkGreyColor.withOpacity(0.8),
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xffE1E9F4),
                                    ),
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      color: MyColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyFont().fontSize16Bold(
                                        dateOfInternship,
                                        Colors.black,
                                      ),
                                      const SizedBox(height: 5),
                                      MyFont().fontSize14Weight500(
                                        widget.internship[widget.index]['time'],
                                        MyColors.lightGreyColor,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 45),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xffE1E9F4),
                                    ),
                                    child: Icon(
                                      Icons.location_on_rounded,
                                      color: MyColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyFont().fontSize16Bold(
                                        "Gala Convention Center",
                                        Colors.black,
                                      ),
                                      const SizedBox(height: 5),
                                      MyFont().fontSize14Weight500(
                                        widget.internship[widget.index]
                                            ['location'],
                                        MyColors.lightGreyColor,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 45),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: 46,
                          height: 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey,
                          ),
                        ),
                        // SizedBox(height: 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                                right: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyFont().fontSize16Weight500(
                                    "Last Registration Date",
                                    Colors.black,
                                  ),
                                  const SizedBox(height: 10),
                                  MyFont().fontSize14Weight500(
                                    widget.internship[widget.index]
                                        ['last_date_to_apply'],
                                    MyColors.lightGreyColor,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                                right: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyFont().fontSize16Weight500(
                                    "Apply Status",
                                    Colors.black,
                                  ),
                                  const SizedBox(height: 10),
                                  MyFont().fontSize14Weight500(
                                    widget.isApplied
                                        ? "Applied"
                                        : "Not Applied",
                                    MyColors.lightGreyColor,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: size.width,
                          height: 56,
                          decoration: BoxDecoration(
                            color: widget.isApplied
                                ? MyColors.lightGreyColor
                                : MyColors.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {
                              widget.isApplied
                                  ? log("Already Applied")
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return InternshipTeamDetailsScreen(
                                            index: widget.index,
                                            internships: widget.internship,
                                          );
                                        },
                                      ),
                                    );
                            },
                            child: MyFont().fontSize16Bold(
                              widget.isApplied ? "Applied" : "Apply",
                              Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
