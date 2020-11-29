import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

final kPrimaryAuthOrangeColor = Color(0xFFEA5C44);
final kPrimaryAuthWhiteColor = Color(0xFFFE0E5E9);
final kPrimaryBlueColor = Color(0xFF05CAF2);
final kWhitishGrey = Color(0xFFF8F8F8);

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
}
