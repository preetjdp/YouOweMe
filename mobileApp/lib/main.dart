// 🐦 Flutter imports:
import 'package:YouOweMe/resources/notifiers/devicePreviewSetting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:YouOweMe/ui/IntroFlow/introFlow.dart';
import 'package:YouOweMe/resources/helpers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final preferences = await StreamingSharedPreferences.instance;
  configureSystemChrome();
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final devicePreviewSetting =
        useProvider(devicePreviewSettingProvider.state);
    return DevicePreview(
      enabled: devicePreviewSetting,
      builder: (BuildContext context) => MaterialApp(
          title: 'You Owe Me',
          builder: DevicePreview.appBuilder,
          theme: yomTheme(),
          home: IntroFlow()),
    );
  }
}

class Intermediate extends StatelessWidget {
  final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'You Owe Me',
        builder: DevicePreview.appBuilder,
        theme: yomTheme(),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: firebaseAnalytics)
        ],
        onGenerateRoute: routeGenerator);
  }
}
