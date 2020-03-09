import 'package:flutter/material.dart';

import 'package:mobileApp/resources/helpers.dart';
import 'package:mobileApp/ui/HomePage/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Call Init HelperFunctions
    configureSystemChrome();
    return MaterialApp(
      title: 'You Owe Me',
      home: HomePage(),
    );
  }
}
