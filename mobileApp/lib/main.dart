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
      theme: ThemeData(
          fontFamily: "Aileron",
          scaffoldBackgroundColor: Color.fromRGBO(241, 245, 249, 1),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color.fromRGBO(52, 59, 70, 1),
            elevation: 2,
          )),
      home: HomePage(),
    );
  }
}
