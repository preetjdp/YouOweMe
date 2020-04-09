import 'dart:async';

import 'package:YouOweMe/resources/notifiers/contactProxyNotifier.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ContactSelector extends StatefulWidget {
  final ScrollController scrollController;

  ContactSelector({@required this.scrollController});

  @override
  _ContactSelectorState createState() => _ContactSelectorState();
}

class _ContactSelectorState extends State<ContactSelector> {
  final ScrollPhysics scrollPhysics = BouncingScrollPhysics();
  final TextEditingController mobileNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void selectContact(Contact contact) {
      Provider.of<PanelController>(context, listen: false).close();
      Provider.of<BehaviorSubject<Contact>>(context, listen: false)
          .add(contact);
    }

    void onMobileNumberTextFieldSubmit() {
      Contact contact =
          Contact(phones: [Item(value: "+91" + mobileNoController.text)]);
      selectContact(contact);
    }

    return ListView(
      controller: widget.scrollController,
      physics: scrollPhysics,
      children: <Widget>[
        Text("Enter a mobile number",
            style: Theme.of(context).textTheme.headline3),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "+91",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).accentColor),
            ),
            Expanded(
              child: TextField(
                  cursorColor: Theme.of(context).accentColor,
                  onSubmitted: (a) => onMobileNumberTextFieldSubmit,
                  controller: mobileNoController,
                  decoration: InputDecoration(
                    hintText: "00",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(0),
                  ),
                  style: TextStyle(
                      fontSize: 50, color: Theme.of(context).accentColor),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false)),
            ),
            CupertinoButton(
                color: Theme.of(context).accentColor,
                minSize: 20,
                padding: EdgeInsets.all(10),
                child: Icon(CupertinoIcons.check_mark_circled),
                onPressed: onMobileNumberTextFieldSubmit)
          ],
        ),
        Center(
          child: Text(
            "or".toUpperCase(),
            style: TextStyle(
                fontSize: 28,
                color: Theme.of(context).accentColor.withOpacity(0.4),
                // letterSpacing: 10,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Select Contact From Device",
            style: Theme.of(context).textTheme.headline3),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Container(
            height: 40,
            constraints: BoxConstraints(maxWidth: 350),
            child: TextField(
              textInputAction: TextInputAction.search,
              controller: Provider.of<ContactProxyNotifier>(context)
                  .contactEditingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5)),
                hintText: "Search In Contacts",
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
                prefixIcon: GestureDetector(
                    child: Icon(
                  Icons.search,
                  color: Theme.of(context).accentColor,
                )),
              ),
            ),
          ),
        ),
        ContactsList()
      ],
    );
  }
}

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void selectContact(Contact contact) {
      Provider.of<PanelController>(context, listen: false).close();
      Provider.of<BehaviorSubject<Contact>>(context, listen: false)
          .add(contact);
    }

    return ListView.builder(
        itemCount: Provider.of<ContactProxyNotifier>(context)
            .contacts
            .length
            .clamp(0, 20),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Contact contact = Provider.of<ContactProxyNotifier>(context)
              .contacts
              .elementAt(index);
          return Container(
            margin: EdgeInsets.only(top: 10),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                YomAvatar(
                  text: contact.displayName
                      .split(" ")
                      .map((e) => e[0])
                      .take(2)
                      .join(),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  contact.displayName,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Expanded(
                  child: Container(),
                ),
                CupertinoButton(
                    color: Theme.of(context).accentColor,
                    minSize: 20,
                    padding: EdgeInsets.all(10),
                    child: Icon(CupertinoIcons.check_mark_circled),
                    onPressed: () => selectContact(contact))
              ],
            ),
          );
        });
  }
}
