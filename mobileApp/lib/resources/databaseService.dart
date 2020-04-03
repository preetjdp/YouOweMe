import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:flutter/widgets.dart';

import 'package:YouOweMe/resources/models/owe.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DatabaseService {
  Stream<Seva$Query> streamMe(BuildContext context) {
    final HttpLink httpLink = HttpLink(
        uri: 'https://youoweme-6c622.appspot.com/',
        headers: {"authorization": "f9fc7B6wvIsU62LuDNVv"});

    final webSocketLink = WebSocketLink(
        url: "ws://youoweme-6c622.appspot.com/graphql",
        config: SocketClientConfig(
            initPayload: {"authorization": "f9fc7B6wvIsU62LuDNVv"},
            autoReconnect: true,
            inactivityTimeout: Duration(minutes: 1),
            delayBetweenReconnectionAttempts: Duration(seconds: 10)));

    httpLink.concat(webSocketLink);

    GraphQLClient graphQLClient = GraphQLClient(
      link: webSocketLink,
      cache: InMemoryCache(),
    );

    Stream<FetchResult> results = graphQLClient.subscribe(Operation(
      documentNode: SevaQuery().document,
    ));

    return results.map((result) {
      Seva$Query user = Seva$Query.fromJson(result.data);
      print(user.Me.name);
      return user;
    });
  }
}
