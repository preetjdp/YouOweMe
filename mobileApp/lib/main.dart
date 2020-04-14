import 'package:YouOweMe/resources/databaseService.dart';
import 'package:YouOweMe/resources/notifiers/contactProxyNotifier.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:YouOweMe/ui/IntroFlow/introFlow.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:YouOweMe/resources/helpers.dart';
import 'package:YouOweMe/ui/HomePage/homePage.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(DevicePreview(
    enabled: false,
    builder: (BuildContext context) => MaterialApp(
        builder: DevicePreview.appBuilder, theme: yomTheme, home: IntroFlow()),
  ));
}

class Intermediate extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),
        ChangeNotifierProxyProvider<FirebaseUser, MeNotifier>(
          create: (BuildContext context) => MeNotifier(context),
          update: (context, firebaseUser, meNotifier) =>
              meNotifier..onProxyUpdate(firebaseUser),
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
      theme: yomTheme,
      home: HomePage(),
    );
  }
}
