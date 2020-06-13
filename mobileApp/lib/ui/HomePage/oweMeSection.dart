// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:YouOweMe/resources/extensions.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/ui/OweMe/oweMePage.dart';

class OweMeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Seva$Query$User me = Provider.of<MeNotifier>(context).me;
    void goToOweMePage() {
      Navigator.of(context).push(MaterialWithModalsPageRoute(
          builder: (BuildContext context) => OweMePage(),
          settings: RouteSettings(name: "Owe Me Page")));
    }

    return Container(
      height: 150,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
              left: 0,
              top: 0,
              child: CupertinoButton(
                onPressed: goToOweMePage,
                minSize: 0,
                padding: EdgeInsets.all(0),
                child: Row(
                  children: <Widget>[
                    Text("Owe Me",
                        style: Theme.of(context).textTheme.headline5),
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
            child: GestureDetector(
              onTap: goToOweMePage,
              child: Container(
                height: 120,
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("₹ " + me.oweMeAmount.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      .copyWith(
                                          color:
                                              Theme.of(context).accentColor)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.face,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "${me.oweMe.stateCreated.length} people",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          )
                        else
                          Expanded(child: Center(child: YOMSpinner()))
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
