import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:YouOweMe/resources/providers.dart';
import 'package:YouOweMe/resources/notifiers/devicePreviewSetting.dart';

class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<PackageInfo> packageInfo =
        useProvider(packageInfoProvider);
    final devicePreviewSetting =
        useProvider(devicePreviewSettingProvider.state);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
        ),
      ),
      body: SettingsList(
        sections: [
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
                title: 'Sound Effects',
                leading: Icon(Icons.surround_sound),
                switchValue: true,
                onToggle: (bool value) {},
              ),
              SettingsTile.switchTile(
                title: 'In Game Music',
                leading: Icon(Icons.music_note),
                switchValue: false,
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
                title: 'Privacy',
                leading: Icon(Icons.privacy_tip),
                onTap: () {},
              ),
              SettingsTile(
                title: 'Blocking',
                leading: Icon(Icons.block),
                onTap: () {},
              ),
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
              // SettingsTile.switchTile(
              //   title: 'Enable UI Placeholders',
              //   leading: Icon(Icons.carpenter),
              //   switchValue: placeholderSetting,
              //   onToggle: (bool value) {
              //     context.read(placeholderSettingProvider).toggle();
              //   },
              // ),
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
                          error: (a, b) => Text("Error")))))
        ],
      ),
    );
  }
}
