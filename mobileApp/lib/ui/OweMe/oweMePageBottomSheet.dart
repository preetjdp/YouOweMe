// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomButton.dart';
import 'package:YouOweMe/resources/extensions.dart';

class OweMePageBottomSheet extends StatelessWidget {
  final Seva$Query$User$Owe owe;
  final ScrollController scrollController;
  final YomButtonController yomButtonController = YomButtonController();
  final YomButtonController deleteButtonController = YomButtonController();
  OweMePageBottomSheet({@required this.scrollController, @required this.owe});
  @override
  Widget build(BuildContext context) {
    void markAsPaid() async {
      try {
        yomButtonController.showLoading();
        MeNotifier meNotifier = context.read<MeNotifier>();
        String query = """
        mutation(\$input: UpdateOweInputType!) {
          updateOwe(data: \$input) {
            id
          }
        }
      """;
        await meNotifier.graphQLClient.mutate(MutationOptions(
            documentNode: gql(query),
            variables: {
              "input": {"id": owe.id, "state": "PAID"}
            },
            onError: (e) => throw (e)));
        await meNotifier.refresh();
        yomButtonController.showSuccess();
        await Future.delayed(Duration(milliseconds: 200));
        Navigator.of(context).pop();
      } catch (e) {
        yomButtonController.showError();
      }
    }

    void deleteOwe() async {
      try {
        deleteButtonController.showLoading();
        MeNotifier meNotifier = context.read<MeNotifier>();
        String query = """
        mutation(\$input: DeleteOweInputType!) {
          deleteOwe(data: \$input) 
        }
      """;
        await meNotifier.graphQLClient.mutate(MutationOptions(
            documentNode: gql(query),
            variables: {
              "input": {"id": owe.id}
            },
            onError: (e) => throw (e)));
        await meNotifier.refresh();
        deleteButtonController.showSuccess();
        await Future.delayed(Duration(milliseconds: 200));
        Navigator.of(context).pop();
      } catch (e) {
        deleteButtonController.showError();
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: Material(
        child: Padding(
          padding: EdgeInsets.all(15).copyWith(bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title", style: Theme.of(context).textTheme.headline5),
              Text(owe.title, style: Theme.of(context).textTheme.bodyText2),
              SizedBox(
                height: 20,
              ),
              if ([OweState.ACKNOWLEDGED, OweState.CREATED].contains(owe.state))
                Text("Amount To Be Recieved",
                    style: Theme.of(context).textTheme.headline5)
              else if (owe.state == OweState.PAID)
                Text("Amount Recieved",
                    style: Theme.of(context).textTheme.headline5),
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.headline1,
                    children: [
                      TextSpan(
                          text: "₹",
                          style:
                              TextStyle(color: Theme.of(context).accentColor)),
                      TextSpan(text: owe.amount.toInt().toString())
                    ]),
              ),
              Text("Wait When was this Again?",
                  style: Theme.of(context).textTheme.headline5),
              Text(owe.created.simpler,
                  style: Theme.of(context).textTheme.bodyText2),
              if ([OweState.ACKNOWLEDGED, OweState.CREATED]
                  .contains(owe.state)) ...[
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 400,
                  child: CupertinoButton(
                      color: Theme.of(context).accentColor,
                      child: Text('Ping Him Up!'),
                      onPressed: () {}),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  width: 400,
                  child: YomButton(
                      controller: yomButtonController,
                      backgroundColor: CupertinoColors.activeGreen,
                      child: Text('Mark As Paid'),
                      onPressed: markAsPaid),
                ),
              ],
              SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                child: YomButton(
                  onPressed: deleteOwe,
                  controller: deleteButtonController,
                  child:
                      Text("Delete This Owe  👹", textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
