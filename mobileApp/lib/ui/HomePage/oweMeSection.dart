import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class OweMeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
              left: 0,
              top: 0,
              child: Row(
                children: <Widget>[
                  Text("Owe Me", style: Theme.of(context).textTheme.headline3),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Color.fromRGBO(78, 80, 88, 1),
                  )
                ],
              )),
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Color.fromRGBO(78, 80, 88, 0.05),
                        spreadRadius: 0.1)
                  ]),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          Provider.of<MeNotifier>(context, listen: true)
                              ?.me
                              ?.oweMeAmount
                              ?.toString() ?? "wow",
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).accentColor))
                    ],
                  )),
            ),
          ),
          // Positioned(
          //   right: 15,
          //   top: 0,
          //   bottom: 15,
          //   child: Container(
          //       width: 180,
          //       decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(10),
          //           boxShadow: [
          //             BoxShadow(
          //                 blurRadius: 10,
          //                 color: Color.fromRGBO(78, 80, 88, 0.2),
          //                 spreadRadius: 0.1)
          //           ]),
          //       child: ValueListenableBuilder(
          //           valueListenable: oweBox.listenable(),
          //           builder: (BuildContext context, Box<Owe> box, _) {
          //             if (box.values.isNotEmpty) {
          //               return Center(
          //                 child: Text(
          //                   box.values.last.title,
          //                 ),
          //               );
          //             } else {
          //               return Center(
          //                 child: YOMSpinner(),
          //               );
          //             }
          //           })
          //           ),
          // ),
        ],
      ),
    );
  }
}
