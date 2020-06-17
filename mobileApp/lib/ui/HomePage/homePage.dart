// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:after_layout/after_layout.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:retry/retry.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/helpers.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/ui/HomePage/iOweSection.dart';
import 'package:YouOweMe/ui/HomePage/oweMeSection.dart';
import 'package:YouOweMe/resources/extensions.dart';
import 'package:YouOweMe/ui/NewOwe/newOwe.dart';
import 'package:YouOweMe/ui/HomePage/bottomList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage> {
  @override
  void afterFirstLayout(BuildContext context) async {
    final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();
    await firebaseAnalytics.logAppOpen();
    String token = await configureFirebaseMessenging(context);
    if (token != null) {
      await retry(
          () => Provider.of<MeNotifier>(context, listen: false)
              .updateUser({"fcmToken": token}),
          retryIf: (e) => e is Exception,
          delayFactor: Duration(seconds: 5),
          onRetry: (a) => print("Retrying to update FCM with " + a.toString()));
    }
    configureFirebaseDynamicLinks(context);
  }

  void logOutDialog(BuildContext context) async {
    bool result = await showCupertinoModalPopup<bool>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text("Logout"),
            message: Text(
                """This action will log you out of the app. I hope you come back again soon, now so that you're here we'll talk a bit a bit bit by bit through the bitly world which runs bit by bit."""),
            cancelButton: CupertinoActionSheetAction(
              child: Text("Cancel"),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  "Log me out already. 😪",
                  style: TextStyle(color: CupertinoColors.activeGreen),
                ),
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Toggle Device Preview",
                ),
                onPressed: () {
                  toggleDevicePreview();
                },
              ),
            ],
          );
        });
    if (result != null && result) {
      FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    void goToNewOwe() async {
      Navigator.of(context).pushNamed('new_owe_page');
    }

    Future<void> onRefresh() =>
        Provider.of<MeNotifier>(context, listen: false).refresh();

    List<Widget> children = AnimationConfiguration.toStaggeredList(
        childAnimationBuilder: (widget) => ScaleAnimation(
              scale: 1.5,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          OweMeSection(),
          SizedBox(
            height: 10,
          ),
          IOweSection(),
          BottomList(),
        ]);

    final Widget abstractedHomePage = CustomScrollView(
      slivers: <Widget>[
        if (platform == TargetPlatform.iOS) ...[
          CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
          ),
          SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              sliver: SliverList(delegate: SliverChildListDelegate(children)))
        ] else if (platform == TargetPlatform.android)
          SliverFillRemaining(
            child: RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView(
                  padding: EdgeInsets.all(15),
                  children: children,
                )),
          )
      ],
    );

    final Widget abstractedNewOweButton = platform == TargetPlatform.android
        ? FloatingActionButton.extended(
            label: Text('New'),
            icon: Icon(Icons.add),
            onPressed: goToNewOwe,
          )
        : CupertinoButton(
            color: Theme.of(context).accentColor,
            child: Text('New'),
            onPressed: goToNewOwe);
    // : Container();

    final Widget bottomBar = platform == TargetPlatform.iOS
        ? ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: Colors.white.withOpacity(0),
                child: CupertinoButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.add_circled),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add New Owe",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : null;

    return Scaffold(
      floatingActionButton: abstractedNewOweButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          AnimationLimiter(child: abstractedHomePage),
          Positioned(
            bottom: 20,
            left: 15,
            child: YomAvatar(
              text: Provider.of<MeNotifier>(context)?.me?.shortName ?? "PP",
              onPressed: () => logOutDialog(context),
            ),
          )
        ],
      ),
      // bottomNavigationBar: bottomBar
    );
  }
}
