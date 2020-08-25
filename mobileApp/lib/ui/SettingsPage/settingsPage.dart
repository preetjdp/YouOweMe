import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomAppBar.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:YouOweMe/resources/providers.dart';
import 'package:YouOweMe/resources/notifiers/devicePreviewSetting.dart';
import 'package:YouOweMe/resources/extensions.dart';

class SettingsPage extends HookWidget {
  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<PackageInfo> packageInfo =
        useProvider(packageInfoProvider);
    final devicePreviewSetting =
        useProvider(devicePreviewSettingProvider.state);
    final MeNotifier meNotifier = useProvider(meNotifierProvider);
    return Scaffold(
      appBar: YomAppBar(
        title: "Settings",
      ),
      body: SettingsList(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        sections: [
          CustomSection(
            child: Padding(
              padding: EdgeInsets.all(15).copyWith(bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  YomAvatar(
                    text: meNotifier?.me?.shortName ?? "PP",
                    size: 100,
                  ),
                  Text(
                    meNotifier.me.name,
                    style: Theme.of(context).textTheme.headline5,
                  )
                ],
              ),
            ),
          ),
          SettingsSection(
            title: 'General',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onTap: () {},
              ),
              SettingsTile.switchTile(
                title: 'Shake to Help',
                leading: Icon(Icons.screen_rotation),
                switchValue: false,
                onToggle: (bool value) {},
              ),
              SettingsTile.switchTile(
                title: 'Notifications',
                leading: Icon(Icons.notifications),
                switchValue: true,
                onToggle: (bool value) {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(
                title: 'Profile',
                leading: Icon(Icons.account_box),
                onTap: () {},
              ),
              SettingsTile(
                title: 'Link with UPI',
                subtitle: "Requires Attention",
                leading: Icon(Icons.account_balance_wallet),
                onTap: () {},
              ),
              SettingsTile(
                title: 'Your Data with Us',
                leading: Icon(Icons.analytics),
                onTap: () {},
              ),
              SettingsTile(
                title: 'Logout',
                leading: Text("😪"),
                onTap: logOut,
              ),
            ],
          ),
          SettingsSection(
            title: 'Miscellaneous',
            tiles: [
              SettingsTile(
                  title: 'Terms of Service', leading: Icon(Icons.description)),
              SettingsTile(
                  title: 'Open source licenses',
                  leading: Icon(Icons.collections_bookmark)),
            ],
          ),
          SettingsSection(
            title: 'Developer Options',
            tiles: [
              SettingsTile.switchTile(
                title: 'Enable Device Preview',
                leading: Icon(Icons.phonelink_setup),
                switchValue: devicePreviewSetting,
                onToggle: (bool value) {
                  context.read(devicePreviewSettingProvider).toggle();
                },
              ),
            ],
          ),
          CustomSection(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                      child: packageInfo.when(
                          data: (packageInfo) =>
                              Text("Version ${packageInfo.version}"),
                          loading: () => Text("Loading"),
                          error: (a, b) => Text(
                                "Error",
                              )))))
        ],
      ),
    );
  }
}
