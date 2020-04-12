import 'package:YouOweMe/ui/IntroFlow/authFlow/authFlow.dart';
import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';
import 'package:YouOweMe/ui/IntroFlow/permissionsFlow/permissionsFlow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroFlow extends StatefulWidget {
  @override
  _IntroFlowState createState() => _IntroFlowState();
}

class _IntroFlowState extends State<IntroFlow> {
  final PageController pageController = PageController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final LoginUser loginUser = new LoginUser();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: pageController),
        Provider.value(value: loginUser)
      ],
      child: Scaffold(
        body: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            NamePage(),
            MobilePage(),
            OtpPage(),
            NotificationsPermissions()
          ],
        ),
      ),
    );
  }
}
