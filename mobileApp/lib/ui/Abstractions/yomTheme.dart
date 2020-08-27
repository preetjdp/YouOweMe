// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YomDesign {
  // static final YomDesign _singleton = new YomDesign._internal();

  // factory YomDesign() {
  //   return _singleton;
  // }

  YomDesign() {
    yomTextTheme = TextTheme(
      headline1: TextStyle(
        fontSize: yomSize1,
        fontWeight: FontWeight.w600,
        color: yomGrey2,
      ),
      // Not Used Anywhere
      headline2: TextStyle(
          fontSize: yomSize3, fontWeight: FontWeight.bold, color: yomGrey2),
      headline3: TextStyle(
          fontSize: yomSize5, fontWeight: FontWeight.bold, color: yomGrey2),
      // Not Used Much
      headline4: TextStyle(
          fontSize: yomSize7, fontWeight: FontWeight.bold, color: yomGrey2),
      headline5: TextStyle(
          fontSize: yomSize8, fontWeight: FontWeight.bold, color: yomGrey2),
      // Not Used Much
      headline6: TextStyle(
          fontSize: yomSize10, fontWeight: FontWeight.bold, color: yomGrey2),
      bodyText1: TextStyle(
          fontSize: yomSize8, fontWeight: FontWeight.normal, color: yomGrey2),
      bodyText2: TextStyle(
          fontSize: yomSize9, fontWeight: FontWeight.normal, color: yomGrey2),
      subtitle1: TextStyle(
          fontSize: yomSize10,
          fontWeight: FontWeight.normal,
          color: Colors.black),
      subtitle2: TextStyle(
          fontSize: yomSize11,
          fontWeight: FontWeight.normal,
          color: Colors.black),
    );
  }

  static double yomSize1 = 100;
  double yomSize2 = 96;
  double yomSize3 = 80;
  double yomSize4 = 64;
  double yomSize5 = 52;
  double yomSize6 = 36;
  double yomSize7 = 28;
  double yomSize8 = 20;
  double yomSize9 = 18;
  double yomSize10 = 16;
  double yomSize11 = 12;
  double yomSize12 = 8;
  Color yomWhite = Color.fromRGBO(241, 245, 249, 1);
  Color yomGrey1 = Color.fromRGBO(52, 59, 70, 1);
  Color yomGrey2 = Color.fromRGBO(78, 80, 88, 1);

  Curve yomCurve = Curves.easeInOutQuad;

  TextTheme yomTextTheme;
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
      textTheme: yomDesign.yomTextTheme,
      accentTextTheme:
          GoogleFonts.poppinsTextTheme().merge(yomDesign.yomTextTheme),
      useTextSelectionTheme: true,
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: yomDesign.yomGrey1,
          selectionHandleColor: yomDesign.yomGrey1,
          selectionColor: yomDesign.yomGrey1.withOpacity(0.3)));
}
