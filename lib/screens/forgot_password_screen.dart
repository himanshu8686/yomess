import 'package:flutter/material.dart';
import 'package:indglobalyomess/components/common_inputfield.dart';
import 'package:indglobalyomess/components/round_button.dart';
import 'package:indglobalyomess/utils/constant.dart';
import 'package:indglobalyomess/utils/headline.dart';
import '../utils/app_config.dart' as config;

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  DateTime currentBackPressTime;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<bool> _onBackButtonPressed() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ShowToast.showDialog("Tap again to leave", context);
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
                height: size.height * 0.4,
                width: size.width,
              ),
              Positioned(
                top: config.App(context).appHeight(37) - 120,
                left: 30,
                child: Container(
                  width: config.App(context).appWidth(84),
                  height: config.App(context).appHeight(37),
                  child: Text(
                    "Email to reset password",
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
                  margin: EdgeInsets.only(top: size.height * 0.001),
                  padding:
                      EdgeInsets.only(top: 50, right: 27, left: 27, bottom: 80),
                  width: size.width - 50,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonInputField(
                          labelText: 'Email',
                          hintText: 'johndoe@gmail.com',
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: kPrimaryAuthOrangeColor,
                          ),
                          type: TextInputType.emailAddress,
                          controller: email,
                        ),
                        SizedBox(height: 30),
                        RoundButton(
                          color: kPrimaryAuthOrangeColor,
                          onPressed: () {},
                          text: 'Send Link',
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
                    Navigator.of(context).pushNamed('/SignUp');
                  },
                  textColor: Theme.of(context).hintColor,
                  child: Text(
                    "i don't have an account",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 40,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/Login');
                    },
                    textColor: Theme.of(context).hintColor,
                    child: Text(
                      "I remember my password return to login",
                    ),
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
