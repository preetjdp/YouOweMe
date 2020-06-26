import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/providers.dart';
import 'package:YouOweMe/ui/Abstractions/jiggle.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:YouOweMe/ui/HomePage/graph.dart';
import 'package:YouOweMe/ui/HomePage/providers.dart';
import 'package:flutter/material.dart';
import 'package:basics/basics.dart';
import 'package:YouOweMe/resources/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NettingAndGraphSection extends HookWidget {
  final YomDesign yomDesign = YomDesign();
  @override
  Widget build(BuildContext context) {
    Seva$Query$User me = useProvider(meNotifierProvider).me;
    final jiggleController = useProvider(homePageJiggleControllerProvider);

    void longPress() {
      jiggleController.toggle();
    }

    return Container(
      height: 230,
      color: Colors.transparent,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverToBoxAdapter(
            child: JiggleMode(
              jiggleController: jiggleController,
              child: Container(
                // width: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Color.fromRGBO(78, 80, 88, 0.05),
                        spreadRadius: 0.1)
                  ],
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.autorenew,
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Netting",
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        YomAvatar(
                          text: "PP",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Preet Parekh",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Chip(
                        label: Text(
                          "₹ 200",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: yomDesign.yomGreen1),
                        ),
                        backgroundColor: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.2)),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Chip(
                      label: Text("₹ 200",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: yomDesign.yomPurple2)),
                      backgroundColor: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: JiggleMode(
              jiggleController: jiggleController,
              child: Container(
                  width: 280,
                  margin: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Color.fromRGBO(78, 80, 88, 0.05),
                          spreadRadius: 0.1)
                    ],
                  ),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_down,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Stats",
                            style: Theme.of(context).textTheme.headline5,
                          )
                        ],
                      ),
                      Expanded(
                          child: me.isNotNull
                              ? GraphView(
                                  values: me.iOwe
                                      .fromStates([
                                        OweState.ACKNOWLEDGED,
                                        OweState.CREATED
                                      ])
                                      .map((e) => e.amount.toDouble())
                                      .toList())
                              : Center(
                                  child: YOMSpinner(),
                                ))
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
