import 'package:flutter/material.dart';

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
        child: Text('This is the wow')
      ),
    );
  }
}