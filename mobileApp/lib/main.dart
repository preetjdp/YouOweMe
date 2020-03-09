import 'package:flutter/material.dart';

import 'package:YouOweMe/resources/helpers.dart';
import 'package:YouOweMe/ui/HomePage/homePage.dart';

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
