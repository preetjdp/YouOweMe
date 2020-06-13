// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

// 📦 Package imports:
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:YouOweMe/resources/extensions.dart';

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
      Navigator.of(context).push(MaterialWithModalsPageRoute(
          builder: (BuildContext context) => IOwePage(),
          settings: RouteSettings(name: "I Owe Page")));
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
                onPressed: goToIOwePage,
                minSize: 0,
                padding: EdgeInsets.all(0),
                child: Row(
                  children: <Widget>[
                    Text("I Owe",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white)),
                    Icon(
                      CupertinoIcons.right_chevron,
                      color: Colors.white,
                    )
                  ],
                ),
              )),
          Positioned(
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: GestureDetector(
                  onTap: goToIOwePage,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.centerRight,
                            stops: [
                              0,
                              0.8
                            ],
                            colors: [
                              Colors.white.withOpacity(0.2),
                              Colors.transparent
                            ]),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Color.fromRGBO(78, 80, 88, 0.05),
                              spreadRadius: 0.1)
                        ]),
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (me != null)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("₹ " + me.iOweAmount.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          .copyWith(color: Colors.white)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.face,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "to ${me.iOwe.stateCreated.length} people",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              )
                            else
                              Expanded(
                                  child: Center(
                                child: YOMSpinner(
                                  brightness: Brightness.dark,
                                ),
                              ))
                          ],
                        )),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
