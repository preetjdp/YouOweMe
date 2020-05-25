import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:YouOweMe/ui/OweMe/oweMePageElement.dart';
import 'package:YouOweMe/ui/OweMe/oweMePageEmptyState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:YouOweMe/resources/extensions.dart';

class OweMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Seva$Query$User$Owe> oweMe =
        Provider.of<MeNotifier>(context).me.oweMe;

    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.5),
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).accentColor, width: 0.5)),
          middle: Text("Owe Me",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.black)),
          actionsForegroundColor: Theme.of(context).accentColor,
        ),
        body: oweMe.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  if (oweMe.stateAcknowledged.length > 0) ...[
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
                  if (oweMe.stateCreated.length > 0) ...[
                    SliverPadding(
                      padding: EdgeInsets.only(left: 15, top: 10),
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
                  if (oweMe.statePaid.length > 0) ...[
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
                            Seva$Query$User$Owe owe = oweMe.statePaid[index];
                            return OweMePageElement(
                              owe: owe,
                            );
                          },
                          childCount: oweMe.statePaid.length,
                        ),
                      ),
                    )
                  ]
                ],
              )
            : OweMePageEmptyState());
  }
}
