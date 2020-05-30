// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YomAvatar extends StatelessWidget {
  final String text;
  final double size;
  final VoidCallback onPressed;
  YomAvatar({this.size = 45, this.text = "PP", this.onPressed});
  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).accentColor;
    return CupertinoButton(
      minSize: 0,
      onPressed: onPressed,
      padding: EdgeInsets.all(0),
      child: Container(
        height: size,
        width: size,
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
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
