import 'package:enationn/ApiMap/APIs/EventEndPoints/hackathon_api.dart';
import 'package:enationn/ApiMap/APIs/UserEventEndPoints/user_hackathon_api.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'hackathon_detail_screen.dart';

class HackathonScreen extends StatefulWidget {
  const HackathonScreen({super.key});

  @override
  State<HackathonScreen> createState() => _HackathonScreenState();
}

class _HackathonScreenState extends State<HackathonScreen> {
  bool isApplied = false;

  List<dynamic> hackathonDetail = [];
  List<dynamic> hackathonUserData = [];

  Future<void> hackathonDetails() async {
    if (mounted) {
      hackathonDetail = await HackathonApiClient().getHackathonDetails();
    }
    setState(() {});
  }

  @override
  void initState() {
    hackathonDetails();
    super.initState();
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
                child: RefreshIndicator(
                  color: MyColors.primaryColor,
                  onRefresh: hackathonDetails,
                  child: ListView.builder(
                    itemCount: hackathonDetail.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => ListTile(
                      title: hackathonDetail.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              child: MyFont().fontSize16Bold(
                                "Hackathon Not Available...",
                                Colors.black45,
                              ),
                            )
                          : InkWell(
                              onTap: () async {
                                hackathonUserData =
                                    await UserHackathonApiClient()
                                        .getUserHackathonDetails();

                                final l1 = hackathonUserData.length;

                                for (var i = 0; i < l1; i++) {
                                  if (hackathonDetail[index]['name'] ==
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
                                        hackathon: hackathonDetail,
                                        isApplied: isApplied,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: FutureBuilder(
                                future:
                                    HackathonApiClient().getHackathonDetails(),
                                builder: (ctx, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: MyColors.tealGreenColor,
                                        semanticsLabel: "Loading...",
                                        semanticsValue: "Loading...",
                                        backgroundColor: MyColors.primaryColor,
                                        strokeWidth: 4.0,
                                      ),
                                    );
                                  } else {
                                    return HackathonSection(
                                      hackathons: hackathonDetail,
                                      index: index,
                                      isApplied: isApplied,
                                    );
                                  }
                                },
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

class HackathonSection extends StatefulWidget {
  const HackathonSection({
    super.key,
    required this.index,
    required this.hackathons,
    required this.isApplied,
  });
  final int index;
  final List hackathons;
  final bool isApplied;

  @override
  State<HackathonSection> createState() => _HackathonSectionState();
}

class _HackathonSectionState extends State<HackathonSection> {
  @override
  Widget build(BuildContext context) {
    var dateDiffrenceInHours;
    var dateDiffrenceInDays;
    // Timer leftTimer;

    final dateOfEvent =
        DateTime.tryParse(widget.hackathons[widget.index]['date_of_hackathon']);

    dateDiffrenceInDays = dateOfEvent?.difference(DateTime.now()).inDays;
    dateDiffrenceInHours = dateOfEvent?.difference(DateTime.now()).inHours;

    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: EdgeInsets.only(
        top: 8,
        right: 8,
        left: 8,
        bottom: widget.index == widget.hackathons.length - 1 ? 400 : 0,
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
                  (widget.hackathons[widget.index]['image']).toString().isEmpty
                      ? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png"
                      : widget.hackathons[widget.index]['image'],
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
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.lightGreyColor.withOpacity(0.9),
                      ),
                      child: Text(
                        widget.hackathons[widget.index]['date_of_hackathon']
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
                        borderRadius: BorderRadius.circular(7),
                        color: MyColors.lightGreyColor.withOpacity(0.9),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      widget.hackathons[widget.index]['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    MyFont().fontSize14Bold(
                      dateDiffrenceInHours <= 24
                          ? "${dateDiffrenceInHours.toString()} hours left"
                          : "${dateDiffrenceInDays.toString()} days left",
                      Colors.red,
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: MyColors.tealGreenColor,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.white,
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
                      color: const Color(0xff2B2849).withOpacity(0.5),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.hackathons[widget.index]['location'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xff2B2849).withOpacity(0.5),
                        // fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.isApplied ? "Applied" : "Not Applied",
                          style: TextStyle(
                            color: widget.isApplied
                                ? MyColors.tealGreenColor
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
    );
  }
}
