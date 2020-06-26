import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vector_math/vector_math.dart';
import 'package:basics/basics.dart';

/// extent = 1
/// duration = Duration(milliseconds: 80)
///
/// extent = 1.5
/// Duration(milliseconds: 100)

class JiggleMode extends StatefulWidget {
  final double extent;
  final Duration duration;
  final Widget child;
  final JiggleController jiggleController;
  JiggleMode(
      {@required this.child,
      @required this.jiggleController,
      this.extent = 1,
      this.duration = const Duration(milliseconds: 80)});
  @override
  _JiggleModeState createState() => _JiggleModeState();
}

class _JiggleModeState extends State<JiggleMode>
    with SingleTickerProviderStateMixin {
  AnimationController _jiggleAnimationController;
  Animation<double> jiggleAnimation;

  @override
  void initState() {
    _jiggleAnimationController = AnimationController(
        vsync: this,
        duration: widget.duration,
        value: 0,
        lowerBound: -1,
        upperBound: 1);

    jiggleAnimation = Tween<double>(begin: 0, end: widget.extent)
        .animate(_jiggleAnimationController);

    _jiggleAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _jiggleAnimationController.repeat(reverse: true);
      }
    });
    super.initState();
  }

  void listenForJiggles() {
    widget.jiggleController.stream.listen((event) {
      // print("From Listen" + event.toString());
      if (event == JiggleState.STATIC) {
        _jiggleAnimationController.animateTo(1, duration: Duration.zero);
        _jiggleAnimationController.stop();
      } else if (event == JiggleState.JIGGLING) {
        _jiggleAnimationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    listenForJiggles();
    return AnimatedBuilder(
        animation: jiggleAnimation,
        child: widget.child,
        builder: (BuildContext context, Widget child) {
          // print("RAD" + radians(jiggleAnimation.value).toString());
          return Transform.rotate(
            angle: radians(jiggleAnimation.value),
            child: child,
          );
        });
  }
}

enum JiggleState { JIGGLING, STATIC }

class JiggleController {
  BehaviorSubject<JiggleState> _jiggleSubject =
      BehaviorSubject.seeded(JiggleState.STATIC);

  Stream<JiggleState> get stream => _jiggleSubject.stream.asBroadcastStream();

  JiggleController() {
    stream.listen((event) {
      print("Constructor " + event.toString());
    });
  }

  void toggle() {
    HapticFeedback.mediumImpact();
    if (_jiggleSubject.value == JiggleState.STATIC) {
      _jiggleSubject.value = JiggleState.JIGGLING;
    } else {
      _jiggleSubject.value = JiggleState.STATIC;
    }
  }

  void dispose() {
    _jiggleSubject.close();
  }
}
