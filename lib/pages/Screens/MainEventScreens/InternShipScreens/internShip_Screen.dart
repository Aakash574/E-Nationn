import 'package:enationn/ApiMap/APIs/EventEndPoints/internship_api.dart';
import 'package:enationn/Provider/user_Provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PaymentScreens/voucher_Code_Screen.dart';
import 'package:enationn/pages/Screens/PopScreens/already_applied.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InternShipScreen extends StatefulWidget {
  const InternShipScreen({super.key});

  @override
  State<InternShipScreen> createState() => _InternShipScreenState();
}

class _InternShipScreenState extends State<InternShipScreen> {
  List internship = [];

  void internshipDetails() async {
    internship = await InternShipApiClient().getInternshipDetails();
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
    internshipDetails();
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
                        if (internship[index]['apply_status'] == 'active') {
                          _scaleDialog();
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return EventTeamDetailsScreen(
                                  index: index,
                                  internships: internship,
                                );
                              },
                            ),
                          );
                        }
                      },
                      child: InternshipSection(
                        index: index,
                        internship: internship,
                        listLength: index == internship.length - 1 ? 300 : 0,
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
  final List internships;
  const EventTeamDetailsScreen({
    super.key,
    required this.index,
    required this.internships,
  });

  @override
  State<EventTeamDetailsScreen> createState() => _EventTeamDetailsScreenState();
}

class _EventTeamDetailsScreenState extends State<EventTeamDetailsScreen> {
  Map<dynamic, dynamic> internshipsDetails = {};
  bool isLoading = true;

  void getDetails() async {
    // ----- For EVENT DETAILS -------->

    final eventData = await InternShipApiClient().getInternshipDetails();
    if (widget.internships[widget.index]['name'] ==
        eventData[widget.index]['name']) {
      final eventId = eventData[widget.index]['id'];
      internshipsDetails =
          await InternShipApiClient().getInternshipById(eventId);
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
                    internshipsDetails['name'].toString(),
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
                      "Date Of Interview",
                      internshipsDetails['date_of_interview'] ??
                          "Not Available",
                      size,
                    ),
                    userDetailField(
                      "Price",
                      internshipsDetails['charge'].toString(),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return VoucherCodeScreen(
                            name: widget.internships[widget.index]['name'],
                            events: widget.internships,
                            index: widget.index,
                            screen: 'InternshipDetailScreen',
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Logos/TeamLogin.jpg"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            // color: MyColors.primaryColor.withOpacity(0.5),
          ),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
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
                  width: 80,
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
                    widget.internship[widget.index]['date_of_interview'],
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
                        widget.internship[widget.index]['name'],
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
                        widget.internship[widget.index]['apply_status'] ==
                                'active'
                            ? "Applied"
                            : "Not Applied",
                        style: TextStyle(
                          color: widget.internship[widget.index]
                                      ['apply_status'] ==
                                  'active'
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
