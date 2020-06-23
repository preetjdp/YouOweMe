import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/helpers.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpacer.dart';
import 'package:YouOweMe/ui/HomePage/profilePicturePicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:YouOweMe/resources/extensions.dart';

class HomePageBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Seva$Query$User me = context.watch<MeNotifier>().me;
    void navigateToProfilePicker() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => ProfilePicturePicker()));
    }

    return CupertinoActionSheet(
      // title: Text(me.name),
      message: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CupertinoButton(
            onPressed: navigateToProfilePicker,
            minSize: 0,
            padding: EdgeInsets.all(0),
            child: Stack(
              children: [
                YomAvatar.fromUser(
                  user: me,
                  size: 80,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Icon(
                    CupertinoIcons.photo_camera_solid,
                    color: context.yomDesign.yomWhite2,
                    size: 28,
                  ),
                )
              ],
            ),
          ),
          YomSpacer(
            width: 15,
          ),
          Text(
            me.name,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context, false);
        },
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(
            "Toggle Device Preview",
          ),
          onPressed: () {
            toggleDevicePreview();
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            "Log me out already. 😪",
            style: TextStyle(color: CupertinoColors.activeGreen),
          ),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
