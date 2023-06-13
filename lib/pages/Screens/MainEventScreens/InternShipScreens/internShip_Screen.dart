// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:enationn/ApiMap/APIs/EventEndPoints/internship_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_internship_api.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'internship_detail_screen.dart';

class InternShipScreen extends StatefulWidget {
  const InternShipScreen({super.key});

  @override
  State<InternShipScreen> createState() => _InternShipScreenState();
}

class _InternShipScreenState extends State<InternShipScreen> {
  bool isApplied = false;

  List internship = [];
  List<dynamic> internshipUserData = [];

  Future<void> internshipDetails() async {
    if (mounted) {
      internship = await InternShipApiClient().getInternshipDetails();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    internshipDetails();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height - 90,
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  color: MyColors.primaryColor,
                  onRefresh: internshipDetails,
                  child: ListView.builder(
                    itemCount: internship.length,
                    itemBuilder: (context, index) => ListTile(
                      title: internship.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              child: MyFont().fontSize16Bold(
                                "Hackathon Not Available...",
                                Colors.black45,
                              ),
                            )
                          : InkWell(
                              onTap: () async {
                                internshipUserData =
                                    await UserInternshipApiClient()
                                        .getUserInternshipData();

                                final l1 = internshipUserData.length;

                                for (var i = 0; i < l1; i++) {
                                  if (internship[index]['name'] ==
                                          internshipUserData[i]
                                              ['internship_name'] &&
                                      internshipUserData[i]['uniqueid'] ==
                                          userProvider.uId) {
                                    isApplied = true;
                                    setState(() {});
                                    break;
                                  } else {
                                    isApplied = false;
                                    setState(() {});
                                  }
                                }

                                if (!mounted) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return InternshipDetailsScreen(
                                        index: index,
                                        internship: internship,
                                        isApplied: isApplied,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: FutureBuilder(
                                future: InternShipApiClient()
                                    .getInternshipDetails(),
                                builder: (ctx, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: MyColors.tealGreenColor,
                                        semanticsLabel: "Loading...",
                                        semanticsValue: "Loading...",
                                        backgroundColor: MyColors.primaryColor,
                                        strokeWidth: 4.0,
                                      ),
                                    );
                                  } else {
                                    return InternshipSection(
                                      index: index,
                                      internship: internship,
                                      isApplied: isApplied,
                                      listLength: index == internship.length - 1
                                          ? 300
                                          : 0,
                                    );
                                  }
                                },
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InternshipSection extends StatefulWidget {
  const InternshipSection({
    super.key,
    required this.index,
    required this.internship,
    required this.listLength,
    required this.isApplied,
  });

  final int index;
  final List internship;
  final double listLength;
  final bool isApplied;

  @override
  State<InternshipSection> createState() => _InternshipSectionState();
}

class _InternshipSectionState extends State<InternshipSection> {
  var dateDiffrenceInHours;
  var dateDiffrenceInDays;
  String eventDate = "";
  String year = "";
  String month = "";
  String day = "";

  void getTimer() {
    final dateOfEvent =
        DateTime.tryParse(widget.internship[widget.index]['date_of_interview']);

    dateDiffrenceInDays = dateOfEvent?.difference(DateTime.now()).inDays;
    dateDiffrenceInHours = dateOfEvent?.difference(DateTime.now()).inHours;
    eventDate = widget.internship[widget.index]['date_of_interview'];
    final date = DateTime.parse(eventDate);
    year = date.year.toString();
    month = date.month.toString();
    day = date.day.toString();
    switch (month) {
      case "1":
        month = 'Jan';
        break;
      case "2":
        month = 'Feb';
        break;
      case "3":
        month = 'Mar';
        break;
      case "4":
        month = 'Apr';
        break;
      case "5":
        month = 'May';
        break;
      case "6":
        month = 'Jun';
        break;
      case "7":
        month = 'July';
        break;
      case "8":
        month = 'Aug';
        break;
      case "9":
        month = 'Sept';
        break;
      case "10":
        month = 'Oct';
        break;
      case "11":
        month = 'Nov';
        break;
      case "12":
        month = 'Dec';
        break;

      default:
    }
  }

  @override
  void initState() {
    super.initState();
    getTimer();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width,
          height: 200,
          margin: EdgeInsets.only(top: 20, bottom: widget.listLength),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                (widget.internship[widget.index]['image']).toString().isEmpty
                    ? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png"
                    : widget.internship[widget.index]['image'],
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            // height: 80,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white.withAlpha(1000),
            ),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                    color: MyColors.primaryColor,
                  ),
                ),
                Container(
                  width: 70,
                  height: 80,
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                    border: Border.all(width: 1, color: MyColors.primaryColor),
                    color: Colors.white,
                    // color: Colors.blue,
                  ),
                  child: Text(
                    "$day $month\n$year",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  width: 270,
                  height: 80,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.internship[widget.index]['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          MyFont().fontSize14Bold(
                            dateDiffrenceInHours <= 24
                                ? "${dateDiffrenceInHours.toString()} hours left"
                                : "${dateDiffrenceInDays.toString()} days left",
                            Colors.red,
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            size: 15,
                            color: const Color(0xff2B2849).withOpacity(0.5),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.internship[widget.index]['time'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xff2B2849).withOpacity(0.5),
                              // fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 15,
                            color: const Color(0xff2B2849).withOpacity(0.5),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.internship[widget.index]['location'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xff2B2849).withOpacity(0.5),
                              // fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            widget.isApplied ? "Applied" : "Not Applied",
                            style: TextStyle(
                              color: widget.isApplied
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
                ),
              ],
            ),
          ),
        ),
        // SizedBox(height: 30),
      ],
    );
  }
}
