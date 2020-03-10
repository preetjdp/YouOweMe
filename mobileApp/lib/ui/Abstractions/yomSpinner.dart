import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YOMSpinner extends StatelessWidget {
  final Color spinnerColor;
  YOMSpinner({this.spinnerColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    TargetPlatform platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS) {
      return CupertinoActivityIndicator();
    } else {
      return CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(spinnerColor));
    }
  }
}
