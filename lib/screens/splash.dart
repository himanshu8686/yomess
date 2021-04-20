import 'dart:async';

import 'package:flutter/material.dart';
import 'package:indglobalyomess/screens/slider.dart';
import 'package:indglobalyomess/utils/constant.dart';

import 'login_screen.dart';
import 'pages.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer t;

  changeScreen() {
    t = Timer.periodic(Duration(seconds: 3), (timer) {
      t.cancel();
      // Navigator.pop(context);
      // bool isLogin = prefs.getBool('isLogin');
      //  if (isLogin ?? true) {
      //    Navigator.push(
      //        context, MaterialPageRoute(builder: (context) => Pages()));
      //  } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SliderScreen(),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Container(
            child: Image(
              alignment: Alignment(0.5, 0),
              image: AssetImage('assets/img/main_splash.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Color(0XFF00CFC1).withOpacity(0.56),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  Color(0XFF0FA499),
                  Color(0XFF0FA499).withOpacity(0.5),
                  Color(0XFF00CFC1).withOpacity(0.2),
                ],
              ),
            ),
          ),
          Image(
            alignment: Alignment(0, 0),
            image: AssetImage('assets/img/logo.png'),
          ),
        ],
      ),
    );
  }
}
