import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/foundation.dart';

Future<T> showYomButtomSheet<T>(
    {@required BuildContext context, @required ScrollWidgetBuilder builder}) {
  TargetPlatform platform = Theme.of(context).platform;

  Radius _radius = Radius.circular(15);

  RoundedRectangleBorder _roundedBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: _radius, topRight: _radius));

  if (platform == TargetPlatform.iOS) {
    return showCupertinoModalBottomSheet(
        context: context,
        builder: builder,
        backgroundColor: Colors.white,
        topRadius: _radius,
        shape: _roundedBorder);
  } else {
    return showMaterialModalBottomSheet(
        context: context,
        builder: builder,
        backgroundColor: Colors.white,
        shape: _roundedBorder);
  }
}
