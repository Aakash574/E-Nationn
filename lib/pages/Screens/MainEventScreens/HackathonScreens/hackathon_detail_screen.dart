import 'dart:developer';

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'hackathon_team_detail_screen.dart';

class HackathonDetailsScreen extends StatefulWidget {
  final int index;
  final List hackathon;
  final bool isApplied;
  const HackathonDetailsScreen({
    super.key,
    required this.index,
    required this.hackathon,
    required this.isApplied,
  });

  @override
  State<HackathonDetailsScreen> createState() => _HackathonDetailsScreenState();
}

class _HackathonDetailsScreenState extends State<HackathonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dateFormat =
        DateTime.parse(widget.hackathon[widget.index]['date_of_hackathon']);
    final dateOfHackathon =
        (DateFormat.yMMMd('en_US').format(dateFormat)).toString();

    final lastDateFormat =
        DateTime.parse(widget.hackathon[widget.index]['last_date_to_apply']);
    final lastDateOfHackathon =
        (DateFormat.yMMMd('en_US').format(lastDateFormat)).toString();

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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.hackathon[widget.index]['image'].toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height - 220,
                  // color: Colors.red,
                  margin: const EdgeInsets.only(top: 220),
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Colors.white,
                  ),
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
                      const SizedBox(height: 5),

                      MyFont().fontSize16Weight500(
                        widget.hackathon[widget.index]['name'],
                        MyColors.darkGreyColor,
                      ),

                      const SizedBox(height: 5),
                      MyFont().fontSize16Weight500(
                        widget.hackathon[widget.index]['title'],
                        Colors.black.withOpacity(0.8),
                      ),

                      const SizedBox(height: 5),
                      MyFont().fontSize14Weight500(
                        widget.hackathon[widget.index]['desc'],
                        MyColors.darkGreyColor.withOpacity(0.8),
                      ),
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    Icons.calendar_month_outlined,
                                    color: MyColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyFont().fontSize16Bold(
                                      dateOfHackathon,
                                      Colors.black,
                                    ),
                                    const SizedBox(height: 5),
                                    MyFont().fontSize14Weight500(
                                      widget.hackathon[widget.index]['time'],
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
                                MyFont().fontSize16Bold(
                                  widget.hackathon[widget.index]['location'],
                                  Colors.black,
                                ),
                                const SizedBox(width: 45),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
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
                                  "Registration Last Date",
                                  Colors.black,
                                ),
                                const SizedBox(height: 5),
                                MyFont().fontSize14Weight500(
                                  lastDateOfHackathon,
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
                                  "Application Status",
                                  Colors.black,
                                ),
                                const SizedBox(height: 5),
                                MyFont().fontSize14Weight500(
                                  widget.isApplied ? "Applied" : "Not Applied",
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
                                        return HackathonTeamDetailsScreen(
                                          index: widget.index,
                                          hackathonDetails: widget.hackathon,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
