import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/IOwe/iOwePageElement.dart';
import 'package:YouOweMe/ui/IOwe/iOwePageEmptyState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:YouOweMe/resources/extensions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class IOwePage extends StatelessWidget {
  final PanelController panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    final List<Seva$Query$User$Owe> iOwe = Provider.of<MeNotifier>(context)
        .me
        .iOwe
        .fromStates([OweState.CREATED, OweState.ACKNOWLEDGED]);

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
                bottom: BorderSide(
                    color: Theme.of(context).accentColor, width: 0.5)),
            middle: Text("I Owe",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black)),
            actionsForegroundColor: Theme.of(context).accentColor,
          ),
          body: SafeArea(
              child: iOwe.isNotEmpty
                  ? ListView.builder(
                      itemCount: iOwe.length,
                      padding: const EdgeInsets.all(15.0),
                      itemBuilder: (BuildContext context, int index) {
                        Seva$Query$User$Owe owe = iOwe[index];
                        return IOwePageElement(
                          owe: owe,
                        );
                      })
                  : IOwePageEmptyState())),
    );
  }
}
