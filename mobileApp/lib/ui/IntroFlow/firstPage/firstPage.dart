import 'package:YouOweMe/ui/Abstractions/yomButton.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpacer.dart';
import 'package:YouOweMe/ui/IntroFlow/firstPage/foregroundAnimation.dart';
import 'package:YouOweMe/ui/IntroFlow/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'dart:math' as math;

class FirstPage extends HookWidget {
  final List<String> messages = [
    "Bro Pay Me Up?",
    "Hey when did you take ${math.Random().nextInt(400)}",
    "Hey we gotta split the bill for the coffe",
    "When are you gonna pay me back?"
  ];
  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        useProvider(introFlowPageControllerProvider);
    void signUp() {
      pageController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOutQuad);
    }

    void signIn() {
      pageController.animateToPage(2,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOutQuad);
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          bottom: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Marquee(
              text: messages.reduce((value, element) => value + ". " + element),
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              scrollAxis: Axis.vertical,
              fadingEdgeEndFraction: 1,
              showFadingOnlyWhenScrolling: true,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  height: 60,
                  width: 400,
                  child: YomButton(child: Text("Sign Up"), onPressed: signUp)),
              YomSpacer(
                height: 10,
              ),
              Container(
                  height: 60,
                  width: 400,
                  child: YomButton(
                      child: Text(
                        "Log In",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: signIn,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 2))))
            ],
          ),
        ),
        Image.asset("assets/scribbles/karlsson_lending.png"),
        ForegroundAnimation()
      ],
    );
  }
}
