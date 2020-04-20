import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

const kBarWidth = 72.0;
const kBarSpacing = 4.0;
const kLabelHeight = 32.0;
const kTrackHeight = 32.0;
// const kMaxValue = 540.0;
const kMaxValue = 300.0;
const kStrokeWidth = 8.0;

const MaterialColor primaryAccent = MaterialColor(
  0xFF121212,
  <int, Color>{
    50: Color(0xFFf7f7f7),
    100: Color(0xFFeeeeee),
    200: Color(0xFFe2e2e2),
    300: Color(0xFFd0d0d0),
    400: Color(0xFFababab),
    500: Color(0xFF8a8a8a),
    600: Color(0xFF636363),
    700: Color(0xFF505050),
    800: Color(0xFF323232),
    900: Color(0xFF121212),
  },
);
const MaterialColor secondaryAccent = MaterialColor(
  0xFF03dac4,
  <int, Color>{
    50: Color(0xFFd4f6f2),
    100: Color(0xFF92e9dc),
    200: Color(0xFF03dac4),
    300: Color(0xFF00c7ab),
    400: Color(0xFF00b798),
    500: Color(0xFF00a885),
    600: Color(0xFF009a77),
    700: Color(0xFF008966),
    800: Color(0xFF007957),
    900: Color(0xFF005b39),
  },
);
final List<double> values =
    List.generate(100, (_) => math.Random().nextDouble() * kMaxValue);

class MyGraphApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: SizedBox(height: kMaxValue, child: GraphView(values: values)),
    );
  }
}

class GraphView extends BoxScrollView {
  const GraphView({
    Key key,
    @required this.values,
  }) : super(key: key, scrollDirection: Axis.horizontal);

  final List<double> values;

  @override
  Widget buildChildLayout(BuildContext context) {
    final List<Seva$Query$User$Owe> iOwe =
        Provider.of<MeNotifier>(context).me.iOwe;
        final List<Seva$Query$User$Owe> oweMe =
        Provider.of<MeNotifier>(context).me.oweMe;
    final List<double> valuesA = iOwe.map((e) => e.amount).toList();
    final List<double> valuesB = oweMe.map((e) => e.amount).toList();
    valuesB.addAll(valuesA);
    return SliverToBoxAdapter(child: GraphWidget(values: valuesB));
  }
}

class GraphWidget extends LeafRenderObjectWidget {
  const GraphWidget({
    Key key,
    @required this.values,
  }) : super(key: key);

  final List<double> values;

  @override
  RenderGraphBox createRenderObject(BuildContext context) {
    return RenderGraphBox(values: values);
  }

  @override
  void updateRenderObject(BuildContext context, RenderGraphBox renderObject) {
    renderObject..values = values;
  }
}

class GraphParentData extends ContainerBoxParentData<GraphItemBar> {}

class RenderGraphBox extends RenderBox
    with
        ContainerRenderObjectMixin<GraphItemBar, GraphParentData>,
        RenderBoxContainerDefaultsMixin<GraphItemBar, GraphParentData> {
  RenderGraphBox({@required List<double> values}) : _values = values {
    addChildren(_values);
  }

  List<double> _values;

  List<double> get values => _values;

  set values(List<double> values) {
    if (_values == values) {
      return;
    }
    _values = values;
    addChildren(_values);
    markNeedsLayout();
  }

  void addChildren(List<double> values) {
    addAll(values.map((value) => GraphItemBar(value: value)).toList());
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! GraphParentData) {
      child.parentData = GraphParentData();
    }
  }

  @override
  BoxConstraints get constraints =>
      super.constraints.copyWith(maxWidth: childCount * kBarWidth);

  @override
  void performLayout() {
    final maxHeight = constraints.maxHeight - kTrackHeight - kLabelHeight;
    final maxValue = values.reduce(math.max);

    GraphItemBar child = firstChild;
    int childCount = 0;
    while (child != null) {
      final height = interpolate(
          inputMax: maxValue, input: child.value, outputMax: maxHeight);
      child.layout(BoxConstraints.tight(Size(kBarWidth - kBarSpacing, height)),
          parentUsesSize: true);

      final GraphParentData childParentData = child.parentData;
      childParentData.offset =
          Offset(childCount * kBarWidth, maxHeight - height + kLabelHeight);

      child = childParentData.nextSibling;
      childCount++;
    }

    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    GraphItemBar child = firstChild;
    Offset prevCenterTop;
    const resolvedChildRadius = (kBarWidth - kBarSpacing) / 2;
    final points = <Offset>[];
    final path = Path();

    while (child != null) {
      final GraphParentData childParentData = child.parentData;
      final resolvedChildOffset = childParentData.offset + offset;
      context.paintChild(child, resolvedChildOffset);

      final centerTop = Offset(
          resolvedChildOffset.dx + resolvedChildRadius, resolvedChildOffset.dy);

      if (prevCenterTop == null) {
        path.moveTo(centerTop.dx, centerTop.dy);
        prevCenterTop = centerTop;
      }

      points.add(centerTop);

      final anchor = (prevCenterTop + centerTop) / 2;
      final pointA = (anchor + prevCenterTop) / 2;
      final pointB = (anchor + centerTop) / 2;
      path.quadraticBezierTo(pointA.dx, prevCenterTop.dy, anchor.dx, anchor.dy);
      path.quadraticBezierTo(
          pointB.dx, centerTop.dy, centerTop.dx, centerTop.dy);

      child = childParentData.nextSibling;
      prevCenterTop = centerTop;
    }

    // context.canvas.drawPath(
    //   Path()..addPath(path, Offset(-10, kStrokeWidth * 20)),
    //   Paint()
    //     ..style = PaintingStyle.stroke
    //     ..strokeWidth = kStrokeWidth
    //     ..color = Colors.black87
    //     ..maskFilter = MaskFilter.blur(BlurStyle.normal, kStrokeWidth)
    //     ..strokeCap = StrokeCap.round,
    // );

    final rect = offset & size;
    context.canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = kStrokeWidth
        ..color = Colors.redAccent
        ..shader = ui.Gradient.linear(
          rect.centerLeft,
          rect.centerRight,
          [secondaryAccent, Color(0xFFF1B61E)],
        ),
    );

    for (var i = 0; i < points.length; i++) {
      final point = points[i];

      //The Blur Around the Grey Circle
      context.canvas.drawCircle(
        point,
        kStrokeWidth * 0.7,
        Paint()
          ..color = yomTheme.accentColor
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, kStrokeWidth),
      );

      // The Grey Point Circle
      context.canvas.drawCircle(
          point, kStrokeWidth / 1.6, Paint()..color = yomTheme.accentColor);

      // const labelTextMargin = kStrokeWidth * 2;
      // final labelTextRect = Offset(point.dx - kBarWidth / 2,
      //         constraints.maxHeight + labelTextMargin - kTrackHeight) &
      //     Size(kBarWidth, kTrackHeight - labelTextMargin);
      // final textPainter = TextPainter(
      //   textDirection: TextDirection.ltr,
      //   textAlign: TextAlign.center,
      //   textWidthBasis: TextWidthBasis.longestLine,
      //   text: TextSpan(
      //     text: '$i',
      //     style: TextStyle(
      //       color: primaryAccent.shade800,
      //       fontSize: 12,
      //       fontWeight: FontWeight.w700,
      //       shadows: [ui.Shadow(blurRadius: 2, offset: const Offset(0, 1))],
      //     ),
      //   ),
      // )..layout(maxWidth: labelTextRect.size.width);
      // textPainter.paint(context.canvas,
      //     labelTextRect.centerLeft - Offset(0, textPainter.height / 2));

      const valueTextMargin = kStrokeWidth * 2;
      final valueTextRect = Offset(point.dx - kBarWidth / 2,
              point.dy - kLabelHeight - valueTextMargin) &
          Size(kBarWidth, kLabelHeight - valueTextMargin);
      final labelTextPainter = TextPainter(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        textWidthBasis: TextWidthBasis.longestLine,
        text: TextSpan(
            text: '\₹${values[i].toStringAsFixed(1)}',
            style: yomTheme.textTheme.headline3),
      )..layout(maxWidth: valueTextRect.size.width);
      labelTextPainter.paint(context.canvas,
          valueTextRect.centerLeft - Offset(0, labelTextPainter.height / 2));
    }
  }
}

class GraphItemBar extends RenderBox {
  GraphItemBar({double value}) : _value = value;

  double _value;

  double get value => _value;

  set value(double value) {
    _value = value;
    markNeedsPaint();
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    if (event is PointerDownEvent) {
      print(value);
    }
  }

  @override
  bool get sizedByParent => true;
}

// https://math.stackexchange.com/questions/377169/going-from-a-value-inside-1-1-to-a-value-in-another-range/377174#377174
double interpolate({
  double input,
  double inputMin = 0,
  double inputMax = 1,
  double outputMin = 0,
  double outputMax = 1,
  Curve curve = Curves.linear,
}) {
  double result = math.max(inputMin, input);

  if (outputMin == outputMax) {
    return outputMin;
  }

  if (inputMin == inputMax) {
    if (input <= inputMin) {
      return outputMin;
    }
    return outputMax;
  }

  // Input Range
  if (inputMin == -double.infinity) {
    result = -result;
  } else if (inputMax == double.infinity) {
    result = result - inputMin;
  } else {
    result = (result - inputMin) / (inputMax - inputMin);
  }

  // Easing
  result = curve.transform(result);

  // Output Range
  if (outputMin == -double.infinity) {
    result = -result;
  } else if (outputMax == double.infinity) {
    result = result + outputMin;
  } else {
    result = result * (outputMax - outputMin) + outputMin;
  }

  return result;
}
