// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/providers.dart';
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:YouOweMe/ui/IntroFlow/introFlow.dart';
import 'package:YouOweMe/resources/helpers.dart';

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
                theme: yomTheme(),
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
      providers: yomProviders,
      child: MaterialApp(
          title: 'You Owe Me',
          builder: DevicePreview.appBuilder,
          theme: yomTheme(),
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: firebaseAnalytics)
          ],
          onGenerateRoute: routeGenerator),
    );
  }
}
