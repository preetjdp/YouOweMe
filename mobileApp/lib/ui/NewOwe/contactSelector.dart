import 'package:YouOweMe/ui/Abstractions/yomAvatar.dart';
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactSelector extends StatelessWidget {
  final ScrollController scrollController;
  final ScrollPhysics scrollPhysics = BouncingScrollPhysics();
  ContactSelector({@required this.scrollController});
  void requestContactPermission() {
    Permission.contacts.request();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        controller: scrollController,
        physics: scrollPhysics,
        children: <Widget>[
          Text("Enter a mobile number",
              style: Theme.of(context).textTheme.headline3),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
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
          FutureBuilder(
            future: ContactsService.getContacts(withThumbnails: false),
            builder: (BuildContext context,
                AsyncSnapshot<Iterable<Contact>> snapshot) {
              print(snapshot.data.first.displayName);
              // if (snapshot.connectionState == ConnectionState.waiting)
              // return YOMSpinner();
              return ListView.builder(
                  itemCount: 20,
                  // controller: scrollController,
                  physics: ClampingScrollPhysics(parent: scrollPhysics),
                  addAutomaticKeepAlives: true,
                  cacheExtent: 5000,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Contact contact = snapshot.data.elementAt(index);
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
                                .toList()
                                .sublist(0, 2)
                                .join(),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            contact.displayName,
                            style: Theme.of(context).textTheme.headline3,
                          )
                        ],
                      ),
                    );
                  });

              // return ListView.builder(
              //   itemCount: snapshot.data.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     Contact contact = snapshot.data.elementAt(index);
              //     return Container(
              //         height: 500,
              //         color: Colors.redAccent,
              //         child: Text("HEllo"));
              //   },
              // );
            },
          ),
        ],
      ),
    );
  }
}
