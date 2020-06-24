// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:basics/basics.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/Abstractions/yomButton.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpacer.dart';
import 'package:YouOweMe/ui/NewOwe/providers.dart';
import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/resources/extensions.dart';

class ContactSelector extends StatefulHookWidget {
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
    final PanelController slidingPanelController =
        useProvider(newOweSlidingPanelControllerProvider);
    final selectedContactProvider = useProvider(newOweSelectedContactProvider);
    final contactsNotifier = useProvider(contactsChangeNotifierProvider);

    void selectContact(Contact contact) {
      slidingPanelController.close();
      selectedContactProvider.setContact(contact);
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
              style: Theme.of(context).textTheme.headline5),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "+91",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: Theme.of(context).accentColor),
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
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).accentColor),
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
          if (contactsNotifier.contacts.isNotNull) ...[
            Text("Select Contact From Device",
                style: Theme.of(context).textTheme.headline5),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 40,
                child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: contactsNotifier.contactEditingController,
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
          ] else
            ContactListEmptyState()
        ]);
  }
}

class ContactsList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final PanelController slidingPanelController =
        useProvider(newOweSlidingPanelControllerProvider);
    final selectedContactProvider = useProvider(newOweSelectedContactProvider);
    final contactsNotifier = useProvider(contactsChangeNotifierProvider);

    void selectContact(Contact contact) {
      slidingPanelController.close();
      selectedContactProvider.setContact(contact);
    }

    return ListView.builder(
        itemCount: contactsNotifier.contacts.length.clamp(0, 20),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Contact contact = contactsNotifier.contacts.elementAt(index);
          return Container(
            margin: EdgeInsets.only(top: 10),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                YomAvatar(
                  text: contact.shortName,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    contact.displayName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(
                  width: 10,
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

class ContactListEmptyState extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final contactsNotifier = useProvider(contactsChangeNotifierProvider);

    return Column(
      children: [
        YomSpacer(
          height: 10,
        ),
        Container(
          height: 60,
          width: 400,
          child: YomButton(
            child: Text("Read Contacts"),
            onPressed: () => contactsNotifier.init(),
          ),
        ),
        Image.asset("assets/scribbles/karlsson_contact_page.png"),
      ],
    );
  }
}
