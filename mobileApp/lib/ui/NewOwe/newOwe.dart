import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/ui/NewOwe/peopleList.dart';

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
        child: ListView(
          padding: EdgeInsets.all(15),
          // crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(
              height: 10,
            ),
            Text(
              "Select Person",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(78, 80, 88, 1)),
            ),
            PeopleList(),
            SizedBox(
              height: 10,
            ),
            Text(
              "How much money did you lend?",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(78, 80, 88, 1)),
            ),
            Container(
              height: 200,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "₹",
                    style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).accentColor),
                  ),
                  Expanded(
                    child: TextField(
                        cursorColor: Theme.of(context).accentColor,
                        decoration: InputDecoration(
                          hintText: "00",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                        ),
                        style: TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).accentColor),
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: false, signed: false)),
                  ),
                ],
              ),
            ),

            Container(
              height: 60,
              width: 400,
              child: CupertinoButton.filled(
                  disabledColor: Theme.of(context).accentColor,
                  child: Text('Done'),
                  onPressed: () {}),
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
    );
  }
}
