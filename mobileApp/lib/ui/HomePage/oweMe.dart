import 'package:flutter/material.dart';

class OweMe extends StatelessWidget {
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
                  Text(
                    "Owe Me",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(78, 80, 88, 1)),
                  ),
                  Icon(Icons.keyboard_arrow_right,
                  color: Color.fromRGBO(78, 80, 88, 1),
                  )
                ],
              )),
          Container(
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
          )
        ],
      ),
    );
  }
}
