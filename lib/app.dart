// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:developer';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:enationn/src/presentation/provider/basic_variables_provider.dart';
import 'package:enationn/src/presentation/views/Dashboard/dashboard.dart';
import 'package:enationn/src/presentation/views/ExtraScreens/premuim_Plan_Screen_Details.dart';
import 'package:enationn/src/presentation/views/MainEventScreens/main_Event_Screen.dart';
import 'package:enationn/src/presentation/views/PopScreens/exit_pop_up.dart';
import 'package:enationn/src/presentation/views/Profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color blueTextColor = Color(0xFF0B3B96);
const Color blueDividerColor = Color(0xFF4B89A8);
const Color bgColor = Colors.white;

class HomeScreen extends StatefulWidget {
  int activeIndex = 1;
  HomeScreen({super.key, required this.activeIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List body = [
    Dashboard(),
    PremiumPlanDetailScreen(),
    MainEventScreen(),
    ProfileScreen(),
  ];

  void _showExitPopUp() {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: const ExitPopUp(),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    final basicVariable = Provider.of<BasicVariableModel>(context);
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            log((widget.activeIndex - 1).toString());
            if (widget.activeIndex - 1 == 0) {
              _showExitPopUp();
            } else {
              setState(() {
                widget.activeIndex = 1;
              });
            }
            return false;
          },
          child: Container(
            child: body.elementAt(widget.activeIndex - 1),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        activeIndex: widget.activeIndex,
        blueTextColor: blueTextColor,
        onTapChange: (int onChangeActiveIndex) {
          setState(() {
            basicVariable.setDashboardIndex(0);
            widget.activeIndex = onChangeActiveIndex;
          });
        },
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.blueTextColor,
    required this.onTapChange,
    required this.activeIndex,
  });

  final Color blueTextColor;
  final int activeIndex;

  final Function(int onChangeActiveIndex) onTapChange;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomSlidingSegmentedControl<int>(
        height: 64,
        isStretch: true,
        initialValue: 1,
        padding: 0,
        innerPadding: EdgeInsets.zero,
        children: {
          1: NavBarItem(
            icon: Icons.home_rounded,
            title: 'Home',
            isActive: widget.activeIndex == 1 ? true : false,
          ),
          2: NavBarItem(
            icon: Icons.map_outlined,
            title: 'Plan',
            isActive: widget.activeIndex == 2 ? true : false,
          ),
          3: NavBarItem(
            icon: Icons.star_border_outlined,
            title: 'Career',
            isActive: widget.activeIndex == 3 ? true : false,
          ),
          4: NavBarItem(
            icon: Icons.person_2_outlined,
            title: 'Profile',
            isActive: widget.activeIndex == 4 ? true : false,
          ),
        },
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, -2),
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
        ),
        thumbDecoration: BoxDecoration(),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInToLinear,
        onValueChanged: (v) {
          widget.onTapChange(v);
        },
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.isActive,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4, right: 4),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isActive ? blueTextColor : Colors.transparent,
            width: 2.5,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? blueTextColor : Colors.grey.shade500,
            size: 32,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive ? blueTextColor : Colors.grey.shade500,
            ),
          )
        ],
      ),
    );
  }
}
