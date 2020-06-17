// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/graphql/queries/getOwe/getOwe.dart';
import 'package:YouOweMe/resources/graphql/seva.dart' as seva;
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomBottomSheet.dart';
import 'package:YouOweMe/ui/Abstractions/yomButton.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/resources/extensions.dart';

class DynamicLinkBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final String oweId;

  DynamicLinkBottomSheet({@required this.oweId, this.scrollController});

  @override
  _DynamicLinkBottomSheetState createState() => _DynamicLinkBottomSheetState();
}

class _DynamicLinkBottomSheetState extends State<DynamicLinkBottomSheet> {
  final AsyncMemoizer<QueryResult> _getOweQueryMemoizer = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    GraphQLClient graphQLClient = context.watch<MeNotifier>().graphQLClient;
    GetOweQuery getOweQuery =
        GetOweQuery(variables: GetOweArguments(input: widget.oweId));

    QueryOptions queryOptions = QueryOptions(
        documentNode: getOweQuery.document,
        variables: getOweQuery.getVariablesMap());

    Future<QueryResult> _getOwe =
        _getOweQueryMemoizer.runOnce(() => graphQLClient.query(queryOptions));

    return FutureBuilder<QueryResult>(
        future: _getOwe,
        builder: (BuildContext context, AsyncSnapshot<QueryResult> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(height: 120, child: Center(child: YOMSpinner()));
          }
          if (snapshot.data.hasException || snapshot.hasError) {
            return DynamicLinkBottomSheetErrorState();
          }
          GetOwe$Query getOweResult = GetOwe$Query.fromJson(snapshot.data.data);
          return DynamicLinkBottomSheetContent(getOweResult.getOwe);
        });
  }
}

class DynamicLinkBottomSheetContent extends StatelessWidget {
  final GetOwe$Query$Owe owe;
  DynamicLinkBottomSheetContent(this.owe);
  @override
  Widget build(BuildContext context) {
    seva.Seva$Query$User me = context.watch<MeNotifier>().me;
    return Padding(
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
            Text("Amount To Be Paid",
                style: Theme.of(context).textTheme.headline5)
          else if (owe.state == OweState.PAID)
            Text("Amount Paid", style: Theme.of(context).textTheme.headline5),
          RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.headline1,
                children: [
                  TextSpan(
                      text: "₹",
                      style: TextStyle(color: Theme.of(context).accentColor)),
                  TextSpan(text: owe.amount.toInt().toString())
                ]),
          ),
          Text("Wait When was this Again?",
              style: Theme.of(context).textTheme.headline5),
          Text(owe.created.simpler,
              style: Theme.of(context).textTheme.bodyText2),
          if (owe.issuedTo.id == me.id &&
              [OweState.ACKNOWLEDGED, OweState.CREATED]
                  .contains(owe.state)) ...[
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: 400,
              child: CupertinoButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Pay Up!'),
                  onPressed: () {
                    showYomBottomSheet(
                        context: context,
                        builder: (a, b) => Center(child: YOMSpinner()));
                  }),
            ),
          ] else if (owe.issuedBy.id == me.id) ...[
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
                    backgroundColor: CupertinoColors.activeGreen,
                    child: Text('Mark As Paid'),
                    onPressed: () {}),
              ),
            ],
            SizedBox(
              height: 10,
            ),
            YomButton(
              onPressed: () {},
              child: Text("Delete This Owe  👹", textAlign: TextAlign.center),
            ),
          ]
        ],
      ),
    );
  }
}

class DynamicLinkBottomSheetErrorState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15).copyWith(bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/scribbles/karlsson_searching.png"),
          SizedBox(
            height: 20,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: "Couldn't find that owe.",
                style: Theme.of(context).textTheme.headline4,
              ),
              TextSpan(text: "\n"),
              TextSpan(
                text: '"It must have gotten lost during shipping."',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontStyle: FontStyle.italic),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
