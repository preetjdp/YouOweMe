// 🐦 Flutter imports:
import 'package:YouOweMe/ui/Abstractions/yomButton.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/IntroFlow/providers.dart';

class NotificationsPermissions extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        useProvider(introFlowPageControllerProvider);
    final _size = MediaQuery.of(context).size;
    void nextPage() {
      pageController.nextPage(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                _spacer(18, 20),
                Text("We need Notification Permissions.",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: _size.width / 8)),
                YomSpacer(
                  height: 5,
                ),
                Text(
                  "Notification permissions are required to send updates for owe requests.",
                  style: GoogleFonts.poppins(),
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                        "assets/scribbles/karlsson_paper_plane.png"),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 60,
              child: YomButton(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Text('Allow Notifications'),
                  onPressed: allowNotifications))
        ],
      ),
    );
  }
}
