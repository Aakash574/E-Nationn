// ignore_for_file: file_names, must_be_immutable

import 'package:enationn/ApiMap/APIs/EventEndPoints/internshipAPI.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PaymentScreens/Payment_Screen.dart';
import 'package:flutter/material.dart';

class InternShipScreen extends StatefulWidget {
  const InternShipScreen({super.key});

  @override
  State<InternShipScreen> createState() => _InternShipScreenState();
}

class _InternShipScreenState extends State<InternShipScreen> {
  List internship = [];

  void eventDetails() async {
    internship = await InternShipApiClient().getInternshipDetails();
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
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height - 90,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: internship.length,
                  itemBuilder: (context, index) => ListTile(
                    title: InkWell(
                      onTap: () {
                        // log(index.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return EventTeamDetailsScreen(
                                index: index,
                                events: internship,
                              );
                            },
                          ),
                        );
                      },
                      child: InternshipSection(
                        internshipName: internship[index]['name'],
                        isApply: internship[index]['apply_status'],
                        internshipDate: internship[index]['date_of_interview'],
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

class EventTeamDetailsScreen extends StatefulWidget {
  final int index;
  List events;
  EventTeamDetailsScreen({
    super.key,
    required this.index,
    required this.events,
  });

  @override
  State<EventTeamDetailsScreen> createState() => _EventTeamDetailsScreenState();
}

class _EventTeamDetailsScreenState extends State<EventTeamDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(24),
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
                  Text(
                    widget.events[widget.index]['name'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
                    Text(
                      "Full Name",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Vinod",
                          hintStyle: TextStyle(
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Text(
                      "Number of Members",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "5",
                                hintStyle: TextStyle(
                                  color: MyColors.primaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: MyColors.primaryColor,
                          )
                        ],
                      ),
                    ),
                    Text(
                      "Team Leader",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ajay Sharma",
                          hintStyle: TextStyle(
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Text(
                      "Phone Number",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "XXXX-XXXX-XX",
                          hintStyle: TextStyle(
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "example@gmail.com",
                          hintStyle: TextStyle(
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PaymentScreen(
                            index: widget.index,
                            details: widget.events,
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
}

class InternshipSection extends StatelessWidget {
  const InternshipSection({
    super.key,
    required this.internshipDate,
    required this.isApply,
    required this.internshipName,
  });

  final String internshipDate;
  final String isApply;
  final String internshipName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width,
          height: 80,
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: MyColors.primaryColor.withOpacity(0.1),
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
                  internshipDate,
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
                      internshipName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: MyColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
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
                          "10:00Am To 12:00Pm",
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
                          "Crtd Technologies",
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
                      isApply == 'yes' ? 'Applied' : 'Not Applied',
                      style: TextStyle(
                        color: isApply == 'yes'
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
        // SizedBox(height: 30),
      ],
    );
  }
}
