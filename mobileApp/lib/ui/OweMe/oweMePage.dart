import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/OweMe/oweMePageElement.dart';
import 'package:YouOweMe/ui/OweMe/oweMePageEmptyState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:YouOweMe/resources/extensions.dart';

class OweMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Seva$Query$User$Owe> oweMe = Provider.of<MeNotifier>(context)
        .me
        .oweMe
        .fromStates([OweState.CREATED, OweState.ACKNOWLEDGED]);
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.5),
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).accentColor, width: 0.5)),
          middle: Text("Owe Me",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.black)),
          actionsForegroundColor: Theme.of(context).accentColor,
        ),
        body: oweMe.isNotEmpty
            ? ListView.builder(
                itemCount: oweMe.length,
                padding: EdgeInsets.all(15),
                itemBuilder: (BuildContext context, int index) {
                  Seva$Query$User$Owe owe = oweMe[index];
                  return OweMePageElement(
                    owe: owe,
                  );
                })
            : OweMePageEmptyState());
  }
}
