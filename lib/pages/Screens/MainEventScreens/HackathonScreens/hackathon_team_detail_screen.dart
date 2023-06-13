import 'package:enationn/Provider/hackathon_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PaymentScreens/voucher_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer2<UserProvider, HackathonProvider>(
      builder: (context, userProvider, hackathonProvider, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
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
                          widget.hackathonDetails[widget.index]['name'],
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
                          Container(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xffF9FAFB),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isEmpty
                                    ? Colors.red
                                    : MyColors.primaryColor,
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
                                color: isEmpty
                                    ? Colors.red
                                    : MyColors.primaryColor,
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
                                // hackathonProvider.setNoOfMembers(value);
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
                                color: isEmpty
                                    ? Colors.red
                                    : MyColors.primaryColor,
                                width: 1,
                              ),
                            ),
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              // maxLength: 10,
                              // maxLengthEnforcement: MaxLengthEnforcement.none,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Phone Number",
                                labelStyle: TextStyle(
                                  color: MyColors.secondPrimaryColor,
                                  fontSize: 16,
                                ),
                                hintText: "xxx-xxx-xx-xx",
                                hintStyle: TextStyle(
                                  color: MyColors.lightGreyColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
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
                          hackathonProvider
                              .setTeamName(_teamNameController.text);
                          hackathonProvider
                              .setNoOfMembers(_noOfMemberController.text);
                          hackathonProvider.setPhoneNo(_phoneController.text);
                          hackathonProvider.setUniqueId(userProvider.uId);

                          if (_teamNameController.text.isNotEmpty &&
                              _noOfMemberController.text.isNotEmpty &&
                              _phoneController.text.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return VoucherCodeScreen(
                                    name: widget.hackathonDetails[widget.index]
                                        ['name'],
                                    events: widget.hackathonDetails,
                                    index: widget.index,
                                    screen: 'HackathonDetailScreen',
                                  );
                                },
                              ),
                            );
                            isEmpty = false;
                          } else {
                            isEmpty = true;
                          }
                          setState(() {});
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
      },
    );
  }
}
