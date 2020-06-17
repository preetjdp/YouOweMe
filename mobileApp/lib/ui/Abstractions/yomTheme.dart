// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YomDesign {
  double fontSizeH1 = 100;
  double fontSizeH2 = 80;
  double fontSizeH3 = 50;
  double fontSizeH4 = 28;
  double fontSizeH5 = 20;
  double fontSizeH6 = 14;

  Color yomWhite = Color.fromRGBO(241, 245, 249, 1);
  Color yomGrey1 = Color.fromRGBO(52, 59, 70, 1);
  Color yomGrey2 = Color.fromRGBO(78, 80, 88, 1);

  Curve yomCurve = Curves.easeInOutQuad;
}

ThemeData yomTheme() {
  YomDesign yomDesign = YomDesign();
  return ThemeData(
      fontFamily: "Aileron",
      scaffoldBackgroundColor: yomDesign.yomWhite,
      backgroundColor: yomDesign.yomWhite,
      accentColor: yomDesign.yomGrey1,
      cupertinoOverrideTheme:
          CupertinoThemeData(primaryColor: yomDesign.yomGrey1),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: yomDesign.yomGrey1,
        elevation: 2,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: yomDesign.fontSizeH1,
            fontWeight: FontWeight.bold,
            color: yomDesign.yomGrey2),
        headline2: TextStyle(
            fontSize: yomDesign.fontSizeH2,
            fontWeight: FontWeight.bold,
            color: yomDesign.yomGrey2),
        headline3: TextStyle(
            fontSize: yomDesign.fontSizeH3,
            fontWeight: FontWeight.bold,
            color: yomDesign.yomGrey2),
        headline4: TextStyle(
            fontSize: yomDesign.fontSizeH4,
            fontWeight: FontWeight.bold,
            color: yomDesign.yomGrey2),
        headline5: TextStyle(
            fontSize: yomDesign.fontSizeH5,
            fontWeight: FontWeight.bold,
            color: yomDesign.yomGrey2),
        headline6: TextStyle(
            fontSize: yomDesign.fontSizeH6,
            fontWeight: FontWeight.bold,
            color: yomDesign.yomGrey2),
        bodyText2: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: yomDesign.yomGrey2),
      ));
}
