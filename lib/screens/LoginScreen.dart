import 'package:flutter/material.dart';
import 'package:indglobalyomess/components/CommonInputField.dart';
import 'package:indglobalyomess/components/RoundButton.dart';
import 'package:indglobalyomess/screens/home_screen.dart';
import 'package:indglobalyomess/utils/Constant.dart';
import 'package:indglobalyomess/utils/FacebookLogin.dart';
import 'package:indglobalyomess/utils/GoogleLogin.dart';
import 'package:indglobalyomess/utils/Headline.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:indglobalyomess/utils/network_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../utils/app_config.dart' as config;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void initState() {
    getTokenz();
  }

  DateTime currentBackPressTime;
  String _storageKeyMobileToken = 'token';
  var userdata;
  TextEditingController phone = TextEditingController();
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

  /**
   * Get device token from FireBase
   */
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  getTokenz() async {
    _storageKeyMobileToken = await _firebaseMessaging.getToken();
    print("getTokenz fcm token -->$_storageKeyMobileToken");
  }

  Future login() async {
    var data = ({
      "mobile": phone.text,
      "password": password.text,
      "device_token": _storageKeyMobileToken,
    });

    NetworkDioHttp.setDynamicHeader(endPoint: BASE_URL);
    var response = await NetworkDioHttp.postDioHttpMethod(context,
        url: LOGIN, data: jsonEncode(data));
    print('<---------UserData------------>$response');

    if (response != null) {
      setState(() {
        userdata = response['body'];
      });
      if (userdata['response'] == true) {
        await setUserData();
        ShowToast.showDialog('${userdata['message']}', context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        ShowToast.showDialog('${userdata['message']}', context);
      }
    } else {
      ShowToast.showDialog('Something went wrong', context);
    }
  }

  Future setUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userdata['data']['id'].toString());
    prefs.setString('name', userdata['data']['name'].toString());
    prefs.setString('email', userdata['data']['email'].toString());
    prefs.setString('token', userdata['data']['token'].toString());
    prefs.setString('fcmtoken', _storageKeyMobileToken);
  }

  Future socialFBLogin({int type}) async {
    var fbData = await facebookLogin(context);

    var first_name = fbData['first_name'];
    var last_name = fbData['last_name'];
    var facebook_id = fbData['id'];
    var email = fbData['email'];

    socialLogin(
        first_name: first_name,
        last_name: last_name,
        facebook_id: facebook_id,
        email: email,
        type: '1');
  }

  Future socialLogin({
    String first_name,
    String last_name,
    String facebook_id,
    String email,
    String type,
  }) async {
    var data;
    if (type == '1') {
      data = ({
        'first_name': first_name,
        'last_name': last_name ?? '',
        'email': email,
        'facebook_id': facebook_id,
        'device_token': _storageKeyMobileToken,
      });
    } else {
      data = ({
        'first_name': first_name,
        'last_name': last_name ?? '',
        'email': email,
        'google_id': facebook_id,
        'device_token': _storageKeyMobileToken,
      });
    }

    NetworkDioHttp.setDynamicHeader(endPoint: BASE_URL);

    var response = await NetworkDioHttp.postDioHttpMethod(context,
        url: type == '1' ? FACEBOOK_LOGIN : GOOGLE_LOGIN,
        data: jsonEncode(data));

    if (response != null) {
      setState(() {
        userdata = response['body'];
      });

      if (userdata != null) {
        if (userdata['status'] == 1) {
          await setUserData();
          ShowToast.showDialog('${userdata['message']}', context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          ShowToast.showDialog('${userdata['message']}', context);
        }
        type == '1'
            ? print('login fb--->' + response['body'].toString())
            : print('login google--->' + response['body'].toString());
      }
    } else {
      ShowToast.showDialog('Something went wrong', context);
    }
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
              ),
              Positioned(
                top: config.App(context).appHeight(11),
                left: 30,
                child: Container(
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
                          labelText: 'Phone',
                          hintText: '+911234567890',
                          prefixIcon:
                              Icon(Icons.phone, color: kPrimaryAuthOrangeColor),
                          type: TextInputType.phone,
                          controller: phone,
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
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_isValidate(
                              phone: phone.text,
                              password: password.text,
                            )) {
                              login();
                            }
                          },
                          text: 'Login',
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSocialBtn(
                              () {
                                socialFBLogin();
                              },
                              AssetImage('assets/img/facebook.jpg'),
                            ),
                            _buildSocialBtn(
                              () {
                                googleLogin(context).then((value) => {
                                      if (value != null)
                                        {
                                          print('google login---->' +
                                              value.toString()),
                                          socialLogin(
                                            first_name: value.displayName,
                                            last_name: value.displayName,
                                            facebook_id: value.id,
                                            email: value.email,
                                            type: '2',
                                          )
                                        }
                                    });
                              },
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

  bool _isValidate({
    String phone,
    String password,
  }) {
    if (phone.isEmpty) {
      ShowToast.showDialog('Enter your Phone Number', context);
      return false;
    }
    if (password.isEmpty) {
      ShowToast.showDialog('Enter your password', context);
      return false;
    }
    return true;
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
        image: DecorationImage(
          image: assetImage,
        ),
      ),
    ),
  );
}
