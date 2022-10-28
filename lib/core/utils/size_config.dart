import 'package:flutter/material.dart';

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double defaultSize = 0;
  // static late Orientation orientation;

  void init(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    // Orientation orientation = mediaQueryData.orientation;
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
  }
}

// Getting the proportionate height per screen size compared to UI design
double getProportionateScreenHeight(double height) {
  double screenHeight = SizeConfig.screenHeight;
  // 800px was used by UI designer
  return (height / 800) * screenHeight;
}

// Getting the proportionate width per screen size compared to UI design
double getProportionateScreenWidth(double width) {
  double screenWidth = SizeConfig.screenWidth;
  // 360px was used by UI designer
  return (width / 360) * screenWidth;
}
