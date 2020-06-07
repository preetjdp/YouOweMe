// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/notifiers/contactProxyNotifier.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';

List<SingleChildWidget> yomProviders = [
  StreamProvider<FirebaseUser>.value(
      value: FirebaseAuth.instance.onAuthStateChanged),
  ChangeNotifierProxyProvider<FirebaseUser, MeNotifier>(
    create: (BuildContext context) => MeNotifier(context),
    update: (context, firebaseUser, meNotifier) =>
        meNotifier..onProxyUpdate(firebaseUser),
    lazy: false,
  ),
  FutureProvider<Iterable<Contact>>(
    create: (a) => ContactsService.getContacts(withThumbnails: false),
    lazy: false,
    initialData: [],
  ),
  ChangeNotifierProxyProvider<Iterable<Contact>, ContactProxyNotifier>(
    create: (BuildContext context) => ContactProxyNotifier(),
    update: (BuildContext context, a, b) => b..update(a),
    lazy: false,
  )
];
