import 'package:enationn/ApiMap/APIs/MeetEndPoint/basic_meet_api.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/Dashboard/Meet/Basic/basic_detail_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BasicSection extends StatefulWidget {
  const BasicSection({
    super.key,
  });

  @override
  State<BasicSection> createState() => _BasicSectionState();
}

class _BasicSectionState extends State<BasicSection> {
  List basicMeetData = [];

  Future<Object> futureCall() async {
    basicMeetData = await BasicMeetApiClient().getMeetData();

    return await BasicMeetApiClient().getMeetData();
  }

  @override
  void initState() {
    // TODO: implement initState
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
              } else if (basicMeetData.isEmpty) {
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
                  itemCount: basicMeetData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BasicData(
                      index: index,
                      meetData: basicMeetData,
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

class BasicData extends StatefulWidget {
  const BasicData({
    super.key,
    required this.index,
    required this.meetData,
  });
  final int index;
  final List meetData;

  @override
  State<BasicData> createState() => _BasicDataState();
}

class _BasicDataState extends State<BasicData> {
  bool onTaped = false;
  bool onTapDown = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          _scaleDialog();
        },
        onTapDown: (details) {
          setState(() {
            onTaped = true;
          });
        },
        onTapUp: (details) {
          setState(() {
            onTaped = false;
          });
        },
        onTapCancel: () {
          setState(() {
            onTaped = false;
          });
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
              opacity: 0.1,
              image: NetworkImage(
                widget.meetData[widget.index]['image'],
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.s,
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
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: MyColors.primaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Basic",
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
        ).animate(target: onTaped ? 1 : 0).scaleXY(
            begin: 1, end: 0.85, duration: const Duration(milliseconds: 100)),
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
          child: BasicMeetingDetailScreeen(
            index: widget.index,
            meetingData: widget.meetData,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
