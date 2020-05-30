// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';

class BlurredBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Center(
              child: YOMSpinner(
            brightness: Brightness.dark,
          )),
        ),
      ),
    );
  }
}
