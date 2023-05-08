// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          EventSection(
            size: size,
            isApply: "Apply->",
            eventDate: "24\nApr",
            isApplyColor: Colors.red,
          ),
          EventSection(
            size: size,
            isApply: "Applied",
            eventDate: "30\nApr",
            isApplyColor: MyColors.tealGreenColor,
          ),
        ],
      ),
    );
  }
}

class EventSection extends StatelessWidget {
  const EventSection({
    super.key,
    required this.size,
    required this.eventDate,
    required this.isApply,
    required this.isApplyColor,
  });

  final Size size;
  final String eventDate;
  final String isApply;
  final Color isApplyColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          height: 80,
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
            color: MyColors.primaryColor.withOpacity(0.1),
          ),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                  color: MyColors.primaryColor,
                ),
              ),
              Container(
                width: 70,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                  border: Border.all(width: 1, color: MyColors.primaryColor),
                  color: Colors.white,
                  // color: Colors.blue,
                ),
                child: Text(
                  eventDate,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mega Event",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: MyColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          size: 15,
                          color: const Color(0xff2B2849).withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "10:00Am To 12:00Pm",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xff2B2849).withOpacity(0.5),
                            // fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 15,
                          color: const Color(0xff2B2849).withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Crtd Technologies",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xff2B2849).withOpacity(0.5),
                            // fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Container(),
                  ],
                ),
              ),
              Container(
                width: 120,
                // color: Colors.red,
                // padding: EdgeInsets.only(bottom: 8),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        isApply,
                        style: TextStyle(
                          color: isApplyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // SizedBox(height: 30),
      ],
    );
  }
}
