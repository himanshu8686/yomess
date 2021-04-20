import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenHeight = mediaQueryData.size.height;
    screenWidth = mediaQueryData.size.width;
    orientation = mediaQueryData.orientation;

    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;

    print('screen width : ${screenWidth}');
    print('screen height : ${screenHeight}');
    print('Orientation : ${orientation}');
    print('defaultSize : ${defaultSize}');
  }
}

//Get th proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;

  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

//Get th proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;

  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
