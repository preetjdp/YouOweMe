import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:flutter/material.dart';

const double _topDefaultState = 150.0;
const double _bottomDefaultState = 350.0;

const double _topParallaxFactor = 0.8;
const double _bottomParallaxFactor = 1.5;

class ForegroundAnimation extends StatefulWidget {
  @override
  _ForegroundAnimationState createState() => _ForegroundAnimationState();
}

class _ForegroundAnimationState extends State<ForegroundAnimation>
    with TickerProviderStateMixin {
  AnimationController _topController;
  AnimationController _bottomController;
  YomDesign yomDesign = YomDesign();

  @override
  void initState() {
    super.initState();
    _topController = AnimationController(
        vsync: this, value: 500, lowerBound: 0, upperBound: double.infinity);
    _bottomController = AnimationController(
        vsync: this, value: 500, lowerBound: 0, upperBound: double.infinity);
    Future.delayed(Duration(seconds: 1), () {
      _topController.yomAnimateTo(
        0,
        duration: Duration(milliseconds: 500),
      );
      _bottomController.yomAnimateTo(
        0,
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
                        decoration: BoxDecoration(color: Colors.black),
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
                        decoration: BoxDecoration(color: Colors.black),
                      ));
                })),
      ],
    );
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

extension AnimationUtils on AnimationController {
  void yomAnimateTo(double target, {Duration duration = Duration.zero}) {
    this.animateTo(target, curve: Curves.easeOutQuart, duration: duration);
  }
}
