import 'package:YouOweMe/resources/helpers/firebaseDynamicLinks/bottomSheet.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:basics/basics.dart';

Future<void> configureFirebaseDynamicLinks(BuildContext context) async {
  PendingDynamicLinkData linkData =
      await FirebaseDynamicLinks.instance.getInitialLink();

  if (linkData.isNotNull) {
    Uri link = linkData.link;
    String oweId = link.pathSegments[1];
    showBottomSheet(context, oweId: oweId);
  }

  FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData linkData) {
    Uri link = linkData.link;
    String oweId = link.pathSegments[1];
    showBottomSheet(context, oweId: oweId);
    return;
  });
}

void showBottomSheet(BuildContext context, {@required String oweId}) {
  TargetPlatform platform = Theme.of(context).platform;
  Widget builder(BuildContext context, ScrollController scrollController) =>
      FirebaseDynamicLinkBottomSheet(
        scrollController: scrollController,
        oweId: oweId,
      );
  if (platform == TargetPlatform.iOS) {
    showCupertinoModalBottomSheet(context: context, builder: builder);
  } else {
    showMaterialModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: builder);
  }
}
