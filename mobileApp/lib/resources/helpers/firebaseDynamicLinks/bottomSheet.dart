import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:flutter/material.dart';

class FirebaseDynamicLinkBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  final String oweId;
  FirebaseDynamicLinkBottomSheet(
      {@required this.scrollController, @required this.oweId});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: Material(
        child: Container(
          height: 400,
          child: Center(
            child: YOMSpinner()
          ),
        ),
      ),
    );
  }
}
