import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:flutter/material.dart';

class OweMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YOMSpinner(),
      ),
    );
  }
}
