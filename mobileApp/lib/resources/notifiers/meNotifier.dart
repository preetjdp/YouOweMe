import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MeNotifier extends ChangeNotifier {
  static HttpLink httpLink = HttpLink(
      uri: 'http://192.168.31.76:4000/',
      headers: {"authorization": "f9fc7B6wvIsU62LuDNVv"});
  final GraphQLClient graphQLClient = GraphQLClient(
    cache: InMemoryCache(),
    link: httpLink,
  );
  Seva$Query$Me me;
  bool isLoading;

  MeNotifier(BuildContext context) {
    print("Construcing");
    isLoading = true;
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
