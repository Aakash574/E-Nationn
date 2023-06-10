import 'dart:developer';

import 'package:enationn/ApiMap/APIs/EventEndPoints/hackathon_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_hackathon_api.dart';
import 'package:enationn/Provider/hackathon_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PaymentScreens/voucher_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HackathonScreen extends StatefulWidget {
  const HackathonScreen({super.key});

  @override
  State<HackathonScreen> createState() => _HackathonScreenState();
}

class _HackathonScreenState extends State<HackathonScreen> {
  bool isApplied = false;

  List<dynamic> hackathonEventDetails = [];
  List<dynamic> hackathonUserData = [];

  void hackathonDetails() async {
    hackathonEventDetails = await HackathonApiClient().getHackathonDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    hackathonDetails();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Material(
      color: Colors.white,
      child: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: hackathonEventDetails.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => ListTile(
                    title: hackathonEventDetails.isEmpty
                        ? Container(
                            alignment: Alignment.center,
                            child: MyFont().fontSize16Bold(
                              "Hackathon Not Available...",
                              Colors.black45,
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              hackathonUserData = await UserHackathonApiClient()
                                  .getUserHackathonDetails();

                              final l1 = hackathonUserData.length;

                              for (var i = 0; i < l1; i++) {
                                if (hackathonEventDetails[index]['name'] ==
                                        hackathonUserData[i]
                                            ['hackathon_name'] &&
                                    hackathonUserData[i]['uniqueid'] ==
                                        userProvider.uId) {
                                  isApplied = true;
                                  setState(() {});
                                  break;
                                } else {
                                  isApplied = false;
                                  setState(() {});
                                }
                              }

                              if (!mounted) return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return HackathonDetailsScreen(
                                      index: index,
                                      hackathon: hackathonEventDetails,
                                      isApplied: isApplied,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: size.width,
                              margin: EdgeInsets.only(
                                top: 8,
                                right: 8,
                                left: 8,
                                bottom:
                                    index == hackathonEventDetails.length - 1
                                        ? 400
                                        : 0,
                              ),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: MyColors.primaryColor.withOpacity(0.05),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          hackathonEventDetails[index]['image'],
                                          fit: BoxFit.cover,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 45,
                                              height: 45,
                                              margin: const EdgeInsets.all(12),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: MyColors.lightGreyColor
                                                    .withOpacity(0.9),
                                              ),
                                              child: Text(
                                                hackathonEventDetails[index]
                                                        ['date_of_hackathon']
                                                    .toString()
                                                    .substring(0, 2),
                                                style: TextStyle(
                                                  color: MyColors.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              width: 30,
                                              height: 30,
                                              margin: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color: MyColors.lightGreyColor
                                                    .withOpacity(0.9),
                                              ),
                                              child: Icon(
                                                Icons.bookmark,
                                                color: MyColors.primaryColor,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 5),
                                        Text(
                                          hackathonEventDetails[index]['name'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 30),
                                                  child: CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:
                                                        MyColors.tealGreenColor,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 15),
                                                  child: const CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                ),
                                                const CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: Colors.red,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              "+20 Teams",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff3F38DD),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_rounded,
                                              size: 18,
                                              color: const Color(0xff2B2849)
                                                  .withOpacity(0.5),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              hackathonEventDetails[index]
                                                  ['location'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xff2B2849)
                                                    .withOpacity(0.5),
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  isApplied
                                                      ? "Applied"
                                                      : "Not Applied",
                                                  style: TextStyle(
                                                    color: isApplied
                                                        ? MyColors
                                                            .tealGreenColor
                                                        : Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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

class HackathonDetailsScreen extends StatefulWidget {
  final int index;
  final List hackathon;
  final bool isApplied;
  const HackathonDetailsScreen({
    super.key,
    required this.index,
    required this.hackathon,
    required this.isApplied,
  });

  @override
  State<HackathonDetailsScreen> createState() => _HackathonDetailsScreenState();
}

class _HackathonDetailsScreenState extends State<HackathonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      child: SizedBox(
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 262,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.hackathon[widget.index]['image'].toString(),
                      ),
                      fit: BoxFit.cover,
                      // image: AssetImage("assets/Logos/TeamLogin.jpg"),
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: size.height - 220,
                  // color: Colors.red,
                  margin: const EdgeInsets.only(top: 220),
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 46,
                        height: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),

                      MyFont().fontSize16Weight500(
                        widget.hackathon[widget.index]['name'],
                        MyColors.darkGreyColor,
                      ),

                      const SizedBox(height: 5),
                      MyFont().fontSize16Weight500(
                        widget.hackathon[widget.index]['title'],
                        Colors.black.withOpacity(0.8),
                      ),

                      const SizedBox(height: 5),
                      MyFont().fontSize14Weight500(
                        widget.hackathon[widget.index]['desc'],
                        MyColors.darkGreyColor.withOpacity(0.8),
                      ),
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xffE1E9F4),
                                  ),
                                  child: Icon(
                                    Icons.calendar_month_outlined,
                                    color: MyColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyFont().fontSize16Bold(
                                      widget.hackathon[widget.index]
                                          ['date_of_hackathon'],
                                      Colors.black,
                                    ),
                                    const SizedBox(height: 5),
                                    MyFont().fontSize14Weight500(
                                      widget.hackathon[widget.index]['time'],
                                      MyColors.lightGreyColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 45),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xffE1E9F4),
                                  ),
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color: MyColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyFont().fontSize16Bold(
                                      "Gala Convention Center",
                                      Colors.black,
                                    ),
                                    const SizedBox(height: 5),
                                    MyFont().fontSize14Weight500(
                                      widget.hackathon[widget.index]
                                          ['location'],
                                      MyColors.lightGreyColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 45),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 46,
                        height: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey,
                        ),
                      ),
                      // SizedBox(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              right: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyFont().fontSize16Weight500(
                                  "Last Registration Date",
                                  Colors.black,
                                ),
                                const SizedBox(height: 5),
                                MyFont().fontSize14Weight500(
                                  widget.hackathon[widget.index]
                                      ['last_date_to_apply'],
                                  MyColors.lightGreyColor,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              right: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyFont().fontSize16Weight500(
                                  "Apply Status",
                                  Colors.black,
                                ),
                                const SizedBox(height: 5),
                                MyFont().fontSize14Weight500(
                                  widget.isApplied ? "Applied" : "Not Applied",
                                  MyColors.lightGreyColor,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: size.width,
                        height: 56,
                        decoration: BoxDecoration(
                          color: widget.isApplied
                              ? MyColors.lightGreyColor
                              : MyColors.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton(
                          onPressed: () {
                            widget.isApplied
                                ? log("Already Applied")
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return HackathonTeamDetailsScreen(
                                          index: widget.index,
                                          hackathonDetails: widget.hackathon,
                                        );
                                      },
                                    ),
                                  );
                          },
                          child: MyFont().fontSize16Bold(
                            widget.isApplied ? "Applied" : "Apply",
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
