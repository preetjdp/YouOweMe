// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/ui/IOwe/iOwePage.dart';

class IOweSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Seva$Query$User me = Provider.of<MeNotifier>(context).me;
    void goToIOwePage() {
      Navigator.of(context).pushNamed('i_owe_page');
    }

    return Container(
      height: 130,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
              left: 0,
              top: 0,
              child: CupertinoButton(
                onPressed: goToIOwePage,
                minSize: 0,
                padding: EdgeInsets.all(0),
                child: Row(
                  children: <Widget>[
                    Text("I Owe", style: Theme.of(context).textTheme.headline5),
                    Icon(
                      CupertinoIcons.right_chevron,
                      color: Color.fromRGBO(78, 80, 88, 1),
                    )
                  ],
                ),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (me != null)
                        Text(me.iOweAmount.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(color: Theme.of(context).accentColor))
                      else
                        Expanded(
                            child: Center(
                          child: YOMSpinner(),
                        ))
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
