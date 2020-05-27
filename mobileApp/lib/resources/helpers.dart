// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:basics/basics.dart';
import 'package:http/http.dart';

void configureSystemChrome() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color.fromRGBO(241, 245, 249, 1),
      systemNavigationBarIconBrightness: Brightness.dark));
}

Future<GraphQLClient> getGraphqlClient(String userId) async {
  final HttpLink httpLink =
      HttpLink(uri: await getSevaUrl(), headers: {"authorization": userId});

  return GraphQLClient(
    cache: InMemoryCache(),
    link: httpLink,
  );
}

/// Gets the Url to be used for theGraphQLClient
/// Fyi. Add's 2 Second Timout on mobile
Future<String> getSevaUrl() async {
  String localSevaUrl = "http://192.168.31.76:4001";
  String productionSevaUrl = "https://api.youoweme.preetjdp.dev";
  if (kReleaseMode) {
    print("Using Production Seva In Release");
    return productionSevaUrl;
  }
  try {
    Response response = await get(localSevaUrl).timeout(Duration(seconds: 2));
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Using Local Seva");
      return localSevaUrl;
    } else {
      throw "Could Not Connect to Local Seva";
    }
  } catch (e) {
    print("Using Production Seva");
    return productionSevaUrl;
  }
}

Future<bool> toggleDevicePreview() async {
  final preferences = await StreamingSharedPreferences.instance;
  Preference<bool> devicePreviewPref =
      preferences.getBool('showDevicePreview', defaultValue: false);
  bool currentState = devicePreviewPref.getValue();
  return devicePreviewPref.setValue(!currentState);
}

Future<String> configureFirebaseMessenging(BuildContext context) async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.requestNotificationPermissions();
  String token = await _firebaseMessaging.getToken();
  if (token.isNull) {
    return null;
  }
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    },
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    },
  );
  return token;
}

String getDayOfMonthSuffix(final int n) {
  if (n >= 11 && n <= 13) {
    return "th";
  }
  switch (n % 10) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
}
