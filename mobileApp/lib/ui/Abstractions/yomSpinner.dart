// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YOMSpinner extends StatelessWidget {
  final Brightness brightness;
  YOMSpinner({this.brightness = Brightness.light});
  @override
  Widget build(BuildContext context) {
    Color spinnerColor;
    if (brightness == Brightness.dark) {
      spinnerColor = Colors.white;
    } else {
      spinnerColor = Theme.of(context).accentColor;
    }
    TargetPlatform platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS) {
      return Theme(
          data: ThemeData(
              cupertinoOverrideTheme:
                  CupertinoThemeData(brightness: brightness)),
          child: CupertinoActivityIndicator());
    } else {
      return CircularProgressIndicator(
          strokeWidth: 4,
          valueColor: AlwaysStoppedAnimation<Color>(spinnerColor));
    }
  }
}
