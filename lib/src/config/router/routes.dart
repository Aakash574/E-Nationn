import 'package:enationn/main.dart';
import 'package:enationn/src/presentation/views/ExtraScreens/welcome_Screen.dart';
import 'package:enationn/src/presentation/views/Profile/Sections/help_screen.dart';
import 'package:enationn/src/presentation/views/Profile/Sections/personal_info_screen.dart';
import 'package:enationn/src/presentation/views/Profile/Sections/privacy_policy_screen.dart';
import 'package:enationn/src/presentation/views/Profile/Sections/security_screen.dart';
import 'package:enationn/src/presentation/views/SplashScreens/splash_Screen.dart';
import 'package:enationn/src/presentation/views/SplashScreens/splash_Screen_One.dart';
import 'package:enationn/src/presentation/views/SplashScreens/splash_Screen_Three.dart';
import 'package:enationn/src/presentation/views/SplashScreens/splash_Screen_Two.dart';

import '../../presentation/views/LoginSignUpPage/LoginScreen/login_Screen.dart';

final routes = {
  //? Splash Screen --------------------------------->
  '/splash': (context) => const SplashScreen(),
  '/splash_one': (context) => const SplashScreenOne(),
  '/splash_two': (context) => const SplashScreenTwo(),
  '/splash_three': (context) => const SplashScreenThree(),

  //? Profile Screens --------------------------------->
  '/personal_info': (context) => const PersonalInfoScreen(),
  '/security': (context) => const SecurityScreen(),
  '/privacy_policy': (context) => const PrivacyPolicyScreen(),
  '/help': (context) => const HelpScreen(),

  //? Profile Screens --------------------------------->

  //? Profile Screens --------------------------------->
  '/home_page': (context) => const HomePage(),
  '/welcome': (context) => const WelcomeScreen(),
  '/login': (context) => const LoginScreen(),
};
