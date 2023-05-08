// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/HackthonScreens/hackathonDetail.dart';
import 'package:flutter/material.dart';

class HackathonScreen extends StatefulWidget {
  const HackathonScreen({super.key});

  @override
  State<HackathonScreen> createState() => _HackathonScreenState();
}

class _HackathonScreenState extends State<HackathonScreen> {
  var image = "";
  var name = "";
  var date = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HackathonDetailsScreen();
                  },
                ),
              );
            });
          },
          child: hackathonCardView(
            size,
            "hackathonScreen",
            "Code Athon",
            "10\nApr",
          ),
        ),
        hackathonCardView(
          size,
          "hackathonScreenTwo",
          "Code big show",
          "11\nApr",
        ),
        hackathonCardView(
          size,
          "hackathonScreenTwo",
          "Code big show",
          "11\nApr",
        ),
      ],
    );
  }

  Container hackathonCardView(
    Size size,
    String image,
    String name,
    String date,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: Stack(
        children: [
          Container(
            height: 270,
            width: size.width,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: MyColors.primaryColor.withOpacity(0.05),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    "assets/ExtrasScreens/$image.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 80,
                  // color: Colors.blue,
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        name,
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
                                margin: const EdgeInsets.only(left: 30),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: MyColors.tealGreenColor,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                // color: Colors.white,
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
                            "Crtd Technologies",
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
                                "Applied",
                                style: TextStyle(
                                  color: MyColors.tealGreenColor,
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
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.lightGreyColor.withOpacity(0.9),
                  ),
                  child: Text(
                    date,
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
          ),
        ],
      ),
    );
  }
}
