import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Entire App Test", () {
    FlutterDriver driver;

    setUpAll(() async {
      // https://github.com/flutter/flutter/issues/12561#issuecomment-448999726
      await Process.run(
          "adb",
          "shell pm grant dev.preetjdp.youoweme android.permission.READ_CONTACTS"
              .split(" "));
      driver = await FlutterDriver.connect();
      await driver.startTracing();
    });

    tearDownAll(() async {
      Timeline timeline = await driver.stopTracingAndDownloadTimeline();
      final summary = new TimelineSummary.summarize(timeline);
      print("WOWZA" + summary.toString());
      summary.writeSummaryToFile('riverpod',
          pretty: true, destinationDirectory: "./test_driver/result/");
      if (driver != null) driver.close();
    });

    test("Check Flutter Driver health", () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    test("Intro Flow", () async {
      await driver.tap(find.byType("TextField"));
      await driver.enterText("Preet Parekh");
      await driver.tap(find.text("Next"));

      await driver.tap(find.byType("TextField"));
      await driver.enterText("9594128425");
      await driver.tap(find.text("Next"));

      await driver.waitFor(find.byType("PinCodeTextField"));
      await driver.tap(find.byType("PinCodeTextField"));
      await driver.enterText("123456");

      await driver.waitFor(find.byValueKey("notification_permission_next"));
      await driver.tap(find.byValueKey("notification_permission_next"));

      // await driver.waitFor(find.byValueKey("contact_permission_next"));
      // await driver.tap(find.byValueKey("contact_permission_next"));

      sleep(const Duration(seconds: 3));
    });

    test("OweMe Page", () async {
      await driver.tap(find.text("Owe Me"));
      await driver.scroll(find.byType("CustomScrollView"), 0, -600,
          Duration(milliseconds: 200));

      await driver.tap(find.pageBack());
    });

    test("IOwe Page", () async {
      await driver.tap(find.text("I Owe"));
      await driver.scroll(find.byType("CustomScrollView"), 0, -600,
          Duration(milliseconds: 200));

      await driver.tap(find.pageBack());
    });

    test("NewOwe Page", () async {
      await driver.tap(find.text("New"));

      await Future.delayed(Duration(seconds: 2));

      await driver.tap(find.pageBack());
    });
  });
}
