// 🐦 Flutter imports:
import 'package:YouOweMe/ui/Abstractions/yomSpacer.dart';
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:provider/provider.dart';
import 'package:rough/rough.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/IOwe/iOwePageElement.dart';
import 'package:YouOweMe/ui/IOwe/iOwePageEmptyState.dart';
import 'package:YouOweMe/resources/extensions.dart';

class IOwePage extends StatelessWidget {
  final PanelController panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    final List<Seva$Query$User$Owe> iOwe =
        Provider.of<MeNotifier>(context).me.iOwe;

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
        appBar: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.5),
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).accentColor, width: 0.5)),
          middle: Text("I Owe",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.black)),
          actionsForegroundColor: Theme.of(context).accentColor,
        ),
        body: iOwe.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  if (iOwe.stateAcknowledged.length > 0) ...[
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
                                iOwe.stateAcknowledged[index];
                            return IOwePageElement(
                              owe: owe,
                            );
                          },
                          childCount: iOwe.stateAcknowledged.length,
                        ),
                      ),
                    )
                  ],
                  if (iOwe.stateAcknowledged.length > 1)
                    ..._getHandDrawnTotal(iOwe.stateAcknowledged)
                  else
                    SliverYomSpacer(
                      height: 10,
                    ),
                  if (iOwe.stateCreated.length > 0) ...[
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverToBoxAdapter(
                        child: Text("Open",
                            style: Theme.of(context).textTheme.headline5),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            Seva$Query$User$Owe owe = iOwe.stateCreated[index];
                            return IOwePageElement(
                              owe: owe,
                            );
                          },
                          childCount: iOwe.stateCreated.length,
                        ),
                      ),
                    )
                  ],
                  if (iOwe.stateCreated.length > 1)
                    ..._getHandDrawnTotal(iOwe.stateCreated)
                  else
                    SliverYomSpacer(
                      height: 10,
                    ),
                  if (iOwe.statePaid.length > 0) ...[
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
                            Seva$Query$User$Owe owe = iOwe.statePaid[index];
                            return IOwePageElement(
                              owe: owe,
                            );
                          },
                          childCount: iOwe.statePaid.length,
                        ),
                      ),
                    ),
                    if (iOwe.statePaid.length > 1)
                      ..._getHandDrawnTotal(iOwe.statePaid),
                  ],
                  SliverYomSpacer(
                    height: 10,
                  )
                ],
              )
            : IOwePageEmptyState());
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
