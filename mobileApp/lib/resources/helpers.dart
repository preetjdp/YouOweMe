import 'dart:ui';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

void configureSystemChrome() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color.fromRGBO(241, 245, 249, 1),
      systemNavigationBarIconBrightness: Brightness.dark));
}

ValueNotifier<GraphQLClient> configureGraphQL() {
  final HttpLink httpLink = HttpLink(
      uri: 'https://youoweme-6c622.appspot.com/',
      headers: {"authorization": "f9fc7B6wvIsU62LuDNVv"});

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    ),
  );

  return client;
}

Future<bool> toggleDevicePreview() async {
  final preferences = await StreamingSharedPreferences.instance;
  Preference<bool> devicePreviewPref =
      preferences.getBool('showDevicePreview', defaultValue: false);
  bool currentState = devicePreviewPref.getValue();
  return devicePreviewPref.setValue(!currentState);
}
