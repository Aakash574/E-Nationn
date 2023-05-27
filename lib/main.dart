import 'package:enationn/Provider/basicVariablesProvider.dart';
import 'package:enationn/Provider/hackathonDetailProvider.dart';
import 'package:enationn/Provider/loginProvider.dart';
import 'package:enationn/pages/Customs/shared_Pref.dart';
import 'package:enationn/pages/Screens/SplashScreens/splash_Screen_One.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/Screens/SplashScreens/splash_Screen.dart';

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
        ChangeNotifierProvider(create: (_) => LoginScreenModel()),
        ChangeNotifierProvider(create: (_) => BasicVariableModel()),
        ChangeNotifierProvider(create: (_) => HackathonDetailProvider()),
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
    isFirstUser = await getShowIntroScreen();
    setState(() {});
    if (isFirstUser == false) {
      setShowIntroScreen(true);
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
        // child: ApiClientCCAvenue(),
      ),
    );
  }
}


// MOM :-
// 1.)Internship,Event form update and add duration as well
// 2.)After submit require voucher code(i will send api for the same)
// 3.)Need to add uid in User 3detail
// 4.)we have show in profile,which internship or event already applied
// 5.)Use patch for update password in forget
// 6.)I will send privacy policy content