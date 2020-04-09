import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/HomePage/iOweSection.dart';
import 'package:YouOweMe/ui/HomePage/oweMeSection.dart';
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

    final Widget abstractedNewOweButton = platform == TargetPlatform.iOS
        ? CupertinoButton(
            color: Theme.of(context).accentColor,
            child: Text('New'),
            onPressed: goToNewOwe)
        : FloatingActionButton.extended(
            label: Text('New'),
            icon: Icon(Icons.add),
            onPressed: goToNewOwe,
          );

    return Scaffold(
        floatingActionButton: abstractedNewOweButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: abstractedHomePage);
  }
}
