import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:YouOweMe/resources/extensions.dart';
import 'package:basics/basics.dart';

class BottomList extends StatelessWidget {
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
      MeNotifier meNotifier = Provider.of<MeNotifier>(context, listen: false);
      String updateOweMutation = """
      mutation(\$input: UpdateOweInputType!) {
        updateOwe(data: \$input) {
          id
          title
        }
      }
      """;
      QueryResult result = await meNotifier.graphQLClient.mutate(
          MutationOptions(documentNode: gql(updateOweMutation), variables: {
        "input": {"id": owe.id, "state": "PAID"}
      }));
      if (result.isNotNull && result.exception.isNull) meNotifier.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Seva$Query$User me = Provider.of<MeNotifier>(context).me;
    if (me.isNull || me.oweMe.isEmpty) return BottomListEmptyState();
    final List<Seva$Query$User$Owe> oweMe = Provider.of<MeNotifier>(context)
        .me
        .oweMe
        .fromStates([OweState.CREATED, OweState.ACKNOWLEDGED]);
    return ListView.builder(
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
                    style: Theme.of(context).textTheme.headline5,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CupertinoButton(
                  onPressed: () => onTick(owe, context),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: Icon(
                    CupertinoIcons.check_mark_circled,
                    size: 28,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(minWidth: 65),
                  child: CupertinoButton(
                      color: Theme.of(context).accentColor,
                      minSize: 20,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        owe.amount.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () {}),
                )
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
        child: Image.asset(
          "assets/scribbles/scribble1.png", //Really Good
          fit: BoxFit.contain,
        ));
  }
}
