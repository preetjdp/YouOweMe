import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class BackgroundAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Color.fromRGBO(121, 151, 207, 1),
                Color.fromRGBO(120, 123, 206, 1)
              ])),
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PlayAnimation<double>(
                tween: 0.0.tweenTo(350.0),
                duration: Duration(milliseconds: 500),
                delay: Duration(milliseconds: 700),
                curve: Curves.easeOutQuart,
                builder: (context, child, value) {
                  return ClipPath(
                      clipper: TopCustomClipper(),
                      child: Container(
                        height: value,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                              Color.fromRGBO(163, 226, 168, 1),
                              Color.fromRGBO(160, 225, 198, 1)
                            ])),
                      ));
                })),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: PlayAnimation<double>(
                tween: 0.0.tweenTo(300.0),
                duration: Duration(milliseconds: 500),
                delay: Duration(milliseconds: 700),
                curve: Curves.easeOutQuart,
                builder: (context, child, value) {
                  return ClipPath(
                      clipper: BottomCustomClipper(),
                      child: Container(
                        height: value,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor),
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
    return true;
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
    return true;
  }
}
