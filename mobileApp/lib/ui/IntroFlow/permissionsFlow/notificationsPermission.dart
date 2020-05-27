// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class NotificationsPermissions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    void nextPage() {
      Provider.of<PageController>(context, listen: false).nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOutQuad);
    }

    SizedBox _spacer(int padding, [int minus = 0]) {
      return SizedBox(height: (_size.height / padding) - minus);
    }

    void allowNotifications() async {
      PermissionStatus status = await Permission.notification.request();
      print(status);
      if (status.isGranted) {
        nextPage();
      }
    }

    return Padding(
      padding: EdgeInsets.all(15),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            bottom: 65,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _spacer(18, 20),
                  Text("We need Notification Permissions.",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: _size.width / 8)),
                  _spacer(16),
                  Center(
                    child: Container(
                      height: 60,
                      width: 400,
                      child: CupertinoButton(
                          color: CupertinoColors.activeGreen,
                          child: Text('Allow Notifications'),
                          onPressed: allowNotifications),
                    ),
                  ),
                  Image.asset("assets/scribbles/karlsson_paper_plane.png")
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: 60,
                width: 400,
                child: CupertinoButton(
                    color: Theme.of(context).accentColor,
                    child: Text('Next'),
                    onPressed: allowNotifications),
              ))
        ],
      ),
    );
  }
}
