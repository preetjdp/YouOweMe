import 'package:YouOweMe/ui/NewOwe/contactSelector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:YouOweMe/ui/NewOwe/peopleList.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class NewOwe extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    TargetPlatform platform = Theme.of(context).platform;
    void addNewOwe() {
      final newOweMutation = '''
        mutation {
          newOwe(data: {
            title: "${titleController.text}",
            amount: ${int.parse(amountController.text)},
            issuedToID: "Ei66LhElIZ3eEQeqGBIp"
          }) {
            id
            issuedBy {
              name
            }
          }
        }
      ''';
      GraphQLProvider.of(context).value.mutate(MutationOptions(
          documentNode: gql(newOweMutation),
          onCompleted: (a) {
            Navigator.pop(context);
          }));
    }

    Future<bool> onWilPopScope() async {
      if (panelController.isAttached && panelController.isPanelOpen) {
        await panelController.close();
        return false;
      }
      return true;
    }

    // void clearHiveBox() {
    //   Box<Owe> oweBox = Hive.box('oweBox');
    //   oweBox.clear();
    // }
    return Provider.value(
      value: panelController,
      child: WillPopScope(
        onWillPop: onWilPopScope,
        child: Scaffold(
          floatingActionButton: platform == TargetPlatform.android
              ? FloatingActionButton(
                  child: Icon(Icons.check),
                  onPressed: addNewOwe,
                )
              : null,
          body: SafeArea(
            child: SlidingUpPanel(
              minHeight: 0,
              // maxHeight: MediaQuery.of(context).size.height * 0.5,
              parallaxEnabled: true,
              panelSnapping: false,
              padding: EdgeInsets.all(15),
              controller: panelController,
              backdropTapClosesPanel: true,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              panelBuilder: (ScrollController sc) => ContactSelector(
                scrollController: sc,
              ),
              body: ListView(
                padding: EdgeInsets.all(15),
                children: <Widget>[
                  Container(),
                  Text("Title", style: Theme.of(context).textTheme.headline3),
                  TextField(
                    controller: titleController,
                    cursorColor: Theme.of(context).accentColor,
                    decoration: InputDecoration.collapsed(
                      hintText: "Enter the reasoning behind this transaction",
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Select Person",
                      style: Theme.of(context).textTheme.headline3),
                  PeopleList(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "How much money did you lend?",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "₹",
                        style: TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).accentColor),
                      ),
                      Expanded(
                        child: TextField(
                            controller: amountController,
                            cursorColor: Theme.of(context).accentColor,
                            decoration: InputDecoration(
                              hintText: "00",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(0),
                            ),
                            style: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).accentColor),
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: false, signed: false)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (platform == TargetPlatform.iOS)
                    Container(
                      height: 60,
                      width: 400,
                      child: CupertinoButton.filled(
                          disabledColor: Theme.of(context).accentColor,
                          child: Text('Done'),
                          onPressed: addNewOwe),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
