import 'package:flutter/material.dart';
import 'package:indglobalyomess/screens/forgot_password_screen.dart';
import 'package:indglobalyomess/screens/login_screen.dart';
import 'package:indglobalyomess/screens/pages.dart';
import 'package:indglobalyomess/screens/singup_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
      case '/Pages':
        return MaterialPageRoute(builder: (_) => Pages());
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
