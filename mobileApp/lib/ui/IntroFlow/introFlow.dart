import 'package:YouOweMe/ui/IntroFlow/AuthFlow/authFlow.dart';
import 'package:YouOweMe/ui/IntroFlow/permissionsFlow/permissionsFlow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroFlow extends StatelessWidget {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: pageController,
      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: [NamePage(), MobilePage(), NotificationsPermissions()],
        ),
      ),
    );
  }
}
