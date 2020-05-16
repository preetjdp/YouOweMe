import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:YouOweMe/resources/extensions.dart';

class OweMePageBottomSheet extends StatelessWidget {
  final Seva$Query$User$Owe owe;
  final ScrollController scrollController;
  OweMePageBottomSheet({@required this.scrollController, @required this.owe});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: Material(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15),
          children: [
            Text("Title", style: Theme.of(context).textTheme.headline5),
            Text(owe.title, style: Theme.of(context).textTheme.bodyText2),
            SizedBox(
              height: 20,
            ),
            Text("Amount To Be Recieved",
                style: Theme.of(context).textTheme.headline5),
            RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.headline1,
                  children: [
                    TextSpan(
                        text: "₹",
                        style: TextStyle(color: Theme.of(context).accentColor)),
                    TextSpan(text: owe.amount.toInt().toString())
                  ]),
            ),
            Text("Wait When was this Again?",
                style: Theme.of(context).textTheme.headline5),
            Text(owe.created.simpler,
                style: Theme.of(context).textTheme.bodyText2),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: 400,
              child: CupertinoButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Ping Him Up!'),
                  onPressed: () {}),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: 400,
              child: CupertinoButton(
                  color: CupertinoColors.activeGreen,
                  child: Text('Mark As Paid'),
                  onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
