import 'package:YouOweMe/ui/HomePage/bottomList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';

class NewOwe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void onButtonPressed() {
      Navigator.pop(context);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: onButtonPressed,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(),
              Text(
                "Title",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(78, 80, 88, 1)),
              ),
              TextField(
                cursorColor: Theme.of(context).accentColor,
                decoration: InputDecoration.collapsed(
                  hintText: "Enter the reasoning behind this transaction",
                ),
                maxLines: 2,
              ),
              Text(
                "Recent People",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(78, 80, 88, 1)),
              ),
              BottomList(),
              Text(
                "Amount",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(78, 80, 88, 1)),
              ),
              Center(
                child: TextField(
                  cursorColor: Theme.of(context).accentColor,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "00",
                    border: InputBorder.none,
                    prefixText: "₹",
                  ),
                  style: TextStyle(fontSize: 100, fontWeight: FontWeight.w800,
                  color: Theme.of(context).accentColor
                  ),
                ),
              ),
              Container(
                height: 60,
                width: 400,
                child: CupertinoButton.filled(
                  disabledColor: Theme.of(context).accentColor,
                    child: Text('Done'), onPressed: () {}),
              )
              // Center(
              //   child: Text(
              //     "₹ 89",
              //     style: TextStyle(fontSize: 100, fontWeight: FontWeight.w800),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
