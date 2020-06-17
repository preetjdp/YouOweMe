// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/Abstractions/yomBottomSheet.dart';
import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/resources/extensions.dart';

class IOwePageBottomSheet extends StatelessWidget {
  final Seva$Query$User$Owe owe;
  final ScrollController scrollController;
  IOwePageBottomSheet({@required this.scrollController, @required this.owe});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: Material(
        child: Padding(
          padding: EdgeInsets.all(15).copyWith(bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title", style: Theme.of(context).textTheme.headline5),
              Text(owe.title, style: Theme.of(context).textTheme.bodyText2),
              SizedBox(
                height: 20,
              ),
              if ([OweState.ACKNOWLEDGED, OweState.CREATED].contains(owe.state))
                Text("Amount To Be Paid",
                    style: Theme.of(context).textTheme.headline5)
              else if (owe.state == OweState.PAID)
                Text("Amount Paid",
                    style: Theme.of(context).textTheme.headline5),
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.headline1,
                    children: [
                      TextSpan(
                          text: "₹",
                          style:
                              TextStyle(color: Theme.of(context).accentColor)),
                      TextSpan(text: owe.amount.toInt().toString())
                    ]),
              ),
              Text("Wait When was this Again?",
                  style: Theme.of(context).textTheme.headline5),
              Text(owe.created.simpler,
                  style: Theme.of(context).textTheme.bodyText2),
              if ([OweState.ACKNOWLEDGED, OweState.CREATED]
                  .contains(owe.state)) ...[
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 400,
                  child: CupertinoButton(
                      color: Theme.of(context).accentColor,
                      child: Text('Pay Up!'),
                      onPressed: () {
                        showYomBottomSheet(
                            context: context,
                            builder: (a, b) => Center(child: YOMSpinner()));
                      }),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
