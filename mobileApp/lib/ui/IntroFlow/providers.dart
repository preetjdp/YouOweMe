// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/providers.dart';
import 'package:YouOweMe/ui/IntroFlow/loginUser.dart';

const int pages = 5;

final introFlowPageControllerProvider =
    Provider((ref) => PageController(initialPage: 0));

final authValidatorProvider = StreamProvider<bool>((ref) {
  BehaviorSubject<bool> screeningSubject = BehaviorSubject();
  PageController _pageController = ref.read(introFlowPageControllerProvider);

  _pageController.addListener(() {
    if (_pageController.hasClients && _pageController.page == pages) {
      screeningSubject.add(true);
    }
  });

  //TODO This should be watch and that is causing breaks in
  //in the intro flow and thats not right!
  //try aagain with newer version of riverpod.
  ref.watch(firebaseUserProvider.stream).listen((user) {
    // print("User is $user and PageC is ${_pageController.page}");
    if (user != null &&
        _pageController.hasClients &&
        _pageController.page == 0) {
      screeningSubject.add(true);
    } else {
      screeningSubject.add(false);
    }
  });

  ref.onDispose(() {
    //TODO Consider opening this up in the Future.
    // screeningSubject.close();
  });

  return screeningSubject;
});

final introFlowUserProvider = Provider((ref) => LoginUser());
