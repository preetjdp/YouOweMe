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
          Container(
            height: 100,
            decoration: BoxDecoration(color: Colors.white,
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
