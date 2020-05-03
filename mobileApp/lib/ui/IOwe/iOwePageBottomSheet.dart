import 'package:YouOweMe/ui/Abstractions/yomSpinner.dart';
import 'package:flutter/material.dart';

class IOwePageBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  IOwePageBottomSheet({@required this.scrollController});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: YOMSpinner(),
      ),
    );
  }
}
