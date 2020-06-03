import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showYomButtomSheet(BuildContext context, {@required Widget widget}) {
  TargetPlatform platform = Theme.of(context).platform;

  Widget builder(BuildContext context, ScrollController scrollController) =>
      widget;

  if (platform == TargetPlatform.iOS) {
    showCupertinoModalBottomSheet(context: context, builder: builder);
  } else {
    showMaterialModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: builder);
  }
}
