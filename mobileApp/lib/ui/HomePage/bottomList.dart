import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Provider.of<MeNotifier>(context).me.oweMe.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Seva$Query$Me$OweMe owe =
              Provider.of<MeNotifier>(context).me.oweMe[index];
          return Container(
            margin: EdgeInsets.only(top: 10),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                YomAvatar(
                  text: "PP",
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  owe.title,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Expanded(
                  child: Container(),
                ),
                CupertinoButton(
                    color: Theme.of(context).accentColor,
                    minSize: 20,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "54",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: () {})
              ],
            ),
          );
        });
  }
}
