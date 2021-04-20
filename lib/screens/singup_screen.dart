import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:indglobalyomess/components/common_inputfield.dart';
import 'package:indglobalyomess/components/round_button.dart';
import 'package:indglobalyomess/get_state/get_user_state.dart';
import 'package:indglobalyomess/models/user_registeration_model.dart';
import 'package:indglobalyomess/screens/pages.dart';
import 'package:indglobalyomess/screens/home_screen.dart';
import 'package:indglobalyomess/screens/slider.dart';
import 'package:indglobalyomess/utils/constant.dart';
import 'package:indglobalyomess/utils/headline.dart';
import 'package:indglobalyomess/utils/componet.dart';
import 'package:indglobalyomess/utils/network_dio.dart';
import 'package:indglobalyomess/utils/pin_entry_text_field.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_config.dart' as config;
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  DateTime currentBackPressTime;
  String _storageKeyMobileToken = 'token';
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final TextEditingController _pinPutController = TextEditingController();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    border: Border.all(color: kTextColor),
    borderRadius: BorderRadius.circular(15.0),
  );

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final Controller controller = Get.put(Controller());

  getTokenz() async {
    _storageKeyMobileToken = await _firebaseMessaging.getToken();
    print("getTokenz fcm token -->$_storageKeyMobileToken");
  }

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

  Future _ackAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please Enter OTP'),
          content: Container(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: PinEntryTextField(
                fields: 6,
                showFieldAsBox: true,
                isTextObscure: true,
                onSubmit: (String pin) async {
                  dynamic response = await signIn(
                      nameText: userName.text,
                      emailText: email.text,
                      passwordText: password.text,
                      phoneText: phone.text,
                      smsCode: pin);

                  print('Response : $response');
                  Navigator.pop(context);

                  if (response['success'] == true) {
                    if (FirebaseAuth.instance.currentUser != null) {
                      print(
                          "----------------------------------------------------");
                      if (FirebaseAuth.instance.currentUser.uid.isNotEmpty) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isLogin', true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Pages(),
                          ),
                        );
                        ShowToast.showDialog("Otp Verified", context);
                      } else {
                        ShowToast.showDialog("Wrong OTP", context);
                      }
                    } else {
                      ShowToast.showDialog("Wrong OTP", context);
                    }
                  } else {
                    ShowToast.showDialog("${response['message']}", context);
                  }
                },
              ),
            ),
          ),
          // actions: [
          //   FlatButton(
          //     onPressed: () {
          //       // FirebaseAuth.instance.currentUser.then(
          //       //   (user) {
          //       //     if (user != null) {
          //       //       Navigator.of(context).pop();
          //       //       Navigator.push(
          //       //         context,
          //       //         MaterialPageRoute(builder: (context) => HomeScreen()),
          //       //       );
          //       //     } else {
          //       //       Navigator.of(context).pop();
          //       //       signIn(smssent);
          //       //     }
          //       //   },
          //       // );
          //       // Navigator.pop(context);
          //       //
          //       // if (FirebaseAuth.instance.currentUser != null) {
          //       //   print("----------------------------------------------------");
          //       //   if (FirebaseAuth.instance.currentUser.uid.isNotEmpty) {
          //       //     Navigator.push(
          //       //       context,
          //       //       MaterialPageRoute(
          //       //         builder: (_) => SliderScreen(),
          //       //       ),
          //       //     );
          //       //     ShowToast.showDialog("Otp Verified", context);
          //       //   } else {
          //       //     ShowToast.showDialog("Wrong OTP", context);
          //       //   }
          //       // } else {
          //       //   ShowToast.showDialog("Wrong OTP", context);
          //       // }
          //     },
          //     child: Text(
          //       'done',
          //       style: TextStyle(color: Colors.black),
          //     ),
          //   ),
          // ],
        );
      },
    );
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
                    height: size.height / 2,
                    width: size.width,
                    child: Image(
                      image: AssetImage('assets/img/sigin_bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: size.height / 1.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(top: 31, right: 27, left: 27),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SignUp',
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
                              height: 31,
                            ),
                            CommonInputField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(kCharacterPattern)),
                                LengthLimitingTextInputFormatter(30),
                              ],
                              labelText: 'UserName',
                              type: TextInputType.text,
                              controller: userName,
                            ),
                            SizedBox(height: 15),
                            CommonInputField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(kEmailAddressValidationPattern)),
                                LengthLimitingTextInputFormatter(30),
                              ],
                              labelText: 'Email',
                              type: TextInputType.emailAddress,
                              controller: email,
                            ),
                            SizedBox(height: 15),
                            CommonInputField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(kDigitPattern)),
                                LengthLimitingTextInputFormatter(10),
                              ],
                              labelText: 'Phone',
                              type: TextInputType.phone,
                              controller: phone,
                            ),
                            SizedBox(height: 15),
                            CommonInputField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(kPassword)),
                                LengthLimitingTextInputFormatter(10),
                              ],
                              labelText: 'Password',
                              type: TextInputType.text,
                              controller: password,
                              obscureText: true,
                            ),
                            SizedBox(height: 15),
                            RoundButton(
                              color: Color(0xff00CFC1),
                              onPressed: () async {
                                /*sendOTP();*/
                                if (_isValidate(
                                  password: password.text,
                                  phone: '+91' + phone.text,
                                  name: userName.text,
                                )) {
                                  print('validate');
                                  await sendOTP();
                                } else {
                                  ShowToast.showDialog(
                                      'Check Your Network Connection.',
                                      context);
                                }

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (_) => SliderScreen(),
                                //   ),
                                // );
                              },
                              text: 'SignUp',
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Have an account? ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed('/Login');
                                    },
                                    child: Text(
                                      'Sign in',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff00CFC1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
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

  Widget otpScreen(BuildContext context, String actualCode) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: kPrimaryAuthWhiteColor,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: AssetImage('assets/img/login_bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(top: 31, right: 27, left: 27),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Verification Code',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat-SemiBold',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height / 75,
                          ),
                          PinPut(
                            fieldsCount: 6,
                            focusNode: _pinPutFocusNode,
                            controller: _pinPutController,
                            textInputAction: TextInputAction.done,
                            submittedFieldDecoration: pinPutDecoration.copyWith(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onSubmit: (pin) {
                              if (pin.length == 6) {
                                //_signInWithPhoneNumber();
                              } else {
                                ShowToast.showDialog("Invalid OTP", context);
                                //("Invalid OTP", Colors.red);
                              }
                            },
                            selectedFieldDecoration: pinPutDecoration,
                            followingFieldDecoration: pinPutDecoration.copyWith(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.withOpacity(.5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height / 75,
                          ),
                          Text(
                            "Please type the verification code send to\n${phone.text}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat-Regular',
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: Get.height / 75,
                          ),
                          RoundButton(
                            color: Color(0xff00CFC1),
                            onPressed: () async {
                              controller.isUserLogIn.value = true;
                              if (_pinPutController.text.length == 6) {
                                // AuthCredential credential =
                                //     await PhoneAuthProvider.credential(
                                //         verificationId: actualCode,
                                //         smsCode: _pinPutController.text);
                                // if (credential != null) {}
                                UserRegisterationModel model = await signIn(
                                  nameText: userName.text,
                                  emailText: email.text,
                                  passwordText: password.text,
                                  phoneText: phone.text,
                                  smsCode: _pinPutController.text,
                                );
                                if (model.success) {
                                  controller.isUserLogIn.value = false;
                                  ShowToast.showDialog(
                                      "User Retrieval Successfully", context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pages(),
                                    ),
                                  );
                                } else {
                                  controller.isUserLogIn.value = false;
                                  ShowToast.showDialog(
                                      "${model.message}", context);
                                }
                              } else {
                                controller.isUserLogIn.value = false;
                                ShowToast.showDialog("Invalid OTP", context);
                              }
                            },
                            text: 'Submit',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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

  /*
  * To Send OTP
  * */
  String smssent, verificationId;

  Future<void> sendOTP() async {
    controller.isUserLogIn.value = true;
    try {
      print('called');
      PhoneCodeAutoRetrievalTimeout autoRetrieve(String verId) {
        controller.isUserLogIn.value = false;
        ShowToast.showDialog('Auto Retrieval Timeout', context);
        this.verificationId = verId;
      }

      PhoneCodeSent smsCodeSent(String verId, [int forceCodeResent]) {
        controller.isUserLogIn.value = false;
        ShowToast.showDialog('Code Sent On Your Number', context);
        this.verificationId = verId;
        print("Code Sent");
        // _ackAlert(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => otpScreen(context, verId)));
      }

      PhoneVerificationCompleted verifiedSuccess(AuthCredential auth) {
        controller.isUserLogIn.value = false;
        print('phone verification is successful');
        ShowToast.showDialog('User Retrieve Successfully', context);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Pages(),
        //   ),
        // );
      }

      PhoneVerificationFailed verifyFailed(FirebaseAuthException e) {
        controller.isUserLogIn.value = false;
        print('${e.message}');
        ShowToast.showDialog('${e.message}', context);
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phone.text,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifyFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve,
      );
    } catch (e) {
      controller.isUserLogIn.value = false;
      Component.snackbarWidget(message: '$e');
      print('$e');
    }
  }

/*
* Check OTP*/
  Future signIn(
      {String nameText,
      String emailText,
      String phoneText,
      String passwordText,
      String smsCode}) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    String token = await _firebaseMessaging.getToken();

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((user) async {
      await NetworkDioHttp.setDynamicHeader(endPoint: BASE_URL);

      Map body = {
        "name": "$nameText",
        "email": "$emailText",
        "country_code": "+91",
        "mobile": "$phoneText",
        "password": "$passwordText",
        "device_token": "$token",
      };

      Map<String, String> header = {"Content-Type": "application/json"};

      http.Response response = await http.post(
        BASE_URL + REGISTER,
        body: jsonEncode(body),
        headers: header,
      );
      return userRegisterationModelFromJson(response.body);
      //return jsonDecode(response.body);

      Navigator.pushReplacementNamed(context, '/Pages');
    }).catchError((e) {
      print('$e');
      return {"success": "false", "message": "Failed to verify !"};
    });
  }

  bool _isValidate({
    String phone,
    String password,
    String name,
  }) {
    if (name.isEmpty) {
      ShowToast.showDialog('Enter your Full Name', context);
      return false;
    }
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
