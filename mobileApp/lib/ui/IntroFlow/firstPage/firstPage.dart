import 'package:YouOweMe/ui/Abstractions/yomButton.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpacer.dart';
import 'package:YouOweMe/ui/IntroFlow/firstPage/foregroundAnimation.dart';
import 'package:YouOweMe/ui/IntroFlow/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirstPage extends HookWidget {
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
        // Positioned(
        //   left: 15,
        //   top: 30,
        //   child: Text(
        //     "YouOweMe",
        //     style: Theme.of(context)
        //         .textTheme
        //         .headline3
        //         .copyWith(color: Colors.black),
        //   ),
        // ),
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
