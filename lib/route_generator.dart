import 'package:flutter/material.dart';
import 'package:indglobalyomess/screens/ForgotPasswordScreen.dart';
import 'package:indglobalyomess/screens/LoginScreen.dart';
import 'package:indglobalyomess/screens/Pages.dart';
import 'package:indglobalyomess/screens/SingupScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
      
      case '/Pages': 
        return MaterialPageRoute(builder: (_)=>Pages());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case '/ForgetPassword':
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: SafeArea(
              child: Text('Route Error'),
            ),
          ),
        );
    }
  }
}
