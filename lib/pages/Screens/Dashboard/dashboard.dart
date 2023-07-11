// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:enationn/ApiMap/APIs/EventEndPoints/event_api.dart';
import 'package:enationn/ApiMap/APIs/JobEndPoints/job_api.dart';
import 'package:enationn/ApiMap/APIs/UserEndPoints/signup_api.dart';
import 'package:enationn/Provider/basic_variables_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/app.dart';

import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/PaymentScreens/plan_screen.dart';
import 'package:enationn/pages/Screens/PopScreens/subscribe_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../ApiMap/APIs/EventEndPoints/hackathon_api.dart';
import '../../../ApiMap/APIs/EventEndPoints/internship_api.dart';
import '../../Customs/shared_pref.dart';
import 'MainJobs/job_screen.dart';
import 'Meet/meet_screen.dart';

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
      'name': 'Meets',
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
  int sliderIndex = 0;
  bool isPremiumActive = false;
  bool isBasicActive = false;
  bool isApplied = false;
  late Timer timer;
  late Timer showTimer;
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  List event = [];
  List internship = [];
  List hackathon = [];
  List jobs = [];

  int hackathonIndex = 0;
  int eventIndex = 0;
  int internshipIndex = 0;
  int fresherIndex = 0;
  int internIndex = 0;
  int experienceIndex = 0;

  bool hackathonToShow = false;
  bool internshipToShow = false;
  bool eventToShow = false;
  bool fresherToShow = false;
  bool internToShow = false;
  bool experienceToShow = false;

  Future<void> details() async {
    event = await EventApiClient().getEventDetails();
    hackathon = await HackathonApiClient().getHackathonDetails();
    internship = await InternShipApiClient().getInternshipDetails();
    jobs = await JobsApiClient().getJobsData();

    //? Hackathon ----------->

    for (var i = 0; i < hackathon.length; i++) {
      if (hackathon[i]['show'] == 'Yes' &&
          hackathon[i]['apply_status'] == 'Active') {
        hackathonIndex = i;
        hackathonToShow = false;
      } else {
        hackathonToShow = true;
      }
    }

    //? Internship ----------->

    for (var i = 0; i < internship.length; i++) {
      if (internship[i]['show'] == 'Yes' &&
          internship[i]['apply_status'] == 'Active') {
        internshipIndex = i;
        internshipToShow = false;
      } else {
        internshipToShow = true;
      }
    }

    //? Events ----------->

    for (var i = 0; i < event.length; i++) {
      if (event[i]['show'] == 'Yes' && event[i]['apply_status'] == 'Active') {
        eventIndex = i;
        eventToShow = false;
      } else {
        eventToShow = true;
      }
    }

    for (var i = 0; i < jobs.length; i++) {
      //? Fresher ----------->

      if (jobs[i]['show'] == 'Yes' &&
          jobs[i]['apply_status'] == 'Active' &&
          jobs[i]['type_of_job'] == 'fresher') {
        fresherIndex = i;
        fresherToShow = false;
      } else {
        fresherToShow = true;
      }

      //? Intern ----------->

      if (jobs[i]['show'] == 'Yes' &&
          jobs[i]['apply_status'] == 'Active' &&
          jobs[i]['type_of_job'] == 'intern') {
        internIndex = i;
        internToShow = false;
      } else {
        internToShow = true;
      }

      //? Experience ----------->

      if (jobs[i]['show'] == 'Yes' &&
          jobs[i]['apply_status'] == 'Active' &&
          jobs[i]['type_of_job'] == 'experience') {
        experienceIndex = i;
        experienceToShow = false;
      } else {
        experienceToShow = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    details();

    showTimer = Timer.periodic(
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

    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 5) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    showTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserProvider>(context);
    final basicVariable = Provider.of<BasicVariableModel>(context);
    Future.delayed(const Duration(milliseconds: 300));
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
                        GestureDetector(
                          onTap: () {
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomeScreen(
                                    activeIndex: 4,
                                  );
                                },
                              ),
                            );
                          },
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/ProfileScreen/profile.png"),
                            radius: 24,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyFont().fontSize14Bold("Hello,", Colors.white),
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
                ).animate(delay: 10.ms).fadeIn(begin: 0).moveY(begin: -50),
              ),
              basicVariable.index == 0
                  ? Expanded(
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
                          physics: const BouncingScrollPhysics(),
                          //? Job Section And Dashbaord -------------------->

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Home Slider Section
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                      top: 18,
                                      right: 24,
                                      bottom: 12,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Welcome to the',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' E-Nationn',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: MyColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ).animate(delay: 200.ms).fadeIn(begin: 0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 5),
                                    child: Divider(
                                      thickness: 2,
                                      endIndent: 120,
                                      color: MyColors.primaryColor,
                                    ),
                                  )
                                      .animate(delay: 200.ms)
                                      .fadeIn(begin: 0)
                                      .moveX(begin: 200),
                                  SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: PageView(
                                        physics: const BouncingScrollPhysics(),
                                        controller: _pageController,
                                        onPageChanged: (value) {
                                          sliderIndex = value;
                                          setState(() {});
                                        },
                                        children: [
                                          sliderEachSection(
                                            hackathonToShow,
                                            hackathon,
                                            hackathonIndex,
                                            () {},
                                            "hackathon",
                                            "assets/Dashboard/sliderCover.png",
                                            "name",
                                          ),
                                          sliderEachSection(
                                            internshipToShow,
                                            internship,
                                            internshipIndex,
                                            () {},
                                            "Internship",
                                            "assets/Dashboard/sliderCover.png",
                                            "name",
                                          ),
                                          sliderEachSection(
                                            eventToShow,
                                            event,
                                            eventIndex,
                                            () {},
                                            "Event",
                                            "assets/Dashboard/sliderCover.png",
                                            "name",
                                          ),
                                          sliderEachSection(
                                            fresherToShow,
                                            jobs,
                                            fresherIndex,
                                            () {},
                                            "Fresher",
                                            "assets/Dashboard/sliderCover.png",
                                            "name",
                                          ),
                                          sliderEachSection(
                                            internToShow,
                                            jobs,
                                            internIndex,
                                            () {},
                                            "Intern",
                                            "assets/Dashboard/sliderCover.png",
                                            "name",
                                          ),
                                          sliderEachSection(
                                            experienceToShow,
                                            jobs,
                                            experienceIndex,
                                            () {},
                                            "Experience",
                                            "assets/Dashboard/sliderCover.png",
                                            "name",
                                          ),
                                        ],
                                      ).animate(delay: 200.ms).fadeIn().moveX(),
                                    ),
                                  ),
                                  sliderEachSection(
                                    internshipToShow,
                                    internship,
                                    internshipIndex,
                                    () {},
                                    "Internship",
                                    "assets/Dashboard/sliderCover.png",
                                    "name",
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: SmoothPageIndicator(
                                      controller: _pageController,
                                      count: 6,
                                      effect: WormEffect(
                                        activeDotColor: MyColors.primaryColor,
                                        strokeWidth: 10,
                                        dotHeight: 10,
                                        dotWidth: 10,
                                      ),
                                      onDotClicked: (index) {},
                                    ),
                                  ).animate(delay: 200.ms).fadeIn(begin: 0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: Divider(
                                      thickness: 2,
                                      endIndent: 120,
                                      color: MyColors.primaryColor,
                                    ),
                                  )
                                      .animate(delay: 200.ms)
                                      .fadeIn(begin: 0)
                                      .moveX(begin: 200),
                                ],
                              ),
                              // Home Grid Section

                              Container(
                                padding: const EdgeInsets.only(
                                  left: 22,
                                  top: 8,
                                  right: 22,
                                ),
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
                                    ).animate(delay: 200.ms).fadeIn(),
                                    Container(
                                      margin: const EdgeInsets.only(top: 18),
                                      child: GridView.builder(
                                        itemCount: Dashboard.fakeData.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
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
                                              log(index.toString());
                                              switch (index) {
                                                case 0:
                                                  _scaleDialog();
                                                  break;
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
                                                case 4:
                                                  basicVariable
                                                      .setDashboardIndex(1);
                                                  setState(() {});
                                                  break;
                                                case 5:
                                                  _scaleDialog();
                                                  break;
                                                case 6:
                                                  basicVariable
                                                      .setDashboardIndex(2);
                                                  setState(() {});
                                                  break;
                                                case 7:
                                                  _scaleDialog();
                                                  break;
                                                case 8:
                                                  _scaleDialog();
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
                                                          BorderRadius.circular(
                                                              4),
                                                      child: Image.asset(
                                                        Dashboard
                                                                .fakeData[index]
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
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  4),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  4),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          Dashboard.fakeData[
                                                              index]['name'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                                  .animate(delay: 100.ms)
                                                  .fadeIn()
                                                  .moveX(begin: 100),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24)
                            ],
                          ),
                        ),
                      ),
                    )
                  : basicVariable.index == 2
                      ? const MeetScreen()
                      : const JobScreen(),
            ],
          ),
        ),
      ),
    );
  }
  //User Logged In ------------------------------>

  void _checkLoginStatus() async {
    final credentials = await SharedPref().getUserCredentials();
    if (credentials['email'] == null || credentials['password'] == null) {
      Navigator.pushReplacementNamed(context, '/login');
    }
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

    final userData =
        await SharedPref().getUserData(int.parse(loginCredentials['id']));

    if (userData['plan_status'] == "Basic") {
      isPremiumActive = false;
    }
    if (userData['plan_status'] == 'Premium') {
      isPremiumActive = true;
    }
  }

  // Setting Up user Data --------->

  void setUserCredentials(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final loginCredentials = await SharedPref().getUserCredentials();
    final getUser = await SignUpApiClient().getUserDataById(
      int.parse(
        loginCredentials['id'],
      ),
    );

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
    userProvider.setRemark(getUser['remark']);
    userProvider.setContact(getUser['contact']);
  }

  sliderEachSection(
    bool toShow,
    List listOfData,
    int index,
    Null Function() param3,
    String titleText,
    String imagePath,
    String name,
  ) {
    return !toShow
        ? listOfData.isNotEmpty
            ? SliderSection(
                listOfJobs: listOfData,
                index: index,
                name: name,
                onTap: param3,
                text: titleText,
              ).animate(delay: 200.ms).fadeIn(begin: 0).moveY(begin: -100)
            : Center(
                child: CircularProgressIndicator(
                  color: MyColors.tealGreenColor,
                  semanticsLabel: "Loading...",
                  semanticsValue: "Loading...",
                  backgroundColor: MyColors.primaryColor,
                  strokeWidth: 4.0,
                ),
              )
        : Image.asset(
            imagePath,
          );
  }
}

class SliderSection extends StatefulWidget {
  const SliderSection({
    super.key,
    required this.index,
    required this.listOfJobs,
    required this.name,
    required this.onTap,
    required this.text,
  });

  final List listOfJobs;
  final int index;
  final String name;
  final Function onTap;
  final String text;

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lastDate =
        DateTime.parse(widget.listOfJobs[widget.index]['last_date_to_apply']);

    final formattedLastDate =
        (DateFormat.yMMMd('en_US').format(lastDate)).toString();

    return InkWell(
      onTap: widget.onTap(),
      child: Center(
        child: Column(
          children: [
            MyFont().fontSize20Bold(widget.text, MyColors.primaryColor),
            const SizedBox(height: 10),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: widget.listOfJobs[widget.index]['image'] ??
                        "assets/Dashboard/sliderCover.png",
                    // imageBuilder: (context, imageProvider) => Container(
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       image: imageProvider,
                    //       fit: BoxFit.cover,
                    //       colorFilter: const ColorFilter.mode(
                    //         Colors.red,
                    //         BlendMode.colorBurn,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                // Container(
                //   height: 160,
                //   width: size.width - 30,
                //   alignment: Alignment.bottomCenter,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: NetworkImage(
                //         widget.listOfJobs[widget.index]['image'] ??
                //             "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png",
                //       ),
                //       fit: BoxFit.cover,
                //     ),
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                // ),
                Container(
                  width: size.width - 30,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white.withAlpha(1000),
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
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                          border: Border.all(
                              width: 1, color: MyColors.primaryColor),
                          color: Colors.white,
                          // color: Colors.blue,
                        ),
                        child: Text(
                          formattedLastDate.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.listOfJobs[widget.index][widget.name]
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.listOfJobs[widget.index]['title']
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MyColors.darkGreyColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      size: 15,
                                      color: const Color(0xff2B2849)
                                          .withOpacity(0.5),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.listOfJobs[widget.index]
                                              ['location']
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xff2B2849)
                                            .withOpacity(0.5),
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 10,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
