import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  YomAppBar({@required this.title});
  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.5),
      border: Border(
          bottom: BorderSide(color: Theme.of(context).accentColor, width: 0.5)),
      middle: Text(title,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.black)),
      // middle: Text("I Owe",
      //     style: Theme.of(context)
      //         .textTheme
      //         .headline5
      //         .copyWith(color: Colors.black)),
      actionsForegroundColor: Theme.of(context).accentColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kMinInteractiveDimensionCupertino);
}
