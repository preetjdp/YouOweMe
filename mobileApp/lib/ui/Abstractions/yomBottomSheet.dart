// 🐦 Flutter imports:
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:YouOweMe/resources/extensions.dart';

Future<T> showYomBottomSheet<T>(
    {@required BuildContext context, @required ScrollWidgetBuilder builder}) {
  YomDesign yomDesign = context.yomDesign;
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
        shape: _roundedBorder,
        duration: Duration(milliseconds: 400),
        animationCurve: yomDesign.yomCurve,
        );
  } else {
    return showMaterialModalBottomSheet(
        context: context,
        builder: builder,
        backgroundColor: Colors.white,
        shape: _roundedBorder,
        duration: Duration(milliseconds: 400),
        animationCurve: yomDesign.yomCurve);
  }
}
