import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indglobalyomess/screens/LoginScreen.dart';
import 'package:indglobalyomess/screens/home_screen.dart';
import 'package:indglobalyomess/route_generator.dart';
import 'package:indglobalyomess/utils/Constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
            color: Colors.white, elevation: 0, brightness: Brightness.light),
        primaryColor: Colors.white,
        scaffoldBackgroundColor: kWhitishGrey,
      ),
      home: LoginScreen(),
    );
  }
}
