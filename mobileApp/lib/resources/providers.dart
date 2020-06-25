// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';

final firebaseUserProvider =
    StreamProvider((ref) => FirebaseAuth.instance.onAuthStateChanged);

final meNotifierProvider = ChangeNotifierProvider<MeNotifier>((ref) {
  MeNotifier meNotifier = MeNotifier();
  ref
      .read(firebaseUserProvider)
      .currentData
      .then((value) => meNotifier.onProxyUpdate(value));

  return meNotifier;
});
