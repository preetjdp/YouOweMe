// 🎯 Dart imports:
import 'dart:math';
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
      onBackgroundMessage: backgroundMessagehandler);
  return token;
}

Future<dynamic> backgroundMessagehandler(Map<String, dynamic> data) async {
  await configureLocalNotifications();
  print("Background Message: $data");
  String channelId = "owe_request";
  String channelName = "Owe Request";
  String channelDescription = 'This is an Incoming Owe Request. Which Means';
  // String groupKey = 'dev.preetjdp.youoweme.OWE_REQUEST_GROUP';

  String notificationTitle = data['data']['title'];
  String notificationBody = data['data']['body'];
  String oweId = data['data']['oweId'];

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Random random = Random();
  int notificationId = random.nextInt(500);

  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(channelId, channelName, channelDescription);

  IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

  NotificationDetails notificationDetails =
      NotificationDetails(androidNotificationDetails, iosNotificationDetails);

  return await flutterLocalNotificationsPlugin.show(
      notificationId, notificationTitle, notificationBody, notificationDetails,
      actions: [
        NotificationAction(
            title: "Accpet Owe Request",
            icon: "owe_icon",
            actionKey: "accept_owe",
            extras: {"id": notificationId.toString(), "oweId": oweId}),
        NotificationAction(
            title: "Decline Owe Request",
            icon: "owe_icon",
            actionKey: "decline_owe",
            extras: {"id": notificationId.toString(), "oweId": oweId})
      ]);
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

Future<bool> configureLocalNotifications() {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  IOSInitializationSettings iosInitializationSettings =
      IOSInitializationSettings();
  AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  InitializationSettings initializationSettings = InitializationSettings(
      androidInitializationSettings, iosInitializationSettings);
  return flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification,
      onNotificationActionTapped: onSelectNotificationAction);
}

Future<bool> onSelectNotification(String a) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.ca
  print("From On Slect Notification ==> " + a);
  return true;
}

Future onSelectNotificationAction(
    String actionKey, Map<String, String> extras) async {
  print(actionKey + extras.toString());
  print("Notification Action Selected");
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.cancel(int.tryParse(extras['id']));
}
