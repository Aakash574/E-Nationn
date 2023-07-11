import 'package:enationn/ApiMap/APIs/MeetEndPoint/premium_meet_api.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/Dashboard/Meet/Premium/premium_detail_section.dart';
import 'package:enationn/pages/Screens/PopScreens/subscribe_Pop_Up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class PremiumSection extends StatefulWidget {
  const PremiumSection({
    super.key,
  });

  @override
  State<PremiumSection> createState() => _PremiumSectionState();
}

class _PremiumSectionState extends State<PremiumSection> {
  List premiumMeetData = [];

  Future<Object> futureCall() async {
    premiumMeetData = await PremiumMeetApiClient().getMeetData();

    return await PremiumMeetApiClient().getMeetData();
  }

  @override
  void initState() {
    super.initState();
    futureCall();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          FutureBuilder(
            future: futureCall(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: MyColors.tealGreenColor,
                    semanticsLabel: "Loading...",
                    semanticsValue: "Loading...",
                    backgroundColor: MyColors.primaryColor,
                    strokeWidth: 4.0,
                  ),
                );
              } else if (premiumMeetData.isEmpty) {
                return Center(
                  heightFactor: 15,
                  child: MyFont().fontSize18Bold(
                    "NO MEETING AVALIABLE...",
                    MyColors.darkGreyColor,
                  ),
                );
              } else {
                return ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: premiumMeetData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PremiumData(
                      index: index,
                      meetData: premiumMeetData,
                    );
                  },
                ).animate(delay: 200.ms).fadeIn().moveX(begin: 100);
              }
            },
          ),
        ],
      ),
    );
  }
}

class PremiumData extends StatefulWidget {
  const PremiumData({
    super.key,
    required this.index,
    required this.meetData,
  });
  final int index;
  final List meetData;

  @override
  State<PremiumData> createState() => _PremiumDataState();
}

class _PremiumDataState extends State<PremiumData> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          userProvider.planStatus == 'premium'
              ? _scaleDialog()
              : _premiumDialog();
        },
        child: Container(
          height: 230,
          width: size.width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(3, 3),
                blurRadius: 5,
              )
            ],
            image: DecorationImage(
              opacity: 0.2,
              image: NetworkImage(
                widget.meetData[widget.index]['image'],
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: MyColors.primaryColor,
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.meetData[widget.index]['image'],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 20,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: MyColors.secondaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Premium",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyFont().fontSize16Bold("Meeting", Colors.black),
              MyFont().fontSize26Bold(
                widget.meetData[widget.index]['title'],
                Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyFont().fontSize12Weight700(
                        "Time",
                        Colors.black.withOpacity(0.5),
                      ),
                      MyFont().fontSize14Weight700(
                        widget.meetData[widget.index]['time'],
                        Colors.black,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyFont().fontSize12Weight700(
                        "Date",
                        Colors.black.withOpacity(0.5),
                      ),
                      MyFont().fontSize14Weight700(
                        widget.meetData[widget.index]['date'],
                        Colors.black,
                      ),
                    ],
                  ),
                ],
              )
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
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: PremiumMeetingDetailScreeen(
            index: widget.index,
            meetingData: widget.meetData,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  void _premiumDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: const SubscribePopUp(),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
