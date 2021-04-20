import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:indglobalyomess/route_generator.dart';
import 'package:indglobalyomess/screens/login_screen.dart';
import 'package:indglobalyomess/screens/pages.dart';
import 'package:indglobalyomess/screens/splash.dart';
import 'package:indglobalyomess/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'get_state/get_user_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final Controller controller = Get.put(Controller());
  prefs = await SharedPreferences.getInstance();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(prefs.getBool('isLogin'));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'YoMess',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            brightness: Brightness.light),
        primaryColor: Colors.white,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: prefs.getBool('isLogin') == true
          ? Pages()
          : prefs.getBool('isSlider') == true
              ? LoginScreen()
              : Splash(),
    );
  }
}
