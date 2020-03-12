import 'dart:ui';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

///This function is responsible for the Initial Configuration
///of [Hive](https://docs.hivedb.dev/)
///What does this do?
///1. Initialize Hive for the application.
///2. Open the Box `oweBox` which hosts all the owe's
Future<void> configureHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Owe>(OweAdapter());
  await Hive.openBox<Owe>("oweBox");
}
