import 'package:YouOweMe/ui/NewOwe/newOwe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOwePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Colors.white.withOpacity(0.5),
          middle: Text("I Owe",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: Colors.black)),
          actionsForegroundColor: Theme.of(context).accentColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: IOwePageEmptyState(),
        ));
  }
}

class IOwePageEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void goToNewOwe() async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => NewOwe()));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Container()),
        Image.asset("assets/scribbles/scribble2.png"),
        Expanded(child: Container()),
        SizedBox(
          height: 10,
        ),
        Text(
          "Oh oo ...\nThere seem to be no Owes here. 😯",
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          child: CupertinoButton(
              color: Theme.of(context).accentColor,
              child: Text('Add an New Owe'),
              onPressed: goToNewOwe),
        )
      ],
    );
  }
}
