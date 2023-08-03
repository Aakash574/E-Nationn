// ignore_for_file: file_names, prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:developer';

import 'package:enationn/const.dart';
import 'package:enationn/src/data/repos/remote/careerRepository/internship_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../data/repos/remote/userEventRepository/user_internship_repository.dart';
import '../../../provider/user_provider.dart';
import 'internship_detail_screen.dart';

class InternShipScreen extends StatefulWidget {
  const InternShipScreen({super.key});

  @override
  State<InternShipScreen> createState() => _InternShipScreenState();
}

class _InternShipScreenState extends State<InternShipScreen> {
  bool isApplied = false;

  List internship = [];

  Future<void> internshipDetails() async {
    internship = await InternshipRepository().getInternshipDetails();
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: size.height / 1.8,
        child: Column(
          children: [
            FutureBuilder(
              future: InternshipRepository().getInternshipDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  log('Connection State Waiting');
                  return Center(
                    heightFactor: 2.5,
                    child: CircularProgressIndicator(
                      color: MyColors.tealGreenColor,
                      semanticsLabel: "Loading...",
                      semanticsValue: "Loading...",
                      backgroundColor: MyColors.primaryColor,
                      strokeWidth: 4.0,
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  log('Connection State Done');
                  return Expanded(
                    child: ListView.builder(
                        itemCount: internship.length,
                        itemBuilder: (context, index) {
                          if (internship[index]['apply_status'] == 'Active') {
                            return ListTile(
                              title: InternshipSection(
                                index: index,
                                internship: internship,
                                listLength:
                                    index == internship.length - 1 ? 20 : 10,
                              )
                                  .animate(delay: 200.ms)
                                  .fadeIn()
                                  .moveX(begin: 100),
                            );
                          } else {
                            return null;
                          }
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        const FaIcon(FontAwesomeIcons.rotate),
                        MyFont().fontSize16Bold(
                          "Refresh Again",
                          MyColors.darkGreyColor,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: MyFont().fontSize16Bold(
                      "No Internship",
                      MyColors.darkGreyColor,
                    ),
                  );
                }
              },
            ),
          ],
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
  });

  final int index;
  final List internship;
  final double listLength;

  @override
  State<InternshipSection> createState() => _InternshipSectionState();
}

class _InternshipSectionState extends State<InternshipSection> {
  var dateDiffrenceInHours;
  var dateDiffrenceInDays;
  List<dynamic> internshipUserData = [];

  List iAccount = [];
  bool isUserApplied = false;

  void getHackathonAccount() async {
    iAccount = await UserInternshipRepository().getUserInternshipData();
    if (!mounted) return;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    for (var i = 0; i < iAccount.length; i++) {
      if (iAccount[i]['internship_name'] ==
              widget.internship[widget.index]['name'] &&
          userProvider.uId == iAccount[i]['uniqueid']) {
        isUserApplied = true;
        break;
      } else {
        isUserApplied = false;
      }
    }
    setState(() {});
  }

  void getTimer() {
    final dateOfEvent =
        DateTime.tryParse(widget.internship[widget.index]['date_of_interview']);

    dateDiffrenceInDays = dateOfEvent?.difference(DateTime.now()).inDays;
    dateDiffrenceInHours = dateOfEvent?.difference(DateTime.now()).inHours;
  }

  @override
  void initState() {
    super.initState();
    getTimer();
    getHackathonAccount();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dateOfInterview =
        DateTime.parse(widget.internship[widget.index]['date_of_interview']);

    final formattedateOfInterview =
        (DateFormat.yMMMd('en_US').format(dateOfInterview)).toString();

    return InkWell(
      onTap: dateDiffrenceInHours >= 0
          ? () async {
              internshipUserData =
                  await UserInternshipRepository().getUserInternshipData();

              if (!mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return InternshipDetailsScreen(
                      index: widget.index,
                      internship: widget.internship,
                      isApplied: isUserApplied,
                    );
                  },
                ),
              );
            }
          : () {
              Fluttertoast.showToast(
                msg: "Expired",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
      child: Container(
        width: size.width,
        height: 200,
        margin: EdgeInsets.only(top: 10, bottom: widget.listLength),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: dateDiffrenceInHours < 0
                ? const ColorFilter.mode(Colors.black, BlendMode.color)
                : null,
            image: NetworkImage(
              (widget.internship[widget.index]['image']).toString().isEmpty
                  ? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png"
                  : widget.internship[widget.index]['image'],
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Container(
            width: size.width / 1.2,
            height: 160,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.8),
                  Colors.white.withOpacity(0.1)
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyFont().fontSize16Bold(
                  (widget.internship[widget.index]['name'])
                      .toString()
                      .toUpperCase(),
                  MyColors.primaryColor,
                ),
                MyFont().fontSize14Bold(
                  formattedateOfInterview,
                  Colors.black,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: MyColors.primaryColor,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    MyFont().fontSize12Bold(
                      widget.internship[widget.index]['time'],
                      Colors.black,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: MyColors.primaryColor,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    MyFont().fontSize12Bold(
                      widget.internship[widget.index]['location'],
                      Colors.black,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 75,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isUserApplied
                            ? MyColors.primaryColor
                            : const Color.fromARGB(255, 245, 73, 73),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: isUserApplied
                          ? MyFont().fontSize12Bold('Applied', Colors.white)
                          : MyFont()
                              .fontSize12Bold('Not Applied', Colors.white),
                    ),
                    const Spacer(),
                    MyFont().fontSize14Bold(
                      dateDiffrenceInHours! <= 24
                          ? dateDiffrenceInHours < 0
                              ? "Expired"
                              : "${dateDiffrenceInHours.toString()} hours left"
                          : dateDiffrenceInHours != 0
                              ? "${dateDiffrenceInDays.toString()} days left"
                              : "Hackathon Ended",
                      Colors.red,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
