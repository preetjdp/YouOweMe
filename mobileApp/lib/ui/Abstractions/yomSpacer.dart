import 'package:flutter/material.dart';

class YomSpacer extends StatelessWidget {
  final double height;
  final double width;
  YomSpacer({this.height = 0, this.width = 0});
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}

class SliverYomSpacer extends StatelessWidget {
  final double height;
  final double width;
  SliverYomSpacer({this.height = 0, this.width = 0});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: YomSpacer(
        height: height,
        width: width,
      ),
    );
  }
}
