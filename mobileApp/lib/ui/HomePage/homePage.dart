import 'dart:ui';

import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/ui/HomePage/iOweSection.dart';
import 'package:YouOweMe/ui/HomePage/oweMeSection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:YouOweMe/ui/NewOwe/newOwe.dart';
import 'package:YouOweMe/ui/HomePage/bottomList.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    void goToNewOwe() async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => NewOwe()));
    }

    Future<void> onRefresh() =>
        Provider.of<MeNotifier>(context, listen: false).refresh();

    List<Widget> children = <Widget>[
      SizedBox(
        height: 10,
      ),
      OweMeSection(),
      SizedBox(
        height: 10,
      ),
      IOweSection(),
      BottomList(),
    ];

    final Widget abstractedHomePage = CustomScrollView(
      slivers: <Widget>[
        if (platform == TargetPlatform.iOS) ...[
          CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
          ),
          SliverPadding(
              padding: EdgeInsets.all(15),
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
          abstractedHomePage,
          Positioned(
            bottom: 20,
            left: 15,
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: YomAvatar(
                  text: 'PP',
                ),
            ),
          )
        ],
      ),
      // bottomNavigationBar: bottomBar
    );
  }
}
