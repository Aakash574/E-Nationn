// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/HackthonScreens/teamDetailScreen.dart';
import 'package:flutter/material.dart';

class HackathonDetailsScreen extends StatefulWidget {
  const HackathonDetailsScreen({super.key});

  @override
  State<HackathonDetailsScreen> createState() => _HackathonDetailsScreenState();
}

class _HackathonDetailsScreenState extends State<HackathonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: SizedBox(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              // alignment: Alignment.center,
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
                        "Code Bite 🏹",
                        MyColors.darkGreyColor,
                      ),

                      const SizedBox(height: 5),
                      MyFont().fontSize16Weight500(
                        "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit,",
                        Colors.black.withOpacity(0.8),
                      ),

                      const SizedBox(height: 5),
                      MyFont().fontSize14Weight500(
                        "Lorem ipsum dolor sit amet, onsectrs iscing elit,\nsed do eiusmo tempor incididun labore et dolore\nmagna aliqua. Ut enim ad minim veniam, quis\nnostrud int occaecat upidatat non proident, sunt\nin culpa qui officia serunt mollit anim id est\nlaborum.",
                        MyColors.darkGreyColor.withOpacity(0.8),
                      ),
                      const SizedBox(height: 5),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyFont().fontSize16Bold(
                                      "14 April, 2023",
                                      Colors.black,
                                    ),
                                    const SizedBox(height: 5),
                                    MyFont().fontSize14Weight500(
                                      "Tuesday, 4:00PM - 9:00PM",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyFont().fontSize16Bold(
                                      "Gala Convention Center",
                                      Colors.black,
                                    ),
                                    const SizedBox(height: 5),
                                    MyFont().fontSize14Weight500(
                                      "Bhopal Smart City",
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
                      Row(
                        children: [
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
                                      "Members",
                                      Colors.black,
                                    ),
                                    const SizedBox(height: 5),
                                    MyFont().fontSize14Weight500(
                                      "5",
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
                                      "Last Registratioin Date",
                                      Colors.black,
                                    ),
                                    const SizedBox(height: 5),
                                    MyFont().fontSize14Weight500(
                                      "20 Mar 2023",
                                      MyColors.lightGreyColor,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyFont().fontSize16Weight500(
                                      "Charge",
                                      Colors.black,
                                    ),
                                    const SizedBox(height: 5),
                                    MyFont().fontSize14Weight500(
                                      "RS-XXX",
                                      MyColors.lightGreyColor,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyFont().fontSize16Weight500(
                                      "Lore ipasumn",
                                      Colors.black,
                                    ),
                                    const SizedBox(height: 5),
                                    MyFont().fontSize14Weight500(
                                      "sit mart",
                                      MyColors.lightGreyColor,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: size.width,
                        height: 56,
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const TeamDetailScreen();
                              },
                            ));
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
          ],
        ),
      ),
    );
  }
}
