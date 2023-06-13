// ignore_for_file: file_names

import 'dart:async';
import 'package:enationn/ApiMap/APIs/EventEndPoints/event_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_event_api.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'event_detail_screen.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool isApplied = false;

  List event = [];
  List<dynamic> eventUserData = [];

  Future<void> eventDetails() async {
    if (mounted) {
      event = await EventApiClient().getEventDetails();
    }
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height - 90,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: RefreshIndicator(
                  color: MyColors.primaryColor,
                  onRefresh: eventDetails,
                  child: ListView.builder(
                    itemCount: event.length,
                    itemBuilder: (context, index) => ListTile(
                      title: event.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              child: MyFont().fontSize16Bold(
                                "Hackathon Not Available...",
                                Colors.black45,
                              ),
                            )
                          : InkWell(
                              onTap: () async {
                                eventUserData = await UserEventApiClient()
                                    .getUserEventDetails();

                                final l1 = eventUserData.length;

                                for (var i = 0; i < l1; i++) {
                                  if (event[index]['name'] ==
                                          eventUserData[i]['event_name'] &&
                                      eventUserData[i]['uniqueid'] ==
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
                                      return EventsDetailScreen(
                                        index: index,
                                        events: event,
                                        isApplied: isApplied,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: FutureBuilder(
                                future: EventApiClient().getEventDetails(),
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
                                    return EventSection(
                                      events: event,
                                      index: index,
                                      listLength:
                                          index == event.length - 1 ? 300 : 0,
                                      // isApplyColor: Colors.red,
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

  void getTimer() {
    final dateOfEvent =
        DateTime.tryParse(widget.events[widget.index]['date_of_event']);

    dateDiffrenceInDays = dateOfEvent?.difference(DateTime.now()).inDays;
    dateDiffrenceInHours = dateOfEvent?.difference(DateTime.now()).inHours;
    eventDate = widget.events[widget.index]['date_of_event'];

    newDateOfEvent =
        (DateFormat.yMMMd('en_US').format(dateOfEvent!)).toString();

    setState(() {});
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
          height: 200,
          margin: EdgeInsets.only(top: 20, bottom: widget.listLength),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                (widget.events[widget.index]['image']).toString().isEmpty
                    ? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png"
                    : widget.events[widget.index]['image'],
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: size.width,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // color: MyColors.primaryColor,
              color: Colors.white.withAlpha(1000),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    newDateOfEvent,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width / 1.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.events[widget.index]['name'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            TweenAnimationBuilder<Duration>(
                              duration: Duration(hours: dateDiffrenceInHours),
                              tween: Tween(
                                begin: Duration(hours: dateDiffrenceInHours),
                                end: Duration.zero,
                              ),
                              builder: (context, value, child) {
                                return MyFont().fontSize14Bold(
                                  dateDiffrenceInHours <= 24
                                      ? "${dateDiffrenceInHours.toString()} hours left"
                                      : "${dateDiffrenceInDays.toString()} days left",
                                  Colors.red,
                                );
                              },
                            ),
                          ],
                        ),
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
                            widget.events[widget.index]['time'],
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
                      SizedBox(
                        width: size.width / 1.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 15,
                                  color:
                                      const Color(0xff2B2849).withOpacity(0.5),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.events[widget.index]['location'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xff2B2849)
                                        .withOpacity(0.5),
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              // margin: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    // events[index]['apply_status'],
                                    widget.events[widget.index]
                                                ['apply_status'] ==
                                            'Available'
                                        ? 'Available'
                                        : 'Not Available',
                                    style: TextStyle(
                                      color: widget.events[widget.index]
                                                  ['apply_status'] ==
                                              'Available'
                                          ? MyColors.tealGreenColor
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(),
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
