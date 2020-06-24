import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
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
