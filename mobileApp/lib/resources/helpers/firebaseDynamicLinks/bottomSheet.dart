import 'package:YouOweMe/resources/graphql/queries/getOwe/getOwe.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:basics/basics.dart';
import 'package:async/async.dart';

class FirebaseDynamicLinkBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final String oweId;

  FirebaseDynamicLinkBottomSheet(
      {@required this.scrollController, @required this.oweId});

  @override
  _FirebaseDynamicLinkBottomSheetState createState() =>
      _FirebaseDynamicLinkBottomSheetState();
}

class _FirebaseDynamicLinkBottomSheetState
    extends State<FirebaseDynamicLinkBottomSheet> {
  final AsyncMemoizer<QueryResult> _queryResultMemoizer = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    GraphQLClient graphQLClient = context.watch<MeNotifier>().graphQLClient;
    GetOweQuery getOweQuery =
        GetOweQuery(variables: GetOweArguments(input: widget.oweId));
    QueryOptions queryOptions = QueryOptions(
        documentNode: getOweQuery.document,
        variables: getOweQuery.getVariablesMap());
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: Material(
        child: Container(
            height: 400,
            child: FutureBuilder<QueryResult>(
                future: _queryResultMemoizer
                    .runOnce(() => graphQLClient.query(queryOptions)),
                builder: (BuildContext context,
                    AsyncSnapshot<QueryResult> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: YOMSpinner());
                  }
                  GetOwe$Query getOweResult =
                      GetOwe$Query.fromJson(snapshot.data.data);
                  return BottomSheetContent(getOweResult.getOwe);
                })),
      ),
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  final GetOwe$Query$Owe owe;
  BottomSheetContent(this.owe);
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(owe.title));
  }
}
