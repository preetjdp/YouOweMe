import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/IOwe/iOwePageElement.dart';
import 'package:YouOweMe/ui/IOwe/iOwePageEmptyState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:YouOweMe/resources/extensions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class IOwePage extends StatelessWidget {
  final PanelController panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    final List<Seva$Query$User$Owe> iOwe =
        Provider.of<MeNotifier>(context).me.iOwe;

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
                    SliverPadding(
                      padding: EdgeInsets.only(left: 15, top: 15),
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
                  if (iOwe.stateCreated.length > 0) ...[
                    SliverPadding(
                      padding: EdgeInsets.only(left: 15, top: 10),
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
                  if (iOwe.statePaid.length > 0) ...[
                    SliverPadding(
                      padding: EdgeInsets.only(left: 15, top: 10),
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
                    )
                  ]
                ],
              )
            : IOwePageEmptyState());
  }
}
