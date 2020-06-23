import 'package:YouOweMe/resources/notifiers/contactProxyNotifier.dart';
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseUserProvider =
    StreamProvider((ref) => FirebaseAuth.instance.onAuthStateChanged);

final meNotifierProvider = ChangeNotifierProvider<MeNotifier>((ref) {
  MeNotifier meNotifier = MeNotifier();
  print("Hello I Guess");
  ref
      .read(firebaseUserProvider)
      .currentData
      .then((value) => meNotifier.onProxyUpdate(value));
  ref.read(firebaseUserProvider).stream.listen((event) {
    print("New Update");
    print(event.uid);
    meNotifier..onProxyUpdate(event);
  });

  return meNotifier;
});

final deviceContactsProvider =
    FutureProvider((_) => ContactsService.getContacts(withThumbnails: false));

final fuzzyContactsChangeNotifierProvider = ChangeNotifierProvider((ref) {
  ContactProxyNotifier contactProxyNotifier = ContactProxyNotifier();
  ref
      .read(deviceContactsProvider)
      .future
      .then((value) => contactProxyNotifier.update(value));

  return contactProxyNotifier;
});
