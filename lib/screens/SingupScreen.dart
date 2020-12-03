import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:indglobalyomess/components/CommonInputField.dart';
import 'package:indglobalyomess/components/RoundButton.dart';
import 'package:indglobalyomess/screens/home_screen.dart';
import 'package:indglobalyomess/utils/Constant.dart';
import 'package:indglobalyomess/utils/Headline.dart';
import 'package:indglobalyomess/utils/pin_entry_text_field.dart';
import '../utils/app_config.dart' as config;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  DateTime currentBackPressTime;
  String _storageKeyMobileToken = 'token';
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  /**
   * Get device token from FireBase
   */
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
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
              padding: const EdgeInsets.all(8.0),
              child: PinEntryTextField(
                fields: 6,
                showFieldAsBox: true,
                isTextObscure: true,
                onSubmit: (String pin) {
                  print(pin);
                },
              ),
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                /*FirebaseAuth.instance.currentUser.then(
                  (user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      Navigator.of(context).pop();
                      signIn(smssent);
                    }
                  },
                );*/
                Navigator.pop(context);

                if (FirebaseAuth.instance.currentUser != null) {
                  print("----------------------------------------------------");
                  if (FirebaseAuth.instance.currentUser.uid.isNotEmpty) {
//                    Navigator.of(context).pop();
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => HomeScreen()),
//                    );
                    ShowToast.showDialog("Otp Verified", context);
                  } else {
                    ShowToast.showDialog("Wrong OTP", context);
                  }
                } else {
                  ShowToast.showDialog("Wrong OTP", context);
                }
              },
              child: Text(
                'done',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
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
                top: config.App(context).appHeight(29.5) - 120,
                left: 30,
                child: Container(
                  child: Text(
                    "Lets Start With Signup",
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
                          labelText: 'Full name',
                          hintText: 'John Deo',
                          prefixIcon: Icon(Icons.person_outline,
                              color: kPrimaryAuthOrangeColor),
                          type: TextInputType.text,
                          controller: name,
                        ),
                        SizedBox(height: 30),
                        CommonInputField(
                          labelText: 'Phone No',
                          hintText: '+911234567890',
                          prefixIcon: Icon(Icons.alternate_email,
                              color: kPrimaryAuthOrangeColor),
                          type: TextInputType.emailAddress,
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
                            _ackAlert(context);
                            /*sendOTP();*/

                            /*if (_isValidate(
                              password: password.text,
                              phone: phone.text,
                              name: name.text,
                            )) {
                              sendOTP();
                            }*/
                          },
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

  /*
  * To Send OTP
  * */
  String smssent, verificationId;
  Future<void> sendOTP() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      this.verificationId = verId;
      print("Code Sent");
      _ackAlert(context);
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone.text,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

/*
* Check OTP*/
  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }).catchError((e) {
      print(e);
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
