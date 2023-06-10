// ignore_for_file: file_names

import 'dart:developer';
import 'package:enationn/ApiMap/APIs/EventEndPoints/event_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_event_api.dart';
import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PaymentScreens/voucher_code_screen.dart';
import 'package:enationn/pages/Screens/PopScreens/already_applied.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    event = await EventApiClient().getEventDetails();
    setState(() {});
  }

  void _scaleDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: const AlreadyApplied(),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  void initState() {
    super.initState();
    eventDetails();

    setState(() {});
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
                            child: EventSection(
                              events: event,
                              index: index,
                              listLength: index == event.length - 1 ? 300 : 0,
                              // isApplyColor: Colors.red,
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

class EventSection extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width,
          height: 200,
          margin: EdgeInsets.only(top: 20, bottom: listLength),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                events[index]['image'].toString(),
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // color: MyColors.primaryColor,
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
                    events[index]['date_of_event'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        events[index]['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
                            events[index]['time'],
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
                            events[index]['location'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xff2B2849).withOpacity(0.5),
                              // fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      // Container(),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        // events[index]['apply_status'],
                        events[index]['apply_status'] == 'Available'
                            ? 'Available'
                            : 'Not Available',
                        style: TextStyle(
                          color: events[index]['apply_status'] == 'Available'
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
        ),
        // SizedBox(height: 30),
      ],
    );
  }
}

class EventTeamDetailsScreen extends StatefulWidget {
  const EventTeamDetailsScreen({
    super.key,
    required this.index,
    required this.event,
  });
  final int index;
  final List event;

  @override
  State<EventTeamDetailsScreen> createState() => _EventTeamDetailsScreenState();
}

class _EventTeamDetailsScreenState extends State<EventTeamDetailsScreen> {
  Map<dynamic, dynamic> eventDetails = {};

  bool isLoading = true;

  void getDetails() async {
    // ----- For EVENT DETAILS -------->

    final eventData = await EventApiClient().getEventDetails();
    if (widget.event[widget.index]['name'] == eventData[widget.index]['name']) {
      final eventId = eventData[widget.index]['id'];
      eventDetails = await EventApiClient().getEventById(eventId);
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserProvider>(context, listen: false);
    final screen = Provider.of<BasicVariableModel>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xff6B7280).withOpacity(0.2),
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
                  MyFont().fontSize16Bold(
                    widget.event[widget.index]['name'],
                    Colors.black,
                  ),
                  const SizedBox(
                    width: 45,
                  ),
                ],
              ),
              SizedBox(
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userDetailField(
                      "Full Name",
                      userDataProvider.fullName,
                      size,
                    ),
                    userDetailField(
                      "College Name",
                      userDataProvider.college,
                      size,
                    ),
                    userDetailField(
                      "Father Name",
                      userDataProvider.fatherName,
                      size,
                    ),
                    userDetailField(
                      "Date Of Birth",
                      userDataProvider.dateOfBirth,
                      size,
                    ),
                    userDetailField(
                      "Date Of Event",
                      eventDetails['date_of_event'].toString(),
                      size,
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width / 1.5,
                height: 56,
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {
                    log(screen.whichScreen.toString());

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return VoucherCodeScreen(
                            name: widget.event[widget.index]['name'],
                            events: widget.event,
                            index: widget.index,
                            screen: 'EventDetailScreen',
                          );
                        },
                      ),
                    );
                  },
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

  Widget userDetailField(
    String fieldName,
    String data,
    Size size,
  ) {
    return Container(
      height: 54,
      width: size.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          MyFont().fontSize16Bold(
            "$fieldName : ",
            MyColors.darkGreyColor.withAlpha(100),
          ),
          const Spacer(),
          MyFont().fontSize14Bold(
            data.toUpperCase().toString(),
            MyColors.darkGreyColor,
          ),
        ],
      ),
    );
  }
}

class EventsDetailScreen extends StatefulWidget {
  final int index;
  final List events;
  final bool isApplied;
  const EventsDetailScreen({
    super.key,
    required this.index,
    required this.events,
    required this.isApplied,
  });

  @override
  State<EventsDetailScreen> createState() => _EventsDetailScreenState();
}

class _EventsDetailScreenState extends State<EventsDetailScreen> {
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.events[widget.index]['image'].toString(),
                      ),
                      fit: BoxFit.cover,
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
                          widget.events[widget.index]['name'].toString(),
                          MyColors.darkGreyColor,
                        ),

                        const SizedBox(height: 15),
                        MyFont().fontSize16Weight500(
                          widget.events[widget.index]['title'].toString(),
                          Colors.black.withOpacity(0.8),
                        ),

                        const SizedBox(height: 15),
                        MyFont().fontSize14Weight500(
                          widget.events[widget.index]['desc'].toString(),
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
                                        widget.events[widget.index]
                                            ['date_of_event'],
                                        Colors.black,
                                      ),
                                      const SizedBox(height: 15),
                                      MyFont().fontSize14Weight500(
                                        widget.events[widget.index]['time'],
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
                                      const SizedBox(height: 15),
                                      MyFont().fontSize14Weight500(
                                        widget.events[widget.index]['location'],
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
                                  const SizedBox(height: 15),
                                  MyFont().fontSize14Weight500(
                                    widget.events[widget.index]
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
                                  const SizedBox(height: 15),
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
                                          return EventTeamDetailsScreen(
                                            index: widget.index,
                                            event: widget.events,
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
