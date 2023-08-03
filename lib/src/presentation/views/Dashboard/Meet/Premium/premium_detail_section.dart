import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../const.dart';

class PremiumMeetingDetailScreeen extends StatefulWidget {
  const PremiumMeetingDetailScreeen({
    super.key,
    required this.meetingData,
    required this.index,
  });
  final List meetingData;
  final int index;

  @override
  State<PremiumMeetingDetailScreeen> createState() =>
      _PremiumMeetingDetailScreeenState();
}

class _PremiumMeetingDetailScreeenState
    extends State<PremiumMeetingDetailScreeen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      actionsPadding: EdgeInsets.zero,
      // buttonPadding: EdgeInsets.zero,
      elevation: 52,
      backgroundColor: Colors.transparent,
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.meetingData[widget.index]['image'],
                        fit: BoxFit.fill,
                        height: 150,
                        width: size.width,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.meetingData[widget.index]['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.meetingData[widget.index]['desc'],
                    style: TextStyle(
                      color: MyColors.lightGreyColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            color: MyColors.darkGreyColor,
                            size: 20,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.meetingData[widget.index]['date'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Icon(
                            Icons.alarm,
                            color: MyColors.darkGreyColor,
                            size: 20,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.meetingData[widget.index]['time'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 200,
                    height: 48,
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        final Uri url =
                            Uri.parse(widget.meetingData[widget.index]['link']);
                        onJoining(url);
                      },
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory),
                      child: const Text(
                        "Join",
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
            // const Spacer(),
          ],
        ),
      ],
    );
  }

  Future<void> onJoining(meetLink) async {
    try {
      if (await canLaunchUrl(meetLink)) {
        await launchUrl(meetLink, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $meetLink';
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
