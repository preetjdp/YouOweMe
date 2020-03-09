import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void configureSystemChrome() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color.fromRGBO(241,245,249, 1),
      systemNavigationBarIconBrightness: Brightness.dark));
}
