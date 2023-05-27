// ignore_for_file: file_names

import 'package:enationn/const.dart';
import 'package:enationn/pages/Screens/SplashScreens/splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'splash_Screen_Two.dart';

class SplashScreenOne extends StatefulWidget {
  const SplashScreenOne({super.key});

  @override
  State<SplashScreenOne> createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/SplashScreenImg/splash_One.png",
            ),
            scale: 1.0,
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: size.width,
                height: size.height / 2.3,
                child:
                    Image.asset("assets/SplashScreenImg/SplashScreenOne.png"),
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: MyFont().fontSize26Bold(
                      "What is now proved was\nonce only imagined",
                      Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: MyFont().fontSize18Weight500(
                      "Lorem ipsum dolor sit amet, cectetur adipiscing elit,",
                      MyColors.lightGreyColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5),
                            width: 24,
                            height: 10,
                            // color: Colors.red,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            width: 10,
                            height: 10,
                            // color: Colors.red,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            width: 10,
                            height: 10,
                            // color: Colors.red,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(
                                () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const SplashScreen(),
                                      inheritTheme: true,
                                      ctx: context,
                                    ),
                                  );
                                },
                              );
                            },
                            child: MyFont().fontSize18Light(
                              "Skip",
                              Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.transparent,
                    ),
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const SplashScreenTwo(),
                              inheritTheme: true,
                              ctx: context,
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
