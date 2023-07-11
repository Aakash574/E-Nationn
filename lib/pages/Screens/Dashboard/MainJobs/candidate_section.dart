import 'dart:developer';

import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/pages/Screens/PopScreens/job_code_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../ApiMap/APIs/JobEndPoints/job_account_api.dart';
import '../../../../const.dart';

class CandidateSection extends StatefulWidget {
  final int index;
  final List jobData;
  const CandidateSection({
    super.key,
    required this.index,
    required this.jobData,
  });

  @override
  State<CandidateSection> createState() => _CandidateSectionState();
}

class _CandidateSectionState extends State<CandidateSection> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _currentAddressController =
      TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _resumeLinkController = TextEditingController();

  List jobAccount = [];
  bool isApplied = false;
  bool isEmpty = false;
  String body = "";
  String subject = "";

  void checkStatus() async {
    jobAccount = await JobsAccountApiClient().getJobsData();
    if (!mounted) return;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    subject = "Successful Application - Next Steps Await";
    body = """Dear ${userProvider.fullName},

Congratulations on successfully applying for ${widget.jobData[widget.index]['name_of_job']} We have received your application and are impressed with your qualifications.

Our hiring team will now review your application carefully. Rest assured, we will be in touch soon with updates regarding the next steps in the process.

Thank you for your interest in our company, and we appreciate your patience. We look forward to connecting with you again shortly.

Best regards,
CRTD Technologies""";

    for (var i = 0; i < jobAccount.length; i++) {
      if (jobAccount[i]['uniqueid'] == userProvider.uId &&
          userProvider.email == jobAccount[i]['email'] &&
          jobAccount[i]['name_of_job'] ==
              widget.jobData[widget.index]['name_of_job']) {
        log("Already Applied ${widget.index}");
        isApplied = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final basicVariable =
        Provider.of<BasicVariableModel>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: MyColors.primaryColor,
                    ),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {});
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  MyFont().fontSize16Bold(
                    "Apply",
                    MyColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 48,
                  ),
                ],
              ).animate(delay: 200.ms).fadeIn().moveX(),
              const SizedBox(height: 15),
              MyFont()
                  .fontSize16Bold(
                    "Role : ${widget.jobData[widget.index]['name_of_job']}",
                    Colors.black,
                  )
                  .animate(delay: 200.ms)
                  .fadeIn()
                  .moveX(),
              const SizedBox(height: 15),
              MyFont().fontSize14Bold(
                widget.jobData[widget.index]['desc'],
                MyColors.lightGreyColor,
              ),
              const SizedBox(height: 15),
              MyFont().fontSize14Bold(
                "Last date to Apply : ${widget.jobData[widget.index]['last_date_to_apply']}",
                MyColors.primaryColor,
              ),
              const SizedBox(height: 15),
              userDetailField(
                "Name",
                userProvider.fullName,
                size,
              ),
              const SizedBox(height: 15),
              userDetailField(
                "Email",
                userProvider.email,
                size,
              ),
              const SizedBox(height: 15),
              userDetailField(
                "College",
                userProvider.college,
                size,
              ),
              const SizedBox(height: 15),
              userDetailField(
                "Branch",
                userProvider.branch,
                size,
              ),
              const SizedBox(height: 15),
              userDetailField(
                "Job Type",
                widget.jobData[widget.index]['type_of_job'],
                size,
              ),
              const SizedBox(height: 15),
              userDetailField(
                "Role",
                widget.jobData[widget.index]['title'],
                size,
              ),
              const SizedBox(height: 15),
              textFieldController(
                _phoneController,
                "Phone",
                "+91 000-000-0000",
                TextInputType.number,
              ),
              const SizedBox(height: 15),
              textFieldController(_currentAddressController, "Current Address",
                  "ex. Bhopal", TextInputType.streetAddress),
              const SizedBox(height: 15),
              textFieldController(
                _semesterController,
                "Semester",
                "ex. 8th",
                TextInputType.number,
              ),
              const SizedBox(height: 15),
              textFieldController(
                _resumeLinkController,
                "Resume Link",
                "https://drive.google.com/drive/u/0/my-drive",
                TextInputType.url,
              ),
              const SizedBox(height: 15),
              isEmpty
                  ? Visibility(
                      child: MyFont().fontSize14Bold(
                        "Please Fill All Details",
                        Colors.red,
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width - 100,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isApplied
                        ? MyColors.lightGreyColor
                        : MyColors.primaryColor,
                  ),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () async {
                      final applyStatus = await _applyForJob(userProvider);
                      setState(() {
                        if (!isApplied) {
                          if (applyStatus) {
                            basicVariable.setWhichScreen("JobScreen");
                            _scaleDialog();
                          } else {
                            isEmpty = true;
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "Already Applied",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      });
                    },
                    icon: Text(
                      !isApplied ? "Apply" : "Applied",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

  void _scaleDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.fastEaseInToSlowEaseOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: JobCodePopUp(
            index: widget.index,
            jobData: widget.jobData,
            body: body,
            subject: subject,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 10),
    );
  }

  textFieldController(
    controller,
    lebel,
    hinttext,
    textInputType,
  ) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: MyColors.primaryColor,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: "$lebel *",
          labelStyle: TextStyle(
            color: MyColors.secondPrimaryColor,
            fontSize: 14,
          ),
          hintText: hinttext,
          hintStyle: TextStyle(
            color: MyColors.lightGreyColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        onChanged: (value) {
          setState(() {
            controller = value;
          });
        },
      ),
    ).animate(delay: 200.ms).fadeIn().moveX(begin: 200);
  }

  Future<bool> _applyForJob(UserProvider uProvider) async {
    return await JobsAccountApiClient().postJobsData(
      uProvider.uId,
      uProvider.fullName,
      uProvider.email,
      uProvider.college,
      uProvider.branch,
      widget.jobData[widget.index]['type_of_job'],
      widget.jobData[widget.index]['name_of_job'],
      _phoneController.text,
      _semesterController.text,
      _currentAddressController.text,
      _resumeLinkController.text,
    );
  }

  userDetailField(
    String fieldName,
    String data,
    Size size,
  ) {
    return Container(
      height: 56,
      width: size.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          MyFont().fontSize12Bold(
            "$fieldName : ",
            MyColors.darkGreyColor,
          ),
          const Spacer(),
          SizedBox(
            width: 230,
            child: Text(
              data,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: MyColors.darkGreyColor,
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: 200.ms).fadeIn();
  }
}
