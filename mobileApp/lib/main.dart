import 'package:YouOweMe/resources/databaseService.dart';
import 'package:YouOweMe/resources/notifiers/contactProxyNotifier.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/IntroFlow/AuthFlow/authFlow.dart';
import 'package:YouOweMe/ui/IntroFlow/introFlow.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:YouOweMe/resources/helpers.dart';
import 'package:YouOweMe/ui/HomePage/homePage.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  if (!kReleaseMode) {
    runApp(DevicePreview(
      builder: (BuildContext context) => MaterialApp(
          builder: DevicePreview.appBuilder,
          theme: ThemeData(
              fontFamily: "Aileron",
              scaffoldBackgroundColor: Color.fromRGBO(241, 245, 249, 1),
              //This Color is used to set GlowingOverscroll Indicator
              accentColor: Color.fromRGBO(52, 59, 70, 1),
              cupertinoOverrideTheme: CupertinoThemeData(
                  primaryColor: Color.fromRGBO(52, 59, 70, 1)),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Color.fromRGBO(52, 59, 70, 1),
                elevation: 2,
              ),
              textTheme: TextTheme(
                  headline1: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(78, 80, 88, 1)),
                  headline3: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(78, 80, 88, 1)))),
          home: IntroFlow()),
    ));
  } else {
    runApp(MaterialApp(
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
            fontFamily: "Aileron",
            scaffoldBackgroundColor: Color.fromRGBO(241, 245, 249, 1),
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
                headline3: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(78, 80, 88, 1)))),
        home: IntroFlow()));
  }
}

class Intermediate extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MeNotifier>(
          create: (BuildContext context) => MeNotifier(context),
          lazy: false,
        ),
        FutureProvider<Iterable<Contact>>(
          create: (a) => ContactsService.getContacts(withThumbnails: false),
          lazy: false,
          initialData: [],
        ),
        ChangeNotifierProxyProvider<Iterable<Contact>, ContactProxyNotifier>(
          create: (BuildContext context) => ContactProxyNotifier(),
          update: (BuildContext context, a, b) => b..update(a),
          lazy: false,
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Call Init HelperFunctions
    configureSystemChrome();
    return MaterialApp(
      title: 'You Owe Me',
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
          fontFamily: "Aileron",
          scaffoldBackgroundColor: Color.fromRGBO(241, 245, 249, 1),
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
              headline3: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(78, 80, 88, 1)))),
      home: HomePage(),
    );
  }
}
