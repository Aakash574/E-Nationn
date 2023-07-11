// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:developer';
import 'package:enationn/ApiMap/APIs/EventEndPoints/event_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_event_api.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'event_detail_screen.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  List event = [];
  List<dynamic> eventUserData = [];

  Future<void> eventDetails() async {
    event = await EventApiClient().getEventDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    eventDetails();
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
            Expanded(
              flex: 1,
              child: FutureBuilder(
                future: EventApiClient().getEventDetails(),
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
                    return ListView.builder(
                        itemCount: event.length,
                        itemBuilder: (context, index) {
                          if (event[index]['apply_status'] == 'Active') {
                            return ListTile(
                              title: EventSection(
                                index: index,
                                events: event,
                                listLength: index == event.length - 1 ? 20 : 10,
                              ),
                            );
                          } else {
                            return null;
                          }
                        });
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
                        "No Events",
                        MyColors.darkGreyColor,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventSection extends StatefulWidget {
  const EventSection({
    super.key,
    required this.listLength,
    required this.index,
    required this.events,
  });

  final List events;
  final int index;
  final double listLength;

  @override
  State<EventSection> createState() => _EventSectionState();
}

class _EventSectionState extends State<EventSection> {
  var dateDiffrenceInHours;
  var dateDiffrenceInDays;

  String eventDate = "";
  String newDateOfEvent = "";

  List eAccount = [];
  bool isUserApplied = false;

  void getHackathonAccount() async {
    eAccount = await UserEventApiClient().getUserEventDetails();
    setState(() {
      if (!mounted) return;
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      for (var i = 0; i < eAccount.length; i++) {
        if (eAccount[i]['event_name'] == widget.events[widget.index]['name'] &&
            userProvider.uId == eAccount[i]['uniqueid']) {
          isUserApplied = true;
        } else {
          isUserApplied = false;
        }
      }
    });
  }

  void getTimer() {
    final dateOfEvent =
        DateTime.tryParse(widget.events[widget.index]['date_of_event']);

    dateDiffrenceInDays = dateOfEvent?.difference(DateTime.now()).inDays;
    dateDiffrenceInHours = dateOfEvent?.difference(DateTime.now()).inHours;
    eventDate = widget.events[widget.index]['date_of_event'];

    newDateOfEvent =
        (DateFormat.yMMMd('en_US').format(dateOfEvent!)).toString();
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

    return InkWell(
      onTap: dateDiffrenceInHours >= 0
          ? () async {
              if (!mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return EventsDetailScreen(
                      index: widget.index,
                      events: widget.events,
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
              (widget.events[widget.index]['image']).toString().isEmpty
                  ? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png"
                  : widget.events[widget.index]['image'],
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Container(
            width: size.width / 1.2,
            height: 160,
            padding: const EdgeInsets.all(12),
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
                  (widget.events[widget.index]['name'])
                      .toString()
                      .toUpperCase(),
                  MyColors.primaryColor,
                ),
                MyFont().fontSize14Bold(
                  newDateOfEvent,
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
                      widget.events[widget.index]['time'],
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
                      widget.events[widget.index]['location'],
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
    ).animate(delay: 200.ms).fadeIn().moveX(begin: 100);
  }
}
