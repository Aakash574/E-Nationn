// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:enationn/ApiMap/APIs/EventEndPoints/event_api.dart';
import 'package:enationn/ApiMap/APIs/UserEndPoints/signup_api.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/app.dart';

import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PaymentScreens/plan_screen.dart';
import 'package:enationn/pages/Screens/PopScreens/subscribe_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Customs/shared_pref.dart';

enum CategoriesSections {
  hackathon,
  internship,
  event,
}

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
      'name': 'Events',
      'imgPath': 'assets/Dashboard/four.png',
    },
    {
      'name': 'Jobs',
      'imgPath': 'assets/Dashboard/five.png',
    },
    {
      'name': 'Practice',
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
  // Local Variables--------->

  final keyIsFirstLoaded = 'is_first_loaded';
  String userName = "";
  int index = 0;
  bool isPremiumActive = false;
  bool isBasicActive = false;
  late Timer timer;

  //User Logged In ------------------------------>

  void _checkLoginStatus() async {
    final credentials = await SharedPref().getUserCredentials();
    if (credentials['email'] == null || credentials['password'] == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {}
  }

  // Subscribe Dialog --------------------------------->

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

  void showDialog(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    isFirstLoaded == null && context.widget.toStringShort() == "Dashboard"
        ? userProvider.planStatus != 'premium'
            ? _scaleDialog()
            : log("True")
        : log("true");
  }

  Future<void> showDetails() async {
    final loginCredentials = await SharedPref().getUserCredentials();
    final userData = await SharedPref().getUserData(loginCredentials['id']);
    if (userData['plan_status'] == "Basic") {
      isPremiumActive = false;
    }
    if (userData['plan_status'] == 'Premium') {
      isPremiumActive = true;
    }
    setState(() {});
  }

  // Setting Up user Data --------->

  void setUserCredentials(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userData = await SharedPref().getUserCredentials();
    String id =
        await SignUpApiClient().getUserDataByEmail(userData['email'], 'id');
    final getUser = await SignUpApiClient().getUserDataById(int.parse(id));

    userProvider.setID(getUser['id'].toString());
    userProvider.setFullName(getUser['full_name']);
    userProvider.setEmail(getUser['email']);
    userProvider.setGender(getUser['gender']);
    userProvider.setFatherName(getUser['father_name']);
    userProvider.setCollege(getUser['college']);
    userProvider.setBranch(getUser['branch']);
    userProvider.setYearOfPassout(getUser['year_of_passout']);
    userProvider.setDateOfBirth(getUser['date_of_birth']);
    userProvider.setPlaceOfBirth(getUser['place_of_birth']);
    userProvider.setUID(getUser['uid']);
    userProvider.setInternshipStatus(
      getUser['internship_status'],
    );
    userProvider.setEventStatus(getUser['event_status']);
    userProvider.setHackathonStatus(getUser['hackathon_status']);
    userProvider.setSignupKey(getUser['signupkey']);
    userProvider.setApplyStatus(getUser['Apply_status']);
    userProvider.setPlanStatus(getUser['plan_status']);
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(minutes: 30),
      (Timer timer) {
        showDialog(context);
      },
    );

    showDetails();
    _checkLoginStatus();

    // Get Api Updates -------------->
    EventApiClient().getEventDetails();

    // Setting Up User Data

    setUserCredentials(context);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserProvider>(context);
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
                            MyFont().fontSize14Light("Hey,", Colors.white),
                            const SizedBox(height: 5),
                            MyFont().fontSize16Bold(
                              userDataProvider.fullName,
                              Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: userDataProvider.planStatus == 'basic'
                            ? MyColors.primaryColor.withOpacity(0.5)
                            : userDataProvider.planStatus == 'premium'
                                ? Colors.white.withOpacity(0.5)
                                : Colors.red.withOpacity(0.5),
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
                                    return const PlanScreen();
                                  },
                                ),
                              );
                            },
                            child: MyFont().fontSize16Bold(
                              userDataProvider.planStatus == 'basic'
                                  ? "Basic"
                                  : userDataProvider.planStatus == 'premium'
                                      ? "Premium"
                                      : "Not Active",
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
                                top: 12,
                                bottom: 12,
                                left: 22,
                                right: 22,
                              ),
                              color: MyColors.primaryColor,
                              height: 2,
                              width: 170,
                            ),
                            // Slider
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              height: 141,
                              child: PageView(
                                onPageChanged: (value) {
                                  index = value;
                                  setState(() {});
                                },
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(width: 160),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: index == 0
                                        ? MyColors.primaryColor
                                        : Colors.grey,
                                  ),
                                ),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: index == 1
                                        ? MyColors.primaryColor
                                        : Colors.grey,
                                  ),
                                ),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: index == 2
                                        ? MyColors.primaryColor
                                        : Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 160),
                              ],
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
                                    return InkWell(
                                      onTap: () {
                                        switch (index) {
                                          case 1:
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(
                                                  activeIndex: 3,
                                                ),
                                              ),
                                            );
                                            break;
                                          case 2:
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(
                                                  activeIndex: 3,
                                                ),
                                              ),
                                            );
                                            break;
                                          case 3:
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(
                                                  activeIndex: 3,
                                                ),
                                              ),
                                            );
                                            break;
                                          default:
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                                  borderRadius:
                                                      BorderRadius.only(
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
