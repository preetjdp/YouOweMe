// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/providers.dart';
import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';

final introFlowPageControllerProvider =
    Provider((ref) => PageController(initialPage: 0));

final authValidatorProvider = StreamProvider<bool>((ref) {
  BehaviorSubject<bool> screeningSubject = BehaviorSubject.seeded(false);
  PageController _pageController = ref.read(introFlowPageControllerProvider);

  _pageController.addListener(() {
    if (_pageController.page == 4) {
      screeningSubject.add(true);
    }
  });

  ref.read(firebaseUserProvider).whenData((user) {
    if (user != null && _pageController.page == 0) {
      screeningSubject.add(true);
    } else {
      screeningSubject.add(false);
    }
  });

  ref.onDispose(() => screeningSubject.close());

  return screeningSubject.stream;
});

final introFlowUserProvider = Provider((ref) => LoginUser());
