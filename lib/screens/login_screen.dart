import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:indglobalyomess/components/common_inputfield.dart';
import 'package:indglobalyomess/components/round_button.dart';
import 'package:indglobalyomess/get_state/get_user_state.dart';
import 'package:indglobalyomess/screens/forgot_password_screen.dart';
import 'package:indglobalyomess/screens/home_screen.dart';
import 'package:indglobalyomess/utils/constant.dart';
import 'package:indglobalyomess/utils/facebook_login.dart';
import 'package:indglobalyomess/utils/google_login.dart';
import 'package:indglobalyomess/utils/headline.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:indglobalyomess/utils/network_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../utils/app_config.dart' as config;
import 'pages.dart';

import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void initState() {
    getTokenz();
    controller.isUserLogIn.value = false;
  }

  final Controller controller = Get.put(Controller());
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

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  getTokenz() async {
    _storageKeyMobileToken = await _firebaseMessaging.getToken();
    print("getTokenz fcm token -->$_storageKeyMobileToken");
  }

  Future login() async {
    controller.isUserLogIn.value = true;
    try {
      String token = await _firebaseMessaging.getToken();
      var data = {
        "mobile": phone.text,
        "password": password.text,
        "device_token": token,
      };

      print(data);

      Map<String, String> header = {
        "Content-Type": "application/json",
      };

      // NetworkDioHttp.setDynamicHeader(endPoint: BASE_URL);
      // var response = await NetworkDioHttp.postDioHttpMethod(context,
      //     url: LOGIN, data: jsonEncode(data));

      http.Response response = await http.post(BASE_URL + LOGIN,
          body: jsonEncode(data), headers: header);

      print(response.body);
      if (response != null) {
        controller.isUserLogIn.value = false;
        setState(() {
          userdata = jsonDecode(response.body);
        });
        if (userdata['success'] == true) {
          controller.isUserLogIn.value = false;
          await setUserData();
          ShowToast.showDialog('${userdata['message']}', context);
          controller.isUserLogIn = RxBool(true);
          prefs.setBool('isLogin', true);

          Navigator.pushReplacementNamed(context, '/Pages');
        } else {
          controller.isUserLogIn.value = false;
          ShowToast.showDialog('${userdata['message']}', context);
        }
      } else {
        controller.isUserLogIn.value = false;
        ShowToast.showDialog('Something went wrong', context);
      }
    } catch (e) {
      controller.isUserLogIn.value = false;
      print('$e');
    }
  }

  Future setUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userdata['data']['id'].toString());
    prefs.setString('name', userdata['data']['name'].toString());
    prefs.setString('email', userdata['data']['email'].toString());
    prefs.setString('mobile', userdata['data']['mobile'].toString());
    prefs.setString('api_token', userdata['data']['api_token'].toString());
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
      data = {
        'name': first_name + ' ' + last_name,
        'email': email,
        'device_token': _storageKeyMobileToken,
        'social_type': 'facebook',
        'social_id': facebook_id
      };
    } else {
      data = {
        'name': first_name,
        'email': email,
        'device_token': _storageKeyMobileToken,
        'social_type': 'google',
        'social_id': facebook_id
      };
    }

    // NetworkDioHttp.setDynamicHeader(endPoint: BASE_URL);
    //
    // var response = await NetworkDioHttp.postDioHttpMethod(context,
    //     url: SOCIAL_LOGIN, data: jsonEncode(data));

    Map<String, String> header = {
      "Content-Type": "application/json",
    };
    print(data);

    http.Response response = await http.post(BASE_URL + SOCIAL_LOGIN,
        body: jsonEncode(data), headers: header);

    if (response != null) {
      userdata = jsonDecode(response.body);

      print('userData from signIn method  user data: $userdata');
      print('userData from signIn method : ${response.body}');
      if (userdata != null) {
        if (userdata['success'] == true) {
          await setUserData();
          ShowToast.showDialog('${userdata['message']}', context);
          controller.isUserLogIn = RxBool(true);

          prefs.setBool('isLogin', true);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Pages()));
        } else {
          ShowToast.showDialog('${userdata['message']}', context);
        }
        type == '1'
            ? print('login fb--->' + response.body.toString())
            : print('login google--->' + response.body.toString());
      }
    } else {
      ShowToast.showDialog('Something went wrong', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          WillPopScope(
            onWillPop: _onBackButtonPressed,
            child: Container(
              height: size.height,
              width: size.width,
              color: kPrimaryAuthWhiteColor,
              child: Stack(
                children: [
                  Container(
                    color: kPrimaryAuthOrangeColor,
                    height: size.height / 2,
                    width: size.width,
                    child: Image(
                      image: AssetImage('assets/img/login_bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: size.height / 1.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(
                          top: size.height * 0.03,
                          right: 27,
                          left: 27,
                          bottom: 20),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat-SemiBold',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40)),
                              child: CommonInputField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(kDigitPattern)),
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                labelText: 'Phone Number',
                                type: TextInputType.phone,
                                controller: phone,
                              ),
                            ),
                            SizedBox(height: 15),
                            CommonInputField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(kPassword)),
                                LengthLimitingTextInputFormatter(10),
                              ],
                              labelText: 'Password',
                              hintText: '••••••',
                              type: TextInputType.text,
                              controller: password,
                              obscureText: true,
                            ),
                            SizedBox(height: 15),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Your Password',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Montserrat-Regular',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 48,
                              child: RoundButton(
                                color: Color(0xff00CFC1),
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  if (_isValidate(
                                    phone: '+91' + phone.text,
                                    password: password.text,
                                  )) {
                                    login();
                                  }
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => Pages(),
                                  //   ),
                                  // );
                                },
                                text: 'Login',
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/SignUp');
                                  },
                                  textColor: Theme.of(context).hintColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account ? ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Montserrat-Regular',
                                        ),
                                      ),
                                      Text(
                                        " Sign up",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0XFF4CD6CC),
                                          fontFamily: 'Montserrat-Regular',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.grey,
                                    height: 0.5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontFamily: 'Montserrat-SemiBold',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.grey,
                                    height: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  child: _buildSocialBtn(() async {
                                    final facebookLogin = FacebookLogin();
                                    final result =
                                        await facebookLogin.isLoggedIn;

                                    if (!result) {
                                      facebookLogin
                                          .logIn(["email"]).then((value) async {
                                        final token = value.accessToken.token;
                                        final graphResponse = await http.get(
                                            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
                                        final profile =
                                            json.decode(graphResponse.body);
                                        print(profile);
                                      });
                                    } else {
                                      facebookLogin.logOut();
                                      facebookLogin
                                          .logIn(["email"]).then((value) async {
                                        final token = value.accessToken.token;
                                        final graphResponse = await http.get(
                                            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
                                        final profile =
                                            json.decode(graphResponse.body);
                                        print(profile);
                                        socialLogin(
                                          first_name: profile['first_name'],
                                          last_name: profile['last_name'],
                                          facebook_id: profile['id'],
                                          email: profile['email'],
                                          type: '1',
                                        );
                                      });
                                    }

                                    // socialFBLogin();
                                  }, AssetImage('assets/img/facebook.jpg'),
                                      'Continue with Facebook'),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  child: _buildSocialBtn(() {
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
                                  }, AssetImage('assets/img/google.jpg'),
                                      'Continue with Google'),
                                )
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
          Obx(
            () => controller.isUserLogIn.value
                ? Container(
                    height: Get.height,
                    width: Get.width,
                    color: Colors.black26,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : SizedBox(),
          ),
        ],
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

Widget _buildSocialBtn(Function() onTap, AssetImage assetImage, String title) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.white,
          border: Border.all(color: Color(0xFF707070).withOpacity(0.2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 15,
          ),
          Container(
            height: 30,
            width: 30,
            child: Image(
              image: assetImage,
            ),
          ),
          SizedBox(
            width: 14,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontFamily: 'Montserrat-Medium'),
          ),
        ],
      ),
    ),
  );
}
