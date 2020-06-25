import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:YouOweMe/ui/HomePage/providers.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:YouOweMe/resources/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const double _topDefaultState = 150.0;
const double _bottomDefaultState = 350.0;

const double _topParallaxFactor = 0.8;
const double _bottomParallaxFactor = 1.5;

class BackgroundAnimation extends StatefulWidget {
  @override
  _BackgroundAnimationState createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation>
    with TickerProviderStateMixin, AfterLayoutMixin {
  AnimationController _topController;
  AnimationController _bottomController;
  YomDesign yomDesign = YomDesign();

  @override
  void initState() {
    super.initState();
    _topController = AnimationController(
        vsync: this, lowerBound: 0, upperBound: double.infinity);
    _bottomController = AnimationController(
        vsync: this, lowerBound: 0, upperBound: double.infinity);
    Future.delayed(Duration(milliseconds: 700), () {
      _topController.yomAnimateTo(
        _topDefaultState,
        duration: Duration(milliseconds: 500),
      );
      _bottomController.yomAnimateTo(
        _bottomDefaultState,
        duration: Duration(milliseconds: 500),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _topController.dispose();
    _bottomController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [yomDesign.yomPurple1, yomDesign.yomPurple2])),
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
                animation: _topController,
                builder: (context, snapshot) {
                  return ClipPath(
                      clipper: TopCustomClipper(),
                      child: Container(
                        height: _topController.value,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                              yomDesign.yomGreen1,
                              yomDesign.yomGreen2
                            ])),
                      ));
                })),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
                animation: _bottomController,
                builder: (context, snapshot) {
                  return ClipPath(
                      clipper: BottomCustomClipper(),
                      child: Container(
                        height: _bottomController.value,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ));
                })),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    final scrollController = homePageScrollControllerProvder.read(context);

    scrollController.addListener(() async {
      double maxExtent = scrollController.position.maxScrollExtent;
      double extent = scrollController.offset;
      double percentChange = extent / maxExtent;
      print(
          "[SCROLL STAUS ==> Extent -> $extent maxExtent -> $maxExtent  percentChange -> $percentChange]");
      if (percentChange == 0.0) {
        _topController.yomAnimateTo(_topDefaultState);
        _bottomController.yomAnimateTo(_bottomDefaultState);
      } else {
        await Future.delayed(Duration(milliseconds: 20));
        _topController.yomAnimateTo(_topDefaultState -
            (percentChange * _topParallaxFactor * maxExtent));
        _bottomController.yomAnimateTo(_bottomDefaultState +
            (percentChange * _bottomParallaxFactor * maxExtent));
      }
    });
  }
}

class TopCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0.0);
    path.lineTo(0, size.height);
    // path.quadraticBezierTo(
    //     size.width / 2, size.height - 50, size.width, size.height);
    path.arcToPoint(Offset(size.width, size.height),
        radius: Radius.elliptical(50, 5));
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class BottomCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    // path.cubicTo(120, 180, size.width / 2, 50, size.width, 0);
    path.cubicTo(size.width / 2 - 50, 150, size.width / 2, 50, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
