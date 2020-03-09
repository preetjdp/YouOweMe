import 'package:flutter/material.dart';

import 'package:YouOweMe/ui/HomePage/oweMe.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(241, 245, 249, 1),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color.fromRGBO(52, 59, 70, 1),
          label: Text('New'),
          icon: Icon(Icons.add),
          elevation: 2,
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[OweMe()],
            ),
          ),
        ));
  }
}
