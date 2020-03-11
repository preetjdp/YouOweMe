import 'package:flutter/material.dart';

class PeopleList extends StatelessWidget {
  final List<String> people = ["Preet Parekh", "Tanay Modi","Elizabeth Cooper"];
  final EdgeInsets margin = EdgeInsets.all(10);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              margin: margin.copyWith(left: 0),
              // height: 100,
              width: 80,
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Color.fromRGBO(78, 80, 88, 0.05),
                        spreadRadius: 0.1)
                  ]),
              child: Center(
                  child: Icon(
                Icons.add,
                size: 38,
                color: Colors.white,
              )),
            ),
            ...people
                .map((e) => Container(
                      margin: margin.copyWith(left: 0),
                      padding: EdgeInsets.all(5),
                      // height: 100,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Color.fromRGBO(78, 80, 88, 0.05),
                                spreadRadius: 0.1)
                          ]),
                      child: Center(
                        child: Text(
                          e,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ))
                .toList()
          ],
        ));
  }
}
