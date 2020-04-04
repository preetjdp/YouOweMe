import 'package:YouOweMe/resources/meNotifier.dart';
import 'package:YouOweMe/ui/HomePage/blurredBottom.dart';
import 'package:YouOweMe/ui/HomePage/iOweSection.dart';
import 'package:YouOweMe/ui/HomePage/oweMeSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:YouOweMe/ui/NewOwe/newOwe.dart';
import 'package:YouOweMe/ui/HomePage/bottomList.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TargetPlatform platform = Theme.of(context).platform;
    void goToNewOwe() async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => NewOwe()));
    }

    Future<void> onRefresh() =>
        Provider.of<MeNotifier>(context, listen: false).refresh();

    List<Widget> children = <Widget>[
      OweMeSection(),
      SizedBox(
        height: 30,
      ),
      IOweSection(),
      SizedBox(
        height: 30,
      ),
      BottomList(),
      SizedBox(
        height: 10,
      ),
    ];

    Widget homePageContent = CustomScrollView(
      slivers: <Widget>[
        if (platform == TargetPlatform.iOS)
          CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
          ),
        if (platform == TargetPlatform.iOS)
          SliverFillRemaining(
            child: Padding(
                padding: EdgeInsets.all(15), child: Column(children: children)),
          )
        else if (platform == TargetPlatform.android)
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

    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Text('New'),
          icon: Icon(Icons.add),
          onPressed: goToNewOwe,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: homePageContent);
  }
}
