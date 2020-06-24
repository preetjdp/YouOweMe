// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/providers.dart';
import 'package:YouOweMe/ui/NewOwe/providers.dart';
import 'package:YouOweMe/resources/graphql/seva.dart';
import 'package:YouOweMe/ui/Abstractions/expandingWidgetDelegate.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/resources/extensions.dart';

class PeopleList extends HookWidget {
  final EdgeInsets margin = EdgeInsets.all(10);
  @override
  Widget build(BuildContext context) {
    final Seva$Query$User me = useProvider(meNotifierProvider).me;
    final PanelController slidingPanelController =
        useProvider(newOweSlidingPanelControllerProvider);
    final selectedContactProvider = useProvider(newOweSelectedContactProvider);

    void selectContact(Contact contact) {
      slidingPanelController.close();
      selectedContactProvider.setContact(contact);
    }

    void openContactSelector() {
      slidingPanelController.open();
    }

    return Container(
      height: 200,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: ExpandingWidgetDelegate(
                  maxWidth: 120,
                  minWidth: 80,
                  child: GestureDetector(
                    onTap: openContactSelector,
                    child: Container(
                      margin: margin.copyWith(left: 0),
                      width: 80,
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Color.fromRGBO(78, 80, 88, 0.05),
                                spreadRadius: 0.1)
                          ]),
                      child: Center(
                          child: Icon(
                        Icons.add,
                        size: 38,
                        color: Colors.white,
                      )),
                    ),
                  ))),
          if (me.oweMe.length > 0)
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              // Contact contact = contacts.elementAt(index);
              Seva$Query$User$Owe$User user =
                  me.oweMe.elementAt(index).issuedTo;
              Contact contact = Contact(
                  displayName: user.name, phones: [Item(value: user.mobileNo)]);
              return GestureDetector(
                onTap: () => selectContact(contact),
                child: Container(
                  margin: margin.copyWith(left: 0),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Color.fromRGBO(78, 80, 88, 0.05),
                            spreadRadius: 0.1)
                      ]),
                  child: Column(
                    children: <Widget>[
                      YomAvatar(
                          // Returns "PP" for "Preet Parekh"
                          text: contact.shortName),
                      SizedBox(
                        height: 40,
                      ),
                      Text(user.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5),
                    ],
                  ),
                ),
              );
            }, childCount: me.oweMe.length))
          else
            PeopleListEmptyState()
        ],
      ),
    );
  }
}

class PeopleListEmptyState extends StatelessWidget {
  final EdgeInsets margin = EdgeInsets.all(10);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: margin.copyWith(left: 0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: Color.fromRGBO(78, 80, 88, 0.05),
                  spreadRadius: 0.1)
            ]),
        child: Row(
          children: [
            Image.asset('assets/scribbles/karlsson_no_connection.png'),
            Text(
              """"You'll See Recent\nContacts Here" """,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontStyle: FontStyle.italic),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
