// ignore_for_file: use_build_context_synchronously

import 'package:enationn/Api/constant_Api.dart';
import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/ExtraScreens/plan_Screen.dart';
import 'package:enationn/pages/Screens/PopScreens/subscribe_Pop_Up.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const List<Map> fakeData = [
    {
      'name': 'Mentorship',
      'imgPath': 'assets/Dashboard/one.png',
    },
    {
      'name': 'Hackathon',
      'imgPath': 'assets/Dashboard/two.png',
    },
    {
      'name': 'Internship',
      'imgPath': 'assets/Dashboard/three.png',
    },
    {
      'name': 'Center 1',
      'imgPath': 'assets/Dashboard/four.png',
    },
    {
      'name': 'Center 2',
      'imgPath': 'assets/Dashboard/five.png',
    },
    {
      'name': 'Center 3',
      'imgPath': 'assets/Dashboard/six.png',
    },
    {
      'name': 'Coding',
      'imgPath': 'assets/Dashboard/seven.png',
    },
    {
      'name': 'Step By Step',
      'imgPath': 'assets/Dashboard/eight.png',
    },
    {
      'name': 'Brain Recycle',
      'imgPath': 'assets/Dashboard/nine.png',
    },
  ];

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final keyIsFirstLoaded = 'is_first_loaded';
  String userName = "";

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
          child: const SubscribePopUp(),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  void showDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null &&
        context.widget.toStringShort() == "Dashboard") {
      _scaleDialog();
    }
  }

  void showDetails() async {
    userName = await ApiClient().getSpecificUserDetails(
      "sanjeevpal018@gmail.com",
      "name",
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      showDialog();
      showDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/PaymentScreenImg/paymentScreenBackground.png",
              ),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/ProfileScreen/profile.png"),
                          radius: 24,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyFont().fontSize14Light("Hii,", Colors.white),
                            const SizedBox(height: 5),
                            MyFont().fontSize16Bold(userName, Colors.white),
                          ],
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: MyColors.secondaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.ac_unit_rounded,
                            color: MyColors.secondaryColor,
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PlanScreen();
                                  },
                                ),
                              );
                            },
                            child: MyFont().fontSize16Bold(
                              "Premium",
                              MyColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Home Slider Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 22, top: 18, right: 22),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Welcome to the',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  children: [
                                    TextSpan(
                                      text: ' E-Nationn \n',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: MyColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: 'Team',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 12, bottom: 12, left: 22, right: 22),
                              color: MyColors.primaryColor,
                              height: 2,
                              width: 170,
                            ),
                            // Slider
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              height: 141,
                              child: PageView(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 22),
                                    decoration: BoxDecoration(
                                      // color: Colors.purple.shade900,
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          "assets/Dashboard/sliderCover.png",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 22),
                                    decoration: BoxDecoration(
                                      // color: Colors.green.shade900,
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          "assets/Dashboard/sliderCover.png",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 22),
                                    decoration: BoxDecoration(
                                      // color: Colors.blue.shade900,
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          "assets/Dashboard/sliderCover.png",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 12, bottom: 12, left: 22, right: 22),
                              color: MyColors.primaryColor,
                              height: 2,
                              width: 170,
                            )
                          ],
                        ),
                        // Home Grid Section

                        Container(
                          padding: const EdgeInsets.only(
                              left: 22, top: 8, right: 22),
                          // color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Build your ',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'career ',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: MyColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(text: 'with \n'),
                                    TextSpan(
                                      text: 'E-Nationn',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: MyColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // height: 300,
                                margin: const EdgeInsets.only(top: 18),
                                child: GridView.builder(
                                  itemCount: Dashboard.fakeData.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 14,
                                    mainAxisExtent: 138,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.asset(
                                                Dashboard.fakeData[index]
                                                    ['imgPath'],
                                                fit: BoxFit.cover,
                                              ),
                                              // child: Image.network(
                                              //   fakeData[index]['imgPath'],
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 1,
                                            right: 1,
                                            bottom: 1,
                                            child: Container(
                                              height: 24,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(4),
                                                  bottomRight:
                                                      Radius.circular(4),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  Dashboard.fakeData[index]
                                                      ['name'],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22)
                      ],
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
