import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YomAvatar extends StatelessWidget {
  final String text;
  final double size;
  YomAvatar({this.size = 28, this.text = "PP"});
  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).accentColor;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: <Color>[
            color,
            Color.fromARGB(
              color.alpha,
              (color.red + 50).clamp(0, 255) as int,
              (color.green + 50).clamp(0, 255) as int,
              (color.blue + 50).clamp(0, 255) as int,
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.only(left: 8.0),
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: const TextStyle(
          color: CupertinoColors.white,
          fontSize: 13.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
