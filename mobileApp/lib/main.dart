import 'package:YouOweMe/resources/notifiers/contactProxyNotifier.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:YouOweMe/ui/IntroFlow/introFlow.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:YouOweMe/resources/helpers.dart';
import 'package:YouOweMe/ui/HomePage/homePage.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await StreamingSharedPreferences.instance;
  //Call Init HelperFunctions
  configureSystemChrome();
  runApp(MyApp(
    preferences: preferences,
  ));
}

class MyApp extends StatelessWidget {
  final StreamingSharedPreferences preferences;
  MyApp({@required this.preferences});
  @override
  Widget build(BuildContext context) {
    return PreferenceBuilder<bool>(
        preference:
            preferences.getBool('showDevicePreview', defaultValue: false),
        builder: (context, shouldShowDevicePreview) {
          return DevicePreview(
            enabled: shouldShowDevicePreview,
            builder: (BuildContext context) => MaterialApp(
                title: 'You Owe Me',
                builder: DevicePreview.appBuilder,
                theme: yomTheme,
                home: IntroFlow()),
          );
        });
  }
}

class Intermediate extends StatelessWidget {
  final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();
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
      child: MaterialApp(
          title: 'You Owe Me',
          builder: DevicePreview.appBuilder,
          theme: yomTheme,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: firebaseAnalytics)
          ],
          home: HomePage()),
    );
  }
}
