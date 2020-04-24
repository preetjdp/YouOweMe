import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/ui/NewOwe/newOwe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:YouOweMe/resources/extensions.dart';

class OweMePage extends StatelessWidget {
  void onTick(Seva$Query$User$Owe owe, BuildContext context) async {
    bool shouldDelete = false;
    Widget actionSheet(BuildContext context) => CupertinoActionSheet(
          message: Text("This action will mark the `owe` as paid."),
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
                "Paid",
                style: TextStyle(color: CupertinoColors.activeGreen),
              ),
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
    shouldDelete = await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => actionSheet(context));
    if (shouldDelete) {
      DocumentReference oweRef = Firestore.instance
          .collection("users")
          .document(owe.issuedBy.id)
          .collection("owes")
          .document(owe.id);
      oweRef.delete();
      Provider.of<MeNotifier>(context, listen: false).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Seva$Query$User$Owe> oweMe =
        Provider.of<MeNotifier>(context).me.oweMe;
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.5),
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).accentColor, width: 0.5)),
          middle: Text("Owe Me",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: Colors.black)),
          actionsForegroundColor: Theme.of(context).accentColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: oweMe.isNotEmpty
              ? ListView.builder(
                  itemCount: oweMe.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Seva$Query$User$Owe owe = oweMe[index];
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      constraints: BoxConstraints(minHeight: 50),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          YomAvatar(
                            text: owe.issuedTo.shortName,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              owe.title,
                              style: Theme.of(context).textTheme.headline3,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () => onTick(owe, context),
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
              : OweMePageEmptyState(),
        ));
  }
}

class OweMePageEmptyState extends StatelessWidget {
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
        Image.asset("assets/scribbles/scribble5.png"),
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
