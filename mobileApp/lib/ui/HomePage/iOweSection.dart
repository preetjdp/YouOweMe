import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class IOweSection extends StatelessWidget {
  final iOweAmountQuery = '''
    {
      Me {
        iOweAmount
      }
    }
  ''';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
              left: 0,
              top: 0,
              child: Row(
                children: <Widget>[
                  Text(
                    "I Owe",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(78, 80, 88, 1)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Color.fromRGBO(78, 80, 88, 1),
                  )
                ],
              )),
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Color.fromRGBO(78, 80, 88, 0.05),
                        spreadRadius: 0.1)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Query(
                    options: QueryOptions(documentNode: gql(iOweAmountQuery)),
                    builder: (QueryResult result,
                        {VoidCallback refetch, FetchMore fetchMore}) {
                      if (result.loading) {
                        return Text('loading');
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("₹${result.data["Me"]["iOweAmount"]}",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).accentColor))
                        ],
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
