import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/Provider/hackathon_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../PopScreens/job_code_pop_up.dart';

class HackathonTeamDetailsScreen extends StatefulWidget {
  final int index;
  final List hackathonDetails;
  const HackathonTeamDetailsScreen({
    super.key,
    required this.index,
    required this.hackathonDetails,
  });

  @override
  State<HackathonTeamDetailsScreen> createState() =>
      _HackathonTeamDetailsScreenState();
}

class _HackathonTeamDetailsScreenState
    extends State<HackathonTeamDetailsScreen> {
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _noOfMemberController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool isEmpty = false;
  bool isVisible = false;
  String hackathonBody = "";
  String subject = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);
    final basicVariable = Provider.of<BasicVariableModel>(context);
    final hackathonProvider = Provider.of<HackathonProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            // height: size.height - 100,
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
                      widget.hackathonDetails[widget.index]['name'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Team Leader : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: MyColors.darkGreyColor,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            userProvider.fullName,
                            style: TextStyle(
                              color: MyColors.secondPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Email : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: MyColors.darkGreyColor,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            userProvider.email,
                            style: TextStyle(
                              color: MyColors.secondPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Phone : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: MyColors.darkGreyColor,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            userProvider.contact,
                            style: TextStyle(
                              color: MyColors.secondPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isEmpty ? Colors.red : MyColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _teamNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Team Name",
                            labelStyle: TextStyle(
                              color: MyColors.secondPrimaryColor,
                              fontSize: 16,
                            ),
                            hintText: "Coder",
                            hintStyle: TextStyle(
                              color: MyColors.lightGreyColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          onChanged: (value) {
                            // hackathonProvider.setTeamName(value);
                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xffF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isEmpty ? Colors.red : MyColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _noOfMemberController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "No of members",
                            labelStyle: TextStyle(
                              color: MyColors.secondPrimaryColor,
                              fontSize: 16,
                            ),
                            hintText: "0",
                            hintStyle: TextStyle(
                              color: MyColors.lightGreyColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              hackathonProvider.setNoOfMembers(value);
                            });
                          },
                        ),
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
                      setState(() {
                        hackathonProvider.setTeamName(_teamNameController.text);
                        hackathonProvider
                            .setNoOfMembers(_noOfMemberController.text);
                        hackathonProvider.setPhoneNo(_phoneController.text);
                        hackathonProvider.setUniqueId(userProvider.uId);
                        basicVariable.setWhichScreen('HackathonDetailScreen');

                        if (_teamNameController.text.isNotEmpty &&
                            _noOfMemberController.text.isNotEmpty) {
                          subject = "Congratulations! You're in!";

                          hackathonBody = """
Hi ${userProvider.fullName},\n\n

We're excited to say that you've been accepted to the ${widget.hackathonDetails[widget.index]['hackathon_name']} Hackathon!\n\n

The hackathon will be held on ${widget.hackathonDetails[widget.index]['date_of_hackathon']} at ${widget.hackathonDetails[widget.index]['location']}. To confirm your attendance, please RSVP by ${widget.hackathonDetails[widget.index]['date_of_hackathon']} .\n\n

We'll be sending out more information in the coming weeks, including the schedule, speakers, and prizes.\n\n

In the meantime, please feel free to contact us with any questions.\n\n

We can't wait to see you there!\n\n

Sincerely,\n\n

The ${widget.hackathonDetails[widget.index]['hackathon_name']}\n
E-Nationn Team
""";
                          _scaleDialog();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return VoucherCodeScreen(
                          //         name: widget.hackathonDetails[widget.index]
                          //             ['name'],
                          //         events: widget.hackathonDetails,
                          //         index: widget.index,
                          //         screen: 'HackathonDetailScreen',
                          //       );
                          //     },
                          //   ),
                          // );
                          isEmpty = false;
                        } else {
                          isEmpty = true;
                        }
                      });
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
            jobData: widget.hackathonDetails,
            body: hackathonBody,
            subject: subject,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
