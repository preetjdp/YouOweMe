import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData yomTheme = ThemeData(
    fontFamily: "Aileron",
    scaffoldBackgroundColor: Color.fromRGBO(241, 245, 249, 1),
    backgroundColor: Color.fromRGBO(241, 245, 249, 1),
    //This Color is used to set GlowingOverscroll Indicator
    accentColor: Color.fromRGBO(52, 59, 70, 1),
    cupertinoOverrideTheme:
        CupertinoThemeData(primaryColor: Color.fromRGBO(52, 59, 70, 1)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color.fromRGBO(52, 59, 70, 1),
      elevation: 2,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(78, 80, 88, 1)),
      headline2: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(78, 80, 88, 1)),
      headline3: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(78, 80, 88, 1)),
      headline6: TextStyle(
          fontSize: 100,
          fontWeight: FontWeight.w800,
          color: Color.fromRGBO(78, 80, 88, 1)),
      bodyText2: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Color.fromRGBO(78, 80, 88, 1)),
    ));
