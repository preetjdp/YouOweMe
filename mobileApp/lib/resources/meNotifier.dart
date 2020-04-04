import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class MeNotifier extends ChangeNotifier {
  static HttpLink httpLink = HttpLink(
      uri: 'https://youoweme-6c622.appspot.com/',
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

  void refresh() => getData();

  Future<void> getData() async {
    print("Getting Data");
    QueryResult result = await graphQLClient.query(QueryOptions(
      documentNode: SevaQuery().document,
    ));

    Seva$Query mappedData = Seva$Query.fromJson(result.data);
    print(mappedData.Me.name);
    me = mappedData.Me;
    notifyListeners();
  }
}
