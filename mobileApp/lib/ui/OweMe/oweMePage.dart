// 🐦 Flutter imports:
import 'package:YouOweMe/ui/Abstractions/yomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rough/rough.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/providers.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpacer.dart';
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/ui/OweMe/oweMePageElement.dart';
import 'package:YouOweMe/ui/OweMe/oweMePageEmptyState.dart';
import 'package:YouOweMe/resources/extensions.dart';

class OweMePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final List<Seva$Query$User$Owe> oweMe =
        useProvider(meNotifierProvider).me.oweMe;

    List<Widget> _getHandDrawnTotal(List<Seva$Query$User$Owe> owes) {
      return <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          sliver: SliverToBoxAdapter(
            child: CustomPaint(
              size: Size(0, 10),
              painter: HandDrawnLinePainter(width: 100),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Total : ",
                  style: Theme.of(context).textTheme.headline5,
                ),
                Container(
                  constraints: BoxConstraints(minWidth: 65),
                  child: CupertinoButton(
                      color: Theme.of(context).accentColor,
                      minSize: 20,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        owes.total.toString(),
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
        ),
      ];
    }

    return Scaffold(
        appBar: YomAppBar(title: "Owe Me"),
        body: oweMe.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  if (oweMe.stateAcknowledged.length > 0) ...[
                    SliverYomSpacer(
                      height: 10,
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverToBoxAdapter(
                        child: Text("Acknowledged",
                            style: Theme.of(context).textTheme.headline5),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            Seva$Query$User$Owe owe =
                                oweMe.stateAcknowledged[index];
                            return OweMePageElement(
                              owe: owe,
                            );
                          },
                          childCount: oweMe.stateAcknowledged.length,
                        ),
                      ),
                    )
                  ],
                  if (oweMe.stateAcknowledged.length > 1)
                    ..._getHandDrawnTotal(oweMe.stateAcknowledged)
                  else
                    SliverYomSpacer(
                      height: 10,
                    ),
                  if (oweMe.stateCreated.length > 0) ...[
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverToBoxAdapter(
                        child: Text("Still Open",
                            style: Theme.of(context).textTheme.headline5),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            Seva$Query$User$Owe owe = oweMe.stateCreated[index];
                            return OweMePageElement(
                              owe: owe,
                            );
                          },
                          childCount: oweMe.stateCreated.length,
                        ),
                      ),
                    )
                  ],
                  if (oweMe.stateCreated.length > 1)
                    ..._getHandDrawnTotal(oweMe.stateCreated)
                  else
                    SliverYomSpacer(
                      height: 10,
                    ),
                  if (oweMe.statePaid.length > 0) ...[
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverToBoxAdapter(
                        child: Text("Paid",
                            style: Theme.of(context).textTheme.headline5),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            Seva$Query$User$Owe owe = oweMe.statePaid[index];
                            return OweMePageElement(
                              owe: owe,
                            );
                          },
                          childCount: oweMe.statePaid.length,
                        ),
                      ),
                    ),
                    if (oweMe.statePaid.length > 1)
                      ..._getHandDrawnTotal(oweMe.statePaid),
                  ],
                  SliverYomSpacer(
                    height: 10,
                  )
                ],
              )
            : OweMePageEmptyState());
  }
}

class HandDrawnLinePainter extends CustomPainter {
  final double width;
  HandDrawnLinePainter({@required this.width});
  @override
  void paint(Canvas canvas, Size size) {
    YomDesign yomDesign = YomDesign();
    DrawConfig myDrawConfig =
        DrawConfig.build(roughness: 3, maxRandomnessOffset: 3);

    FillerConfig myFillerConfig = FillerConfig.defaultConfig;
    Filler myFiller = NoFiller(myFillerConfig);
    Generator generator = Generator(
      myDrawConfig,
      myFiller,
    );
    Drawable figure = generator.line(size.width - width, 0, size.width, 0);
    canvas.drawRough(
        figure,
        Paint()
          ..color = yomDesign.yomGrey1
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
        Paint()..color = Colors.redAccent);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
