import 'dart:developer';
import 'package:enationn/ApiMap/APIs/EventEndPoints/event_api.dart';
import 'package:enationn/ApiMap/APIs/EventEndPoints/hackathon_api.dart';
import 'package:enationn/ApiMap/APIs/EventEndPoints/internship_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_event_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_hackathon_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_internship_api.dart';
// ignore: unused_import
import 'package:enationn/Provider/hackathon_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventStatusScreen extends StatefulWidget {
  const EventStatusScreen({super.key});

  @override
  State<EventStatusScreen> createState() => _EventStatusScreenState();
}

class _EventStatusScreenState extends State<EventStatusScreen> {
  List userHackathonStatus = [];
  List userInternshipStatus = [];
  List userEventStatus = [];
  List hackathons = [];
  List internships = [];
  List events = [];

  void getUserEventDetails() async {
    userHackathonStatus =
        await UserHackathonApiClient().getUserHackathonDetails();
    userInternshipStatus =
        await UserInternshipApiClient().getUserInternshipData();
    userEventStatus = await UserEventApiClient().getUserEventDetails();

    hackathons = await HackathonApiClient().getHackathonDetails();
    internships = await InternShipApiClient().getInternshipDetails();
    events = await EventApiClient().getEventDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserEventDetails();
  }

  int containerHeight = 72;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: MyColors.lightGreyColor.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  MyFont().fontSize16Bold("Applied Event Status", Colors.black),
                  const SizedBox(
                    width: 45,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AppliedOnEvents(
                userEvents: userHackathonStatus,
                sectionName: "Hackathon",
                title: "Hackathon You Joins",
                events: hackathons,
              ),
              const SizedBox(height: 20),
              AppliedOnEvents(
                userEvents: userInternshipStatus,
                sectionName: "Internships",
                title: "Internships You Joins",
                events: internships,
              ),
              const SizedBox(height: 20),
              AppliedOnEvents(
                userEvents: userEventStatus,
                sectionName: "Events",
                title: "Events You Joins",
                events: events,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------- Main Sections For Event Hackathon And Internships ---->

class AppliedOnEvents extends StatefulWidget {
  const AppliedOnEvents({
    super.key,
    required this.sectionName,
    required this.title,
    required this.userEvents,
    required this.events,
  });

  final List userEvents;
  final List events;
  final String sectionName;
  final String title;

  @override
  State<AppliedOnEvents> createState() => _AppliedOnEventsState();
}

class _AppliedOnEventsState extends State<AppliedOnEvents> {
  List whichSection = ['Internship', 'Events', 'Hackathon'];
  String dateKey = "";
  String nameKey = "";

  void temp() async {
    switch (widget.sectionName) {
      case 'Internships':
        nameKey = 'internship_name';
        dateKey = 'date_of_hackathon';
        log(widget.userEvents.toString());

        break;
      case 'Events':
        nameKey = 'event_name';
        dateKey = 'date_of_hackathon';
        break;
      case 'Hackathon':
        nameKey = 'hackathon_name';
        dateKey = 'date_of_hackathon';
        break;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    temp();
  }

  @override
  Widget build(BuildContext context) {
    final userProivder = Provider.of<UserProvider>(context);

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          width: 1,
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyFont().fontSize14Bold(widget.sectionName, Colors.black),
                  const SizedBox(height: 5),
                  MyFont().fontSize12Weight500(
                    widget.title,
                    Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              const Spacer(),
              widget.userEvents.isNotEmpty
                  ? Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey.shade300,
                    )
                  : Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey.shade300,
                    ),
            ],
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: widget.userEvents.isEmpty ? 0 : 200,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.userEvents.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => widget.userEvents[index]
                                  ['uniqueid'] ==
                              userProivder.uId
                          ? ListTile(
                              contentPadding: EdgeInsetsGeometry.lerp(
                                const EdgeInsets.all(2),
                                const EdgeInsets.all(5),
                                0,
                              ),
                              title: Section(
                                eventDate: widget.userEvents[index][dateKey]
                                    .toString(),
                                eventName: widget.userEvents[index][nameKey]
                                    .toString(),
                              ),
                            )
                          : Container(height: 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------ Hackathon Section Where User Applied --->

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.eventDate,
    required this.eventName,
  });

  final String eventDate;
  final String eventName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MyColors.primaryColor.withOpacity(0.1),
          ),
          child: Row(
            children: [
              Container(
                // width: 72,
                height: 72,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MyFont().fontSize16Bold(
                  eventDate,
                  MyColors.primaryColor,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyFont().fontSize16Bold(eventName, MyColors.primaryColor),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 15,
                        color: MyColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyFont().fontSize10Weight500(
                        "10:00Am To 12:00Pm",
                        MyColors.lightGreyColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 15,
                        color: MyColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyFont().fontSize10Weight500(
                        "Crtd Technologies",
                        MyColors.tealGreenColor,
                      ),
                    ],
                  ),
                  // Container(),
                ],
              ),
              const Spacer(),
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
