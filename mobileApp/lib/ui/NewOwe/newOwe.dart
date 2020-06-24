// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/resources/providers.dart';
import 'package:YouOweMe/ui/NewOwe/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/ui/Abstractions/yomButton.dart';
import 'package:YouOweMe/ui/NewOwe/contactSelector.dart';
import 'package:YouOweMe/ui/NewOwe/peopleList.dart';
import 'package:YouOweMe/resources/extensions.dart';
import 'package:basics/basics.dart';

class NewOwe extends StatefulHookWidget {
  @override
  _NewOweState createState() => _NewOweState();
}

class _NewOweState extends State<NewOwe> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final YomButtonController yomButtonController = YomButtonController();

  final _formKey = GlobalKey<FormState>();

  String titleValidator(String text) {
    if (text.length == 0) {
      return "Enter a valid text";
    }
    return null;
  }

  String amountValidator(String text) {
    if (text.length == 0) {
      return "Enter a valid number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final PanelController panelController =
        useProvider(newOweSlidingPanelControllerProvider);
    final MeNotifier meNotifier = useProvider(meNotifierProvider);
    final selectedContact = useProvider(newOweSelectedContactProvider.state);

    TargetPlatform platform = Theme.of(context).platform;

    void clearSelectedContact() {
      newOweSelectedContactProvider.read(context).clear();
    }

    void addNewOwe() async {
      yomButtonController.showLoading();
      try {
        bool isValidated = _formKey.currentState.validate();
        if (!isValidated) {
          throw ("Not Validatd");
        }
        final newOweMutation = '''
        mutation (\$input :  NewOweInputType!) {
          newOwe(data: \$input) {
            id
            title
          }
        }
      ''';
        String mobileNo =
            selectedContact.phones.first.value.replaceAll(' ', '');
        if (!mobileNo.startsWith('+91')) {
          mobileNo = '+91' + mobileNo;
        }
        print(mobileNo);
        await meNotifier.graphQLClient.mutate(MutationOptions(
            documentNode: gql(newOweMutation),
            variables: {
              "input": {
                "title": titleController.text,
                "amount": int.parse(amountController.text),
                "mobileNo": mobileNo,
                "displayName": selectedContact.displayName
              }
            },
            onCompleted: (a) {
              meNotifierProvider.read(context).refresh();
              yomButtonController.showSuccess();
              Navigator.pop(context);
            }));
      } catch (e) {
        print(e);
        yomButtonController.showError();
      }
    }

    Future<bool> onWilPopScope() async {
      if (panelController.isAttached && panelController.isPanelOpen) {
        await panelController.close();
        return false;
      }
      return true;
    }

    return WillPopScope(
      onWillPop: onWilPopScope,
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.5),
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).accentColor, width: 0.5)),
          middle: Text("New Owe",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.black)),
          actionsForegroundColor: Theme.of(context).accentColor,
        ),
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
            body: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(15),
                children: <Widget>[
                  Container(),
                  Text("Title", style: Theme.of(context).textTheme.headline5),
                  TextFormField(
                    controller: titleController,
                    validator: titleValidator,
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
                      style: Theme.of(context).textTheme.headline5),
                  PeopleList(),
                  SizedBox(
                    height: 10,
                  ),
                  if (selectedContact.isNotNull) ...[
                    Text(
                      "Selected Person",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          YomAvatar(
                            text: selectedContact.displayName != null
                                ? selectedContact.shortName
                                : "+91",
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            selectedContact.displayName ??
                                selectedContact.phones.first.value,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Expanded(child: Container()),
                          CupertinoButton(
                            minSize: 20,
                            padding: EdgeInsets.all(5),
                            onPressed: clearSelectedContact,
                            child: Icon(
                              CupertinoIcons.clear_thick_circled,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                  Text(
                    "How much money did you lend?",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "₹",
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                      Expanded(
                        child: TextFormField(
                            controller: amountController,
                            validator: amountValidator,
                            cursorColor: Theme.of(context).accentColor,
                            decoration: InputDecoration(
                              hintText: "00",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(0),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(color: Theme.of(context).accentColor),
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
                      child: YomButton(
                          child: Text('Done'),
                          controller: yomButtonController,
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
