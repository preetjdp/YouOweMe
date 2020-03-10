import 'package:flutter/material.dart';

class BottomList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          EdgeInsets margin = EdgeInsets.all(10);
          return Container(
            margin: index != 0 ? margin : margin.copyWith(left: 0),
            // height: 100,
            width: 130,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Color.fromRGBO(78, 80, 88, 0.05),
                      spreadRadius: 0.1)
                ]),
          );
        },
      ),
    );
  }
}
