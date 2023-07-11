import 'package:enationn/ApiMap/APIs/EventEndPoints/internship_api.dart';
import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../PopScreens/job_code_pop_up.dart';

class InternshipTeamDetailsScreen extends StatefulWidget {
  final int index;
  final List internships;
  const InternshipTeamDetailsScreen({
    super.key,
    required this.index,
    required this.internships,
  });

  @override
  State<InternshipTeamDetailsScreen> createState() =>
      _InternshipTeamDetailsScreenState();
}

class _InternshipTeamDetailsScreenState
    extends State<InternshipTeamDetailsScreen> {
  Map<dynamic, dynamic> internshipsDetails = {};
  bool isLoading = true;
  String internshipBody = "";
  String subject =
      "Congratulations! You've been accepted to our internship program!";

  void getDetails() async {
    // ----- For EVENT DETAILS -------->

    final eventData = await InternShipApiClient().getInternshipDetails();
    if (widget.internships[widget.index]['name'] ==
        eventData[widget.index]['name']) {
      final eventId = eventData[widget.index]['id'];
      internshipsDetails =
          await InternShipApiClient().getInternshipById(eventId);
    }
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserProvider>(context, listen: false);
    final basicVariable =
        Provider.of<BasicVariableModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    internshipBody = """
Hi ${userDataProvider.fullName},\n\n

We're excited to say that you've been accepted to our internship program!\n\n

We'll be sending out more information in the coming weeks, including the start date, schedule, and expectations.\n\n

In the meantime, please feel free to contact us with any questions.\n\n

We can't wait to see you there!\n\n

Sincerely,\n\n

The E-Nationn\n
E-Nationn Team
""";
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: size.height - 100,
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
                      widget.internships[widget.index]['name'].toString(),
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
                        widget.internships[widget.index]['date_of_interview'],
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
                      basicVariable.setWhichScreen('InternshipDetailScreen');
                      _scaleDialog();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return VoucherCodeScreen(
                      //         name: widget.internships[widget.index]['name'],
                      //         events: widget.internships,
                      //         index: widget.index,
                      //         screen: 'InternshipDetailScreen',
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
            jobData: widget.internships,
            body: internshipBody,
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
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
