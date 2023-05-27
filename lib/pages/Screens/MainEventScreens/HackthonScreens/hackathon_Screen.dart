// ignore_for_file: file_names, must_be_immutable

import 'dart:developer';

import 'package:enationn/ApiMap/APIs/EventEndPoints/hackathonAPI.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/MainEventScreens/teamDetailScreen.dart';
import 'package:flutter/material.dart';

class HackathonScreen extends StatefulWidget {
  const HackathonScreen({super.key});

  @override
  State<HackathonScreen> createState() => _HackathonScreenState();
}

class _HackathonScreenState extends State<HackathonScreen> {
  String image = "";
  String name = "";
  String dateOfHackathon = "";
  String lastDateOfHackathon = "";

  List<dynamic> hackathonEventDetails = [];

  void hackathonDetails() async {
    hackathonEventDetails = await HackathonApiClient().getHackathonDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    hackathonDetails();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: SizedBox(
        height: size.height,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: hackathonEventDetails.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => ListTile(
                  // contentPadding: EdgeInsetsGeometry(),
                  title: InkWell(
                    onTap: () {
                      log(index.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return HackathonDetailsScreen(
                              index: index,
                              hackathon: hackathonEventDetails,
                            );
                          },
                        ),
                      );
                    },
                    child: hackathonCardView(
                      size,
                      "hackathonScreen",
                      hackathonEventDetails[index]['name'],
                      hackathonEventDetails[index]['date_of_hackathon']
                          .toString()
                          .substring(0, 2),
                      hackathonEventDetails[index]['apply_status'] == "yes"
                          ? "Applied"
                          : "Not Applied",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container hackathonCardView(
    Size size,
    String image,
    String name,
    String date,
    String isApply,
  ) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: MyColors.primaryColor.withOpacity(0.05),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Image.asset(
                  "assets/ExtrasScreens/$image.png",
                  fit: BoxFit.cover,
                ),
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      margin: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.lightGreyColor.withOpacity(0.9),
                      ),
                      child: Text(
                        date,
                        style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: MyColors.lightGreyColor.withOpacity(0.9),
                      ),
                      child: Icon(
                        Icons.bookmark,
                        color: MyColors.primaryColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: MyColors.tealGreenColor,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "+20 Teams",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff3F38DD),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 18,
                      color: const Color(0xff2B2849).withOpacity(0.5),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "CRTD Technologies",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xff2B2849).withOpacity(0.5),
                        // fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          isApply,
                          style: TextStyle(
                            color: isApply == "Applied"
                                ? MyColors.tealGreenColor
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// On tap of Hackathon Card ------------>

class HackathonDetailsScreen extends StatefulWidget {
  int index;
  List hackathon;
  HackathonDetailsScreen({
    super.key,
    required this.index,
    required this.hackathon,
  });

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
                                      widget.hackathon[widget.index]
                                          ['date_of_hackathon'],
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
                                      widget.hackathon[widget.index]
                                          ['last_date_to_apply'],
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
                                      widget.hackathon[widget.index]['charge'],
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
                                return TeamDetailScreen(
                                  index: widget.index,
                                  hackathonDetails: widget.hackathon,
                                );
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
