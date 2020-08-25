// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double yomAvatarDefaultSize = 45;
const double yomAvatarFontSize = 13;

class YomAvatar extends StatelessWidget {
  final String text;
  final double size;
  final VoidCallback onPressed;
  YomAvatar(
      {this.size = yomAvatarDefaultSize, this.text = "PP", this.onPressed});
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
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: yomAvatarFontSize * (size / yomAvatarDefaultSize),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
