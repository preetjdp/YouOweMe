import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/ui/NewOwe/newOwe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IOwePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Seva$Query$User$Owe> iOwe =
        Provider.of<MeNotifier>(context).me.iOwe;
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.5),
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).accentColor, width: 0.5)),
          middle: Text("I Owe",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: Colors.black)),
          actionsForegroundColor: Theme.of(context).accentColor,
        ),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: iOwe.isNotEmpty
                ? ListView.builder(
                    itemCount: iOwe.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      Seva$Query$User$Owe owe = iOwe[index];
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 50,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            YomAvatar(
                              text: "PP",
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              owe.title,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            CupertinoButton(
                              onPressed: () {},
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                              child: Icon(
                                CupertinoIcons.check_mark_circled,
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
                : IOwePageEmptyState()));
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
