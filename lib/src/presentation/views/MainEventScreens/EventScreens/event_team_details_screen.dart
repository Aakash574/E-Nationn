import 'dart:developer';

import 'package:enationn/src/data/repos/remote/careerRepository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../const.dart';
import '../../../provider/basic_variables_provider.dart';
import '../../../provider/user_provider.dart';
import '../../PopScreens/job_code_pop_up.dart';

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
  String body = "";
  String subject = "";

  void getDetails() async {
    // ----- For EVENT DETAILS -------->

    final eventData = await EventRepository().getEventDetails();
    if (widget.event[widget.index]['name'] == eventData[widget.index]['name']) {
      final eventId = eventData[widget.index]['id'];
      eventDetails = await EventRepository().getEventById(eventId);
    }
    if (!mounted) return;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    subject =
        "Congratulations! You're registered for ${widget.event[widget.index]['name']}!";
    body = """
Hi ${userProvider.fullName},\n\n

We're excited to say that you've been registered for ${widget.event[widget.index]['name']}!\n\n

The event will be held on ${widget.event[widget.index]['date_of_event']} at ${widget.event[widget.index]['location']}. To confirm your attendance, please RSVP by ${widget.event[widget.index]['date_of_event']}.\n\n

We'll be sending out more information in the coming weeks, including the schedule, speakers, and activities.\n\n

In the meantime, please feel free to contact us with any questions.\n\n

We can't wait to see you there!\n\n
\n
Sincerely,\n

The ${widget.event[widget.index]['name']}\n
E-Nationn Team
""";
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: size.height - 100,
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
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: () {
                      log(screen.whichScreen.toString());
                      screen.setWhichScreen('EventDetailScreen');
                      _scaleDialog();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return JobCodePopUp(
                      //         jobData: widget.event,
                      //         index: widget.index,
                      //         body: body,
                      //         subject: subject,
                      //       );
                      //     },
                      //   ),
                      // );
                    },
                    style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory),
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
      ),
    );
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
          child: JobCodePopUp(
            index: widget.index,
            jobData: widget.event,
            body: body,
            subject: subject,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  Widget userDetailField(
    String fieldName,
    String data,
    Size size,
  ) {
    return Container(
      height: 64,
      width: size.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyFont().fontSize14Bold(
            "$fieldName : ",
            MyColors.darkGreyColor.withAlpha(100),
          ),
          const Spacer(),
          SizedBox(
            width: 190,
            child: Text(
              data,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.darkGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
