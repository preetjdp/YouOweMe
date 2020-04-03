import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:flutter/widgets.dart';

import 'package:YouOweMe/resources/models/owe.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DatabaseService {
  Stream<Seva$Query> streamMe(BuildContext context) {
    final HttpLink httpLink = HttpLink(
        uri: 'https://youoweme-6c622.appspot.com/',
        headers: {"authorization": "f9fc7B6wvIsU62LuDNVv"});
    GraphQLClient graphQLClient = GraphQLClient(
      link: httpLink,
      cache: InMemoryCache(),
    );

    Stream<FetchResult> results = graphQLClient.subscribe(Operation(
      documentNode: SevaQuery().document,
    ));

    return results.map((result) {
      Seva$Query user = Seva$Query.fromJson(result.data);
      return user;
    });
  }
}
