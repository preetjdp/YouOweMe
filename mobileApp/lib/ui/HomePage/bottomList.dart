import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomList extends StatelessWidget {
  void onTick(Seva$Query$User$Owe owe, BuildContext context) async {
    bool shouldDelete = false;
    Widget actionSheet = CupertinoActionSheet(
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
        context: context, builder: (BuildContext context) => actionSheet);
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
    final Seva$Query$User me = Provider.of<MeNotifier>(context).me;
    if (me == null || me.oweMe.length == 0) return BottomListEmptyState();
    return ListView.builder(
        itemCount: Provider.of<MeNotifier>(context).me.oweMe.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Seva$Query$User$Owe owe =
              Provider.of<MeNotifier>(context).me.oweMe[index];
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
                  onPressed: () => onTick(owe, context),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
        });
  }
}

class BottomListEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 40),
        child: Image.network(
          // "https://assets-ouch.icons8.com/preview/270/0ae49765-f2ae-43b6-968d-4049849ada54.png", //Not the best
          // "https://assets-ouch.icons8.com/preview/810/4f4739ae-57b1-4b0a-bbec-36a332cdeb9f.png", //Really Good,
          "https://assets-ouch.icons8.com/preview/440/0065cca5-6a42-4c31-bee3-59a0eb98442c.png", //Really Good
          // height: 400,
          // width: 400,
          fit: BoxFit.contain,
        ));
  }
}
