// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/notifiers/meNotifier.dart';
import 'package:package_info/package_info.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

final firebaseUserProvider =
    StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());

final meNotifierProvider = ChangeNotifierProvider<MeNotifier>((ref) {
  MeNotifier meNotifier = MeNotifier();
  ref
      .read(firebaseUserProvider)
      .whenData((value) => meNotifier.onProxyUpdate(value));

  return meNotifier;
});

final packageInfoProvider = FutureProvider((ref) => PackageInfo.fromPlatform());

final streamingSharedPrefsProvider =
    FutureProvider((ref) => StreamingSharedPreferences.instance);
