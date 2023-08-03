import 'package:enationn/src/config/router/routes.dart';
import 'package:enationn/src/presentation/provider/basic_variables_provider.dart';
import 'package:enationn/src/presentation/provider/hackathon_provider.dart';
import 'package:enationn/src/presentation/provider/user_provider.dart';
import 'package:enationn/src/presentation/views/SplashScreens/splash_Screen.dart';
import 'package:enationn/src/presentation/views/SplashScreens/splash_Screen_One.dart';
import 'package:enationn/src/utils/constants/shared_Pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
      child: MaterialApp(
        builder: FToastBuilder(),
        initialRoute: '/',
        routes: routes,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
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
    setState(() {
      if (isFirstUser == false) {
        SharedPref().setShowIntroScreen(true);
      }
    });
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
      ),
    );
  }
}
