import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/ui/IOwe/iOwePageBottomSheet.dart';
import 'package:YouOweMe/ui/NewOwe/newOwe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:YouOweMe/resources/extensions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class IOwePage extends StatelessWidget {
  final PanelController panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    final List<Seva$Query$User$Owe> iOwe = Provider.of<MeNotifier>(context)
        .me
        .iOwe
        .fromStates([OweState.CREATED, OweState.ACKNOWLEDGED]);

    Future<bool> onWilPopScope() async {
      if (panelController.isAttached && panelController.isPanelOpen) {
        await panelController.close();
        return false;
      }
      return true;
    }

    return WillPopScope(
      onWillPop: onWilPopScope,
      child: Scaffold(
          appBar: CupertinoNavigationBar(
            backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.5),
            border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).accentColor, width: 0.5)),
            middle: Text("I Owe",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: Colors.black)),
            actionsForegroundColor: Theme.of(context).accentColor,
          ),
          body: SafeArea(
            child: SlidingUpPanel(
              minHeight: 0,
              parallaxEnabled: true,
              panelSnapping: false,
              padding: EdgeInsets.all(15),
              controller: panelController,
              backdropTapClosesPanel: true,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              panelBuilder: (ScrollController sc) => IOwePageBottomSheet(
                scrollController: sc,
              ),
              body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: iOwe.isNotEmpty
                      ? ListView.builder(
                          itemCount: iOwe.length,
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            Seva$Query$User$Owe owe = iOwe[index];
                            return Container(
                              margin: EdgeInsets.only(top: 10),
                              constraints: BoxConstraints(minHeight: 50),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  YomAvatar(
                                    text: owe.issuedBy.shortName,
                                    onPressed: () {
                                      panelController.open();
                                    },
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      owe.title,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  CupertinoButton(
                                    onPressed: () {},
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    child: Icon(
                                      CupertinoIcons.check_mark_circled_solid,
                                      size: 28,
                                    ),
                                  ),
                                  CupertinoButton(
                                      color: Theme.of(context).accentColor,
                                      minSize: 20,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        owe.amount.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            .copyWith(color: Colors.white),
                                      ),
                                      onPressed: () {})
                                ],
                              ),
                            );
                          })
                      : IOwePageEmptyState()),
            ),
          )),
    );
  }
}

class IOwePageEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void goToNewOwe() async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => NewOwe()));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Container()),
        Image.asset("assets/scribbles/scribble2.png"),
        Expanded(child: Container()),
        SizedBox(
          height: 10,
        ),
        Text(
          "Oh oo ...\nThere seem to be no Owes here. 😯",
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          child: CupertinoButton(
              color: Theme.of(context).accentColor,
              child: Text('Add an New Owe'),
              onPressed: goToNewOwe),
        )
      ],
    );
  }
}
