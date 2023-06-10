// ignore_for_file:

import 'package:enationn/Provider/hackathon_provider.dart';
import 'package:enationn/Provider/user_provider.dart';
import 'package:enationn/pages/Customs/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/basic_variables_provider.dart';
import 'pages/Screens/SplashScreens/splash_screen.dart';
import 'pages/Screens/SplashScreens/splash_screen_one.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => BasicVariableModel()),
        ChangeNotifierProvider(create: (context) => HackathonProvider()),
      ],
      child: const MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isFirstUser = false;

  isFirstUserLoggedIn() async {
    isFirstUser = await SharedPref().getShowIntroScreen();
    setState(() {});
    if (isFirstUser == false) {
      SharedPref().setShowIntroScreen(true);
    }
  }

  @override
  void initState() {
    super.initState();
    isFirstUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isFirstUser ? const SplashScreen() : const SplashScreenOne(),
        // child: LoginScreen(),
      ),
    );
  }
}


// MOM :-
// 1.)Internship,Event form update and add duration as well
// 4.)we have show in profile,which internship or event already applied
// 5.)Use patch for update password in forget
// 6.)I will send privacy policy content