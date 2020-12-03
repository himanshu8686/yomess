import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:indglobalyomess/utils/size_config.dart';

final kPrimaryAuthOrangeColor = Color(0xFFEA5C44);
final kPrimaryAuthWhiteColor = Color(0xFFFE0E5E9);
final kPrimaryBlueColor = Color(0xFF05CAF2);
final kWhitishGrey = Color(0xFFF8F8F8);
final kDarkGreen = Color(0xFF4ab14f);
final kLightGrey = Color(0xFF9E9E9E);

class Constant {
  static showtoast(String msg, BuildContext context) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        textColor: Colors.white);
  }

  static textproperty({var FontSize}) {
    return TextStyle(fontSize: FontSize, fontFamily: '', color: Colors.white);
  }

  static textBoldHeading({var kFontColor}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: SizeConfig.defaultSize * 1.8,
        color: kFontColor);
  }

  static normalBodyText(
      {var kFontColor, var fontSize, var height, var letterSpacing}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        // fontSize: SizeConfig.defaultSize * 1.6,
        fontSize: fontSize,
        height: height,
        letterSpacing: letterSpacing,
        color: kFontColor);
  }

  static textSubtitle({var kFontColor}) {
    return TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w300,
        fontSize: SizeConfig.defaultSize * 1.4,
        color: kFontColor);
  }
}

class ShowToast {
  static showDialog(String msg, context) {
    Toast.show(
      msg,
      context,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
      textColor: Colors.white,
    );
  }
}

const BASE_URL = 'https://phplaravel-187449-1606343.cloudwaysapps.com/api/';
const LOGIN = 'login';
const GOOGLE_LOGIN = 'google-login';
const FACEBOOK_LOGIN = 'facebook-login';

Future getSharedPrefData({String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var data = prefs.getString(key);
  return data;
}
