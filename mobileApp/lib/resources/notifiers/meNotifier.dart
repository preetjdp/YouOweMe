import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MeNotifier extends ChangeNotifier {
  GraphQLClient graphQLClient;

  Seva$Query$User me;
  bool isLoading;

  MeNotifier(BuildContext context) {
    print("Construcing");
    isLoading = true;
    init();
  }

  void onProxyUpdate(FirebaseUser firebaseUser) {
    print("NOn Proxy Update");
    graphQLClient = GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(
          uri: 'https://api.youoweme.preetjdp.dev/',
          headers: {"authorization": firebaseUser.uid}),
    );
    init();
  }

  void init() {
    getData().then((value) {
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> refresh() async {
    await getData();
  }

  Future<void> getData() async {
    print("Getting Data");
    QueryResult result = await graphQLClient.query(QueryOptions(
        documentNode: SevaQuery().document,
        fetchPolicy: FetchPolicy.cacheAndNetwork));

    Seva$Query mappedData = Seva$Query.fromJson(result.data);
    me = mappedData.Me;
    notifyListeners();
  }
}
