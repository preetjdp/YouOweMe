// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:basics/basics.dart';

// 🌎 Project imports:
import 'package:YouOweMe/main.dart';
import 'package:YouOweMe/ui/IntroFlow/authFlow/authFlow.dart';
import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';
import 'package:YouOweMe/ui/IntroFlow/permissionsFlow/permissionsFlow.dart';

class IntroFlow extends StatefulWidget {
  @override
  _IntroFlowState createState() => _IntroFlowState();
}

class _IntroFlowState extends State<IntroFlow> {
  final PageController pageController = PageController(initialPage: 0);
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final LoginUser loginUser = new LoginUser();
  final BehaviorSubject<bool> authStateSubject = BehaviorSubject.seeded(true);

  @override
  void initState() {
    pageController.addListener(() {
      print("Listening" + pageController.page.toString());
      if (pageController.page == 5.0) {
        authStateSubject.add(true);
      } else {
        authStateSubject.add(false);
      }
    });
    super.initState();
  }

  bool combineStreamFunc(FirebaseUser firebaseUser, bool truth) {
    print(truth);
    print(firebaseUser);
    if (firebaseUser != null && truth) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: CombineLatestStream.combine2<FirebaseUser, bool, bool>(
            FirebaseAuth.instance.onAuthStateChanged,
            authStateSubject,
            (firebaseUser, truth) => combineStreamFunc(firebaseUser, truth)),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data.isNull) return IntroFlowEmptyState();
          if (snapshot.data)
            return Intermediate();
          else
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
                    NotificationsPermissions(),
                    ContactsPermissions(),
                    Container()
                  ],
                ),
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
