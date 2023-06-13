import 'package:enationn/ApiMap/APIs/EventEndPoints/internship_api.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PaymentScreens/voucher_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                      widget.internships[widget.index]['date_of_interview'] ??
                          "Not Available",
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
