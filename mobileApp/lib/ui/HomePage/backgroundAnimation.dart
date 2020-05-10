import 'package:flutter/material.dart';

class BackgroundAnimation extends StatefulWidget {
  @override
  _BackgroundAnimationState createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> toptween;
  Animation<double> bottomtween;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // ..addStatusListener((status) {
    //   if(status == AnimationStatus .completed) {
    //     _controller.reverse();
    //   } else if( status == AnimationStatus.dismissed) {
    //     _controller.forward();
    //   }
    //  });
    // toptween = Tween(begin: 0.0, end: 350.0).animate(
    //     CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    // bottomtween = Tween(begin: 00.0, end: 300.0).animate(
    //     CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    toptween = Tween(begin: 0.0, end: 350.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));
    bottomtween = Tween(begin: 00.0, end: 300.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));
    Future.delayed(Duration(milliseconds: 500), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
                  colors: [
                Color.fromRGBO(121, 151, 207, 1),
                Color.fromRGBO(120, 123, 206, 1)
              ])),
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
                animation: toptween,
                builder: (context, snapshot) {
                  return ClipPath(
                      clipper: TopCustomClipper(),
                      child: Container(
                        height: toptween.value,
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
            child: AnimatedBuilder(
                animation: bottomtween,
                builder: (context, snapshot) {
                  return ClipPath(
                      clipper: BottomCustomClipper(),
                      child: Container(
                        height: bottomtween.value,
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
