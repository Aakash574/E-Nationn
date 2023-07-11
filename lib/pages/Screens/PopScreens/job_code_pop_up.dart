// ignore_for_file: file_names

import 'dart:developer';

import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ApiMap/APIs/EventEndPoints/internship_api.dart';
import '../../../ApiMap/APIs/UserEventEndPoints/user_event_api.dart';
import '../../../ApiMap/APIs/UserEventEndPoints/user_hackathon_api.dart';
import '../../../ApiMap/APIs/UserEventEndPoints/user_internship_api.dart';
import '../../../Provider/hackathon_provider.dart';
import '../../Customs/sendEmail.dart';
import '../ExtraScreens/thankyou_Screen.dart';

class JobCodePopUp extends StatefulWidget {
  const JobCodePopUp({
    super.key,
    required this.jobData,
    required this.index,
    required this.body,
    required this.subject,
  });
  final List jobData;
  final int index;
  final String body;
  final String subject;

  @override
  State<JobCodePopUp> createState() => _JobCodePopUpState();
}

class _JobCodePopUpState extends State<JobCodePopUp> {
  bool isValid = true;

  final TextEditingController _jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final basicVariable = Provider.of<BasicVariableModel>(context);
    final hackathonDataProvider = Provider.of<HackathonProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => Navigator.pop(context),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: SizedBox(
            height: size.height / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Enter your job code.",
                  style: TextStyle(
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.height / 50,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      basicVariable.setJobCode(value);
                    });
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  controller: _jobController,
                  decoration: InputDecoration(
                    hintText: 'Ex. 12345',
                    label: Text(
                      'Job Code',
                      style: TextStyle(color: MyColors.primaryColor),
                    ),
                    hintStyle:
                        TextStyle(color: MyColors.darkGreyColor, fontSize: 14),
                    alignLabelWithHint: true,
                    errorText: isValid ? null : 'Invalid Job Code!',
                    errorBorder: isValid
                        ? null
                        : const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    log("message");
                    // log(widget.jobData[widget.index]['name_of_job']);
                    if (widget.jobData[widget.index]['job_code'] ==
                        _jobController.text) {
                      log(widget.jobData.toString());

                      switch (basicVariable.whichScreen) {
                        //Event Details Post ----------->

                        case "EventDetailScreen":
                          eventStatus(
                            basicVariable,
                            userProvider,
                          );
                          break;

                        //InternShip Details Post ----------->

                        case "InternshipDetailScreen":
                          internshipStatus(
                            basicVariable,
                            userProvider,
                          );
                          break;

                        // Hackathon Screen ------------->

                        case "HackathonDetailScreen":
                          hackathonStatus(
                            basicVariable,
                            hackathonDataProvider,
                            userProvider,
                          );
                          break;
                        case "JobScreen":
                          jobStatus(
                            basicVariable,
                            userProvider,
                          );
                          break;
                        default:
                      }
                    } else {
                      setState(() {
                        _jobController.clear();
                        log("Error");
                        isValid = false;
                      });
                    }
                  },
                  child: Container(
                    width: size.width / 2,
                    height: size.height / 15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Apply Code",
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
  //? Job Function------------------->

  void jobStatus(basicVariable, userProvider) async {
    if (!mounted) return;
    SendEmail().sendMail(
      basicVariable,
      userProvider,
      widget.body,
      widget.subject,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ThankyouScreen(),
      ),
    );
    isValid = true;
  }

  //? Event Function------------------->

  void eventStatus(
    BasicVariableModel basicVariable,
    UserProvider userDataProvider,
  ) async {
    log("Event Screen");
    log(widget.jobData[widget.index]['date_of_event']);
    final isRegister = await UserEventApiClient().eventRegistration(
      userDataProvider.fullName,
      userDataProvider.email,
      userDataProvider.fatherName,
      userDataProvider.dateOfBirth,
      widget.jobData[widget.index]['date_of_event'],
      widget.jobData[widget.index]['name'],
      "Applied",
      "Applied",
      widget.jobData[widget.index]['charge'],
      userDataProvider.uId,
    );
    log("Register : ${isRegister.toString()}");
    if (isRegister) {
      log("Registered ");
      if (!mounted) return;
      SendEmail().sendMail(
        basicVariable,
        userDataProvider,
        widget.body,
        widget.subject,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ThankyouScreen();
          },
        ),
      );
    } else {
      log("Please Try Again");
    }
  }

  //? Hackathon Function------------------->

  void hackathonStatus(
    basicVariable,
    HackathonProvider hackathonDataProvider,
    UserProvider userDataProvider,
  ) async {
    log("Hackathon Screen");
    final isRegister = await UserHackathonApiClient().hackathonRegistration(
      widget.jobData[widget.index]['name'],
      userDataProvider.fullName,
      userDataProvider.email,
      hackathonDataProvider.teamName,
      hackathonDataProvider.noOfMembers,
      userDataProvider.contact,
      "Applied",
      "Applied",
      userDataProvider.uId,
    );
    log("Register : ${isRegister.toString()}");
    if (isRegister) {
      if (!mounted) return;
      SendEmail().sendMail(
        basicVariable,
        userDataProvider,
        widget.body,
        widget.subject,
      );
      log("Registered ");
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ThankyouScreen();
          },
        ),
      );
    } else {
      log("Please Try Again");
    }
  }

  //? Internship Function------------------->

  void internshipStatus(basicVariable, UserProvider userDataProvider) async {
    List internshipData = await InternShipApiClient().getInternshipDetails();

    log(internshipData.toString());

    log("\n \n Internship Section \n \n");
    final isRegister = await UserInternshipApiClient().internshipRegistration(
      userDataProvider.fullName,
      userDataProvider.college,
      userDataProvider.fatherName,
      userDataProvider.dateOfBirth,
      widget.jobData[widget.index]['date_of_interview'],
      widget.jobData[widget.index]['name'],
      "Applied",
      "Applied",
      widget.jobData[widget.index]['charge'],
      userDataProvider.uId,
    );
    log("Register : ${isRegister.toString()}");
    if (isRegister) {
      if (!mounted) return;
      SendEmail().sendMail(
        basicVariable,
        userDataProvider,
        widget.body,
        widget.subject,
      );
      log("Registered ");
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ThankyouScreen();
          },
        ),
      );
    } else {
      log("Please Try Again");
    }
  }
}
