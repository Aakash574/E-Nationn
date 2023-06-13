import 'dart:developer';

import 'package:enationn/ApiMap/APIs/EventEndPoints/event_api.dart';
import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PaymentScreens/voucher_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
