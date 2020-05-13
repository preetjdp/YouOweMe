import 'package:YouOweMe/ui/Abstractions/expandingWidgetDelegate.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:flutter/material.dart';

class NettingAndGraphSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      color: Colors.transparent,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverToBoxAdapter(
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
                          .copyWith(color: Color.fromRGBO(170, 225, 169, 1)),
                    ),
                    backgroundColor: Colors.white.withOpacity(0.2),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Chip(
                    label: Text("₹ 200",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Color.fromRGBO(163,160,228, 1))),
                    backgroundColor: Colors.white.withOpacity(0.2),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
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
                    Text(
                      "Graph",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Expanded(
                        child: Center(
                      child: YOMSpinner(),
                    ))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
