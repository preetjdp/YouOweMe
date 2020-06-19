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

  Color yomWhite1 = Color.fromRGBO(241, 245, 249, 1);
  Color yomWhite2 = Colors.white;
  Color yomGrey1 = Color.fromRGBO(52, 59, 70, 1);
  Color yomGrey2 = Color.fromRGBO(78, 80, 88, 1);

  Curve yomCurve = Curves.easeInOutQuad;
  BoxShadow yomBoxShadow = BoxShadow(
      blurRadius: 10,
      color: Color.fromRGBO(78, 80, 88, 0.05),
      spreadRadius: 0.1);
}

ThemeData yomTheme() {
  YomDesign yomDesign = YomDesign();
  return ThemeData(
      fontFamily: "Aileron",
      scaffoldBackgroundColor: yomDesign.yomWhite1,
      backgroundColor: yomDesign.yomWhite1,
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
