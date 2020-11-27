import 'package:flutter/material.dart';
import 'package:indglobalyomess/components/CommonInputField.dart';
import 'package:indglobalyomess/components/RoundButton.dart';
import 'package:indglobalyomess/utils/Constant.dart';
import 'package:indglobalyomess/utils/Headline.dart';
import 'package:indglobalyomess/route_generator.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  DateTime currentBackPressTime;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<bool> _onBackButtonPressed() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      method.showtoast("Tap again to leave", context);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onBackButtonPressed,
        child: Container(
          height: size.height,
          width: size.width,
          color: kPrimaryAuthWhiteColor,
          child: Stack(
            children: [
              Container(
                color: kPrimaryAuthOrangeColor,
                height: size.height * 0.35,
                width: size.width,
                child: Container(
                  margin: EdgeInsets.only(top: size.height * 0.09, left: 30),
                  child: Text(
                    "Lets start with register!",
                    style: headline2,
                  ),
                ),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(top: size.height * 0.05),
                  padding:
                      EdgeInsets.only(top: 50, right: 27, left: 27, bottom: 80),
                  width: size.width - 50,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonInputField(
                          labelText: 'John Doe',
                          hintText: 'Full name',
                          prefixIcon: Icon(Icons.alternate_email,
                              color: kPrimaryAuthOrangeColor),
                          type: TextInputType.emailAddress,
                          controller: email,
                        ),
                        SizedBox(height: 30),
                        CommonInputField(
                          labelText: 'Email',
                          hintText: 'johndoe@gmail.com',
                          prefixIcon: Icon(Icons.alternate_email,
                              color: kPrimaryAuthOrangeColor),
                          type: TextInputType.emailAddress,
                          controller: email,
                        ),
                        SizedBox(height: 30),
                        CommonInputField(
                          labelText: 'Password',
                          hintText: '••••••••••••',
                          prefixIcon: Icon(Icons.lock_outline,
                              color: kPrimaryAuthOrangeColor),
                          type: TextInputType.text,
                          controller: password,
                          obscureText: true,
                        ),
                        SizedBox(height: 30),
                        RoundButton(
                          color: kPrimaryAuthOrangeColor,
                          onPressed: () {},
                          text: 'Register',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/Login');
                  },
                  textColor: Theme.of(context).hintColor,
                  child: Text(
                    "I have account? Back to login",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
