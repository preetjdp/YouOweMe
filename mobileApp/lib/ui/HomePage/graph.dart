import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/resources/providers.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:basics/basics.dart';
import 'package:YouOweMe/resources/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const kBarWidth = 72.0;
const kBarSpacing = 4.0;
const kLabelHeight = 32.0;
//This is the height of the bottom track used to show dates!!
// const kTrackHeight = 32.0;
const kTrackHeight = 0;
// const kMaxValue = 540.0;
const kMaxValue = 300.0;
const kStrokeWidth = 8.0;

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

class GraphWrapper extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final Seva$Query$User me = useProvider(meNotifierProvider).me;

    return Container(
        height: kMaxValue,
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: Color.fromRGBO(78, 80, 88, 0.05),
                  spreadRadius: 0.1)
            ]),
        child: me.isNotNull
            ? GraphView(
                values: me.iOwe
                    .fromStates([OweState.ACKNOWLEDGED, OweState.CREATED])
                    .map((e) => e.amount.toDouble())
                    .toList())
            : YOMSpinner());
  }
}

class GraphView extends BoxScrollView {
  const GraphView({
    Key key,
    @required this.values,
  }) : super(
            key: key,
            scrollDirection: Axis.horizontal,
            reverse: true,
            padding: const EdgeInsets.all(15));

  final List<double> values;

  @override
  Widget buildChildLayout(BuildContext context) {
    return SliverToBoxAdapter(child: GraphWidget(values: values));
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
    //TODO Change this back!
    // _values = values;
    // addChildren(_values);
    // markNeedsLayout();
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
    final Canvas canvas = context.canvas;

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
    //   Path()..addPath(path, Offset(-1, kStrokeWidth )),
    //   Paint()
    //     ..style = PaintingStyle.stroke
    //     ..strokeWidth = kStrokeWidth
    //     ..color = Colors.black87
    //     ..maskFilter = MaskFilter.blur(BlurStyle.normal, kStrokeWidth)
    //     ..strokeCap = StrokeCap.round,
    // );

    final rect = offset & size;
    canvas.drawPath(
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

      // The Grey Point Circle
      canvas.drawCircle(
          point, kStrokeWidth / 1.6, Paint()..color = yomTheme().accentColor);

      //The Blur Around the Grey Circle
      canvas.drawCircle(
        point,
        kStrokeWidth * 0.7,
        Paint()
          ..color = yomTheme().accentColor
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, kStrokeWidth),
      );

      const valueTextMargin = kStrokeWidth;
      final valueTextRect = Offset(point.dx - kBarWidth / 2,
              point.dy - kLabelHeight - valueTextMargin) &
          Size(kBarWidth, kLabelHeight - valueTextMargin);

      final labelTextPainter = TextPainter(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        textWidthBasis: TextWidthBasis.longestLine,
        text: TextSpan(
            text: '\₹${values[i].toInt()}',
            style: yomTheme().textTheme.headline6),
      )..layout(maxWidth: valueTextRect.size.width);
      labelTextPainter.paint(canvas,
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
