// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:contacts_service/contacts_service.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactProxyNotifier extends ChangeNotifier {
  final TextEditingController contactEditingController =
      TextEditingController();
  Iterable<Contact> contacts;
  Iterable<Contact> staticContacts;

  ContactProxyNotifier() {
    contactEditingController.addListener(onTextControllerChanged);
    init();
  }

  void init() async {
    Permission contactPermission = Permission.contacts;
    bool isGranted = await contactPermission.isGranted;
    if (!isGranted) {
      PermissionStatus status = await contactPermission.request();
      if (status.isDenied) {
        return;
      }
    }
    staticContacts = await ContactsService.getContacts(withThumbnails: false);
    contacts = staticContacts;
    notifyListeners();
  }

  void onTextControllerChanged() {
    final fuse = Fuzzy(this.staticContacts.toList(),
        options: FuzzyOptions(verbose: true, keys: [
          WeightedKey<Contact>(
              name: "displayName",
              getter: (contact) => contact.displayName,
              weight: 0.8),
        ]));
    final fuzzySearchResult = fuse.search(this.contactEditingController.text);
    final result = fuzzySearchResult.map((e) => e.item);
    contacts = result;
    notifyListeners();
  }
}
