// 🎯 Dart imports:
import 'dart:math' as math;

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class ExpandingWidgetDelegate extends SliverPersistentHeaderDelegate {
  ExpandingWidgetDelegate({
    @required this.minWidth,
    @required this.maxWidth,
    @required this.child,
  });
  final double minWidth;
  final double maxWidth;
  final Widget child;
  @override
  double get minExtent => minWidth;
  @override
  double get maxExtent => math.max(maxWidth, minWidth);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(ExpandingWidgetDelegate oldDelegate) {
    return maxWidth != oldDelegate.maxWidth ||
        minWidth != oldDelegate.minWidth ||
        child != oldDelegate.child;
  }
}
