import 'package:flutter/material.dart';

import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';

class NewOwe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void onButtonPressed() {
      Navigator.pop(context);
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: onButtonPressed,
      ),
      body: Center(
        child: YOMSpinner()
      ),
    );
  }
}