// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YomDesign {
  // double fontSizeH1 = 100;
  // double fontSizeH2 = 80;
  // double fontSizeH3 = 50;
  // double fontSizeH4 = 28;
  // double fontSizeH5 = 20;
  // double fontSizeH6 = 14;

  double yomSize1 = 100;
  double yomSize2 = 96;
  double yomSize3 = 80;
  double yomSize4 = 64;
  double yomSize5 = 52;
  double yomSize6 = 36;
  double yomSize7 = 28;
  double yomSize8 = 20;
  double yomSize9 = 14;
  double yomSize10 = 12;
  double yomSize11 = 8;

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
          fontSize: yomDesign.yomSize1,
          fontWeight: FontWeight.bold,
          color: yomDesign.yomGrey2,
        ),
        headline2: TextStyle(
            fontSize: yomDesign.yomSize3,
            fontWeight: FontWeight.bold,
            color: yomDesign.yomGrey2),
        headline3: TextStyle(
            fontSize: yomDesign.yomSize5,
            fontWeight: FontWeight.bold,
            color: yomDesign.yomGrey2),
        headline4: TextStyle(
            fontSize: yomDesign.yomSize7,
            fontWeight: FontWeight.bold,
            color: yomDesign.yomGrey2),
        headline5: TextStyle(
            fontSize: yomDesign.yomSize8,
            fontWeight: FontWeight.bold,
            color: yomDesign.yomGrey2),
        headline6: TextStyle(
            fontSize: yomDesign.yomSize9,
            fontWeight: FontWeight.bold,
            color: yomDesign.yomGrey2),
        bodyText2: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: yomDesign.yomGrey2),
        subtitle2: TextStyle(
            fontSize: yomDesign.yomSize9,
            fontWeight: FontWeight.normal,
            color: Colors.black),
      ),
      accentTextTheme: GoogleFonts.poppinsTextTheme(),
      useTextSelectionTheme: true,
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: yomDesign.yomGrey1,
          selectionHandleColor: yomDesign.yomGrey1,
          selectionColor: yomDesign.yomGrey1.withOpacity(0.3)));
}
