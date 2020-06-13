// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/Abstractions/yomBottomSheet.dart';
import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/ui/OweMe/oweMePageBottomSheet.dart';
import 'package:YouOweMe/resources/extensions.dart';

class OweMePageElement extends StatelessWidget {
  final Seva$Query$User$Owe owe;
  OweMePageElement({@required this.owe});
  @override
  Widget build(BuildContext context) {
    void showOweDetails() async {
      Widget builder(BuildContext context, ScrollController scrollController) =>
          OweMePageBottomSheet(
            scrollController: scrollController,
            owe: owe,
          );
      showYomBottomSheet(context: context, builder: builder);
    }

    return GestureDetector(
      onTap: showOweDetails,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        constraints: BoxConstraints(minHeight: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            YomAvatar(
              text: owe.issuedTo.shortName,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                owe.title,
                style: Theme.of(context).textTheme.headline5,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // CupertinoButton(
            //   onPressed: () {},
            //   padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            //   child: Icon(
            //     CupertinoIcons.check_mark_circled,
            //     size: 28,
            //   ),
            // ),
            SizedBox(
              width: 10,
            ),
            Container(
              constraints: BoxConstraints(minWidth: 65),
              child: CupertinoButton(
                  color: Theme.of(context).accentColor,
                  minSize: 20,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    owe.amount.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
