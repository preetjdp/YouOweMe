import 'dart:ui';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:YouOweMe/resources/models/owe.dart';

void configureSystemChrome() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color.fromRGBO(241, 245, 249, 1),
      systemNavigationBarIconBrightness: Brightness.dark));
}


ValueNotifier<GraphQLClient> configureGraphQL() {
  final HttpLink httpLink = HttpLink(
      uri: 'https://api.youoweme.preetjdp.dev/',
      headers: {"authorization": "f9fc7B6wvIsU62LuDNVv"});

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    ),
  );

  return client;
}
