import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohana/constants/app_colors.dart';
import 'package:ohana/controller/app_provider.dart';
import 'package:ohana/controller/on_boarding_provider.dart';
import 'package:ohana/screens/bottom_navbar.dart';
import 'package:ohana/screens/login.dart';
import 'package:ohana/screens/onboarding.dart';
import 'package:ohana/services/local_storage.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterStatusbarcolor.setStatusBarColor(appColor);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String? username;
  bool? onboarded;
  bool? rememberMe;
  bool loading = false;

  getUserData() async {
    loading = true;
    setState(() {});
    username = await LocalStorage().getString("username");
    if (username == null) {
      username = "";
    }
    try {
      onboarded = await LocalStorage().getBool("onboarded");
      rememberMe = await LocalStorage().getBool("rememberMe");
    } catch (e) {
      onboarded = null;
      rememberMe = null;
    }
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingProvider>(
      create: (context) => OnboardingProvider(),
      child: ChangeNotifierProvider<AppProvider>(
        create: (context) => AppProvider(),
        child: MaterialApp(
            title: 'Ohana',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              textTheme: GoogleFonts.robotoTextTheme(),
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: true,
            ),
            home: loading
                ? SafeArea(
                    child: Scaffold(
                        body: Center(
                            child: CircularProgressIndicator(
                      color: appColor,
                    ))),
                  )
                : username != ""
                    //accepting null because remember me isnt in register screen
                    ? rememberMe == null || rememberMe!
                        ? BottomNavbar(username: username!, pageIndex: 0)
                        : Login()
                    : onboarded == true
                        ? Login()
                        : OnBoarding()),
      ),
    );
  }
}
