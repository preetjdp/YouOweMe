// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/Abstractions/yomButton.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart' as yomDesign;

// Done so as to does not affect with init of yomTheme

void main() {
  ThemeData yomTheme = yomDesign.yomTheme();
  Widget child = Container(
    height: 50,
    width: 50,
    color: Colors.redAccent,
  );

  VoidCallback callback = () {
    print("Hello World");
  };

  group("YomButton Tests", () {
    testWidgets("No Controller Passed", (WidgetTester tester) async {
      await tester.pumpWidget(YomButton(
        child: child,
        onPressed: callback,
      ));

      expect(find.byType(YomButton), findsOneWidget);
      expect(find.byWidget(child), findsOneWidget);
      await tester.tap(find.byType(YomButton));
    });

    testWidgets("Controller Passed with defaults", (WidgetTester tester) async {
      YomButtonController controller = YomButtonController();
      await tester.pumpWidget(MaterialApp(
        theme: yomTheme,
        home: YomButton(
          child: child,
          controller: controller,
          onPressed: callback,
        ),
      ));

      RenderDecoratedBox actualBox =
          tester.renderObject(find.byType(DecoratedBox));
      BoxDecoration actualDecoration = actualBox.decoration as BoxDecoration;

      expect(actualDecoration.color, yomTheme.accentColor);

      await tester.runAsync(() async {
        controller.showError();
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
        await Future.delayed(Duration(seconds: 2));
        await tester.pump();
        expect(find.byWidget(child), findsOneWidget);
      });

      await tester.runAsync(() async {
        controller.showLoading();
        await Future.delayed(Duration(milliseconds: 500));
        await tester.pump();
        expect(find.byType(YOMSpinner), findsOneWidget);
      });

      await tester.runAsync(() async {
        controller.showSuccess();
        await tester.pumpAndSettle();
        expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
        await Future.delayed(Duration(seconds: 2));
        await tester.pump();
        expect(find.byWidget(child), findsOneWidget);
      });
    });

    testWidgets("Controller Passed with Custom Parameters",
        (WidgetTester tester) async {
      YomButtonController controller = YomButtonController();

      Widget errorWidget = Text("Is Error");
      Widget loadingWidget = Text("Is Loading");
      Widget successWidget = Text("Success");
      Color customColor = Colors.pink;
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: YomButton(
          child: child,
          controller: controller,
          onPressed: callback,
          error: errorWidget,
          loading: loadingWidget,
          success: successWidget,
          backgroundColor: customColor,
        ),
      ));

      RenderDecoratedBox actualBox =
          tester.renderObject(find.byType(DecoratedBox));
      BoxDecoration actualDecoration = actualBox.decoration as BoxDecoration;

      expect(actualDecoration.color, customColor);

      await tester.runAsync(() async {
        controller.showError();
        await tester.pumpAndSettle();
        expect(find.byWidget(errorWidget), findsOneWidget);
        await Future.delayed(Duration(seconds: 2));
        await tester.pump();
        expect(find.byWidget(child), findsOneWidget);
      });

      await tester.runAsync(() async {
        controller.showLoading();
        await Future.delayed(Duration(milliseconds: 500));
        await tester.pump();
        expect(find.byWidget(loadingWidget), findsOneWidget);
      });

      await tester.runAsync(() async {
        controller.showSuccess();
        await tester.pumpAndSettle();
        expect(find.byWidget(successWidget), findsOneWidget);
        await Future.delayed(Duration(seconds: 2));
        await tester.pump();
        expect(find.byWidget(child), findsOneWidget);
      });
    });
  });
}
