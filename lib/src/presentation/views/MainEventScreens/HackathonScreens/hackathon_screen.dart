// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:developer';

import 'package:enationn/const.dart';
import 'package:enationn/src/data/repos/remote/careerRepository/hackathon_repository.dart';
import 'package:enationn/src/data/repos/remote/userEventRepository/user_hackathon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import 'hackathon_detail_screen.dart';

class HackathonScreen extends StatefulWidget {
  const HackathonScreen({super.key});

  @override
  State<HackathonScreen> createState() => _HackathonScreenState();
}

class _HackathonScreenState extends State<HackathonScreen> {
  bool isApplied = false;

  List<dynamic> hackathonDetail = [];
  List<dynamic> hackathonUserData = [];

  Future<void> hackathonDetails() async {
    hackathonDetail = await HackathonRepository().getHackathonDetails();
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
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: size.height / 1.8,
            child: Column(
              children: <Widget>[
                FutureBuilder(
                  future: HackathonRepository().getHackathonDetails(),
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
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      log('Connection State Done');
                      return Expanded(
                        child: ListView.builder(
                            itemCount: hackathonDetail.length,
                            itemBuilder: (context, index) {
                              if (hackathonDetail[index]['apply_status'] ==
                                  'Active') {
                                return ListTile(
                                  title: HackathonSection(
                                    index: index,
                                    hackathons: hackathonDetail,
                                    isApplied: isApplied,
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
                    } else {
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
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HackathonSection extends StatefulWidget {
  HackathonSection({
    super.key,
    required this.index,
    required this.hackathons,
    required this.isApplied,
  });
  final int index;
  final List hackathons;
  bool isApplied;

  @override
  State<HackathonSection> createState() => _HackathonSectionState();
}

class _HackathonSectionState extends State<HackathonSection> {
  List hAccount = [];
  bool isUserApplied = false;

  var dateDiffrenceInHours;
  var dateDiffrenceInDays;

  List<dynamic> hackathonUserData = [];

  void getHackathonAccount() async {
    hAccount = await UserHackathonRepository().getUserHackathonDetails();
    if (!mounted) return;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    for (var i = 0; i < hAccount.length; i++) {
      if (hAccount[i]['hackathon_name'] ==
              widget.hackathons[widget.index]['name'] &&
          userProvider.uId == hAccount[i]['uniqueid']) {
        isUserApplied = true;
        break;
      }
    }
  }

  void getTimer() {
    final dateOfHackathon =
        DateTime.tryParse(widget.hackathons[widget.index]['date_of_hackathon']);

    dateDiffrenceInDays = dateOfHackathon?.difference(DateTime.now()).inDays;
    dateDiffrenceInHours = dateOfHackathon?.difference(DateTime.now()).inHours;
  }

  @override
  void initState() {
    super.initState();
    getHackathonAccount();
    getTimer();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final dateOfHackathon =
        DateTime.parse(widget.hackathons[widget.index]['date_of_hackathon']);
    final formattedateOfHackathon =
        (DateFormat.yMMMd('en_US').format(dateOfHackathon)).toString();

    return InkWell(
      onTap: dateDiffrenceInHours >= 0
          ? () async {
              hackathonUserData =
                  await UserHackathonRepository().getUserHackathonDetails();

              final l1 = hackathonUserData.length;

              for (var i = 0; i < l1; i++) {
                if (widget.hackathons[widget.index]['name'] ==
                        hackathonUserData[i]['hackathon_name'] &&
                    hackathonUserData[i]['uniqueid'] == userProvider.uId) {
                  widget.isApplied = true;
                  setState(() {});
                  break;
                } else {
                  widget.isApplied = false;
                  setState(() {});
                }
              }

              if (!mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return HackathonDetailsScreen(
                      index: widget.index,
                      hackathon: widget.hackathons,
                      isApplied: widget.isApplied,
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
        margin: EdgeInsets.only(
          top: 8,
          right: 8,
          left: 8,
          bottom: widget.index == widget.hackathons.length - 1 ? 84 : 0,
        ),
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
                  Image.network(
                    (widget.hackathons[widget.index]['image'])
                            .toString()
                            .isEmpty
                        ? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png"
                        : widget.hackathons[widget.index]['image'],
                    fit: BoxFit.cover,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        margin: const EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.lightGreyColor.withOpacity(0.9),
                        ),
                        child: Text(
                          formattedateOfHackathon,
                          style: TextStyle(
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
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
                  Row(
                    children: [
                      Text(
                        widget.hackathons[widget.index]['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      MyFont().fontSize14Bold(
                        dateDiffrenceInHours! <= 24
                            ? dateDiffrenceInHours <= 0
                                ? "Expired"
                                : "${dateDiffrenceInHours.toString()} hours left"
                            : dateDiffrenceInHours != 0
                                ? "${dateDiffrenceInDays.toString()} days left"
                                : "Hackathon Ended",
                        Colors.red,
                      )
                    ],
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
                      Text(
                        "+${widget.hackathons.length.toString()}",
                        style: const TextStyle(
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
                        widget.hackathons[widget.index]['location'],
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
                            isUserApplied ? "Applied" : "Not Applied",
                            style: TextStyle(
                              color: isUserApplied
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
      ),
    );
  }
}
