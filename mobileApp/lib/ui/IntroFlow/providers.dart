import 'package:YouOweMe/resources/providers.dart';
import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final introFlowPageControllerProvider =
    Provider((ref) => PageController(initialPage: 0));

final authValidatorProvider = StreamProvider<bool>((ref) {
  BehaviorSubject<bool> screeningSubject = BehaviorSubject.seeded(false);
  PageController _pageController =
      ref.read(introFlowPageControllerProvider).value;

  _pageController.addListener(() {
    if (_pageController.page == 4) {
      screeningSubject.add(true);
    }
  });

  ref.read(firebaseUserProvider).stream.listen((FirebaseUser user) {
    /// Meaning you are on the first page and
    /// a user is present.
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
