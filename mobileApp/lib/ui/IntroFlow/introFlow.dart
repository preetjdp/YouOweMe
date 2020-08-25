// 🐦 Flutter imports:
import 'package:YouOweMe/ui/IntroFlow/firstPage/firstPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:basics/basics.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/IntroFlow/providers.dart';
import 'package:YouOweMe/main.dart';
import 'package:YouOweMe/ui/IntroFlow/authFlow/authFlow.dart';
import 'package:YouOweMe/ui/IntroFlow/permissionsFlow/permissionsFlow.dart';

class IntroFlow extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final PageController _pageController =
        useProvider(introFlowPageControllerProvider);
    return useProvider(authValidatorProvider).when(
        loading: () => IntroFlowEmptyState(),
        error: (_, __) => IntroFlowEmptyState(),
        data: (bool snapshot) {
          if (snapshot.isNull) return IntroFlowEmptyState();
          if (snapshot)
            return Intermediate();
          else
            return Scaffold(
              body: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  FirstPage(),
                  NamePage(),
                  MobilePage(),
                  OtpPage(),
                  NotificationsPermissions(),
                  // ContactsPermissions(),
                  Container()
                ],
              ),
            );
        });
  }
}

class IntroFlowEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Loading")),
    );
  }
}
