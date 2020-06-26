import 'package:YouOweMe/ui/Abstractions/jiggle.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homePageScrollControllerProvder = Provider((ref) => ScrollController());

final homePageJiggleControllerProvider = Provider((ref) => JiggleController());
