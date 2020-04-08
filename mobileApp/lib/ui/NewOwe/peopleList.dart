import 'package:YouOweMe/ui/Abstractions/expandingWidgetDelegate.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PeopleList extends StatelessWidget {
  List<String> people = ["Preet Parekh", "Tanay Modi", "Elizabeth Cooper"];

  final EdgeInsets margin = EdgeInsets.all(10);
  @override
  Widget build(BuildContext context) {
    // List<Contact> contacts =
    List<Contact> contacts = people
        .map((e) =>
            Contact(displayName: e, phones: [Item(value: "+917123456789")]))
        .toList();
    void selectContact(Contact contact) {
      Provider.of<PanelController>(context, listen: false).close();
      Provider.of<BehaviorSubject<Contact>>(context, listen: false)
          .add(contact);
    }

    void addNewContact() {
      PanelController panelController =
          Provider.of<PanelController>(context, listen: false);
      panelController.open();
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
                    onTap: addNewContact,
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
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            Contact contact = contacts.elementAt(index);
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
                        text: contact.displayName
                            .split(" ")
                            .map((e) => e[0])
                            .toList()
                            .join()),
                    SizedBox(
                      height: 40,
                    ),
                    Text(people.elementAt(index),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3),
                  ],
                ),
              ),
            );
          }, childCount: people.length))
        ],
      ),
    );
  }
}
