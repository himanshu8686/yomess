import 'package:flutter/material.dart';
import 'package:indglobalyomess/components/CommonInputField.dart';
import 'package:indglobalyomess/components/RoundButton.dart';
import 'package:indglobalyomess/utils/Constant.dart';
import 'package:indglobalyomess/utils/Headline.dart';
import 'package:indglobalyomess/utils/NavigationHelper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  margin: EdgeInsets.only(top: size.height * 0.15, left: 30),
                  child: Text(
                    "Lets Start With Login",
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
                      EdgeInsets.only(top: 50, right: 27, left: 27, bottom: 20),
                  width: size.width - 50,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          text: 'Login',
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSocialBtn(
                              () {},
                              AssetImage('assets/img/facebook.jpg'),
                            ),
                            _buildSocialBtn(
                              () {},
                              AssetImage('assets/img/google.jpg'),
                            )
                          ],
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/Pages');
                          },
                          shape: StadiumBorder(),
                          textColor: Theme.of(context).hintColor,
                          child: Text('Skip'),
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        ),
                        Column(
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/ForgetPassword');
                              },
                              textColor: Theme.of(context).hintColor,
                              child: Text('Forgot Password'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/SignUp');
                              },
                              textColor: Theme.of(context).hintColor,
                              child: Text("Don't have an account ?"),
                            ),
                          ],
                        ),
                      ],
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

Widget _buildSocialBtn(Function() onTap, AssetImage assetImage) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0)
          ],
          image: DecorationImage(image: assetImage)),
    ),
  );
}
