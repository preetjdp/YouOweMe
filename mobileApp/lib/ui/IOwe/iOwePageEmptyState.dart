import 'package:YouOweMe/ui/NewOwe/newOwe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOwePageEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void goToNewOwe() async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) => NewOwe()));
    }

    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
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
      ),
    );
  }
}
