import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'package:YouOweMe/resources/models/owe.dart';

class DatabaseService {
  void addOweToHive({@required Owe owe}) {
    Box<Owe> oweBox = Hive.box("oweBox");
    if (oweBox.isOpen) {
      oweBox.add(owe);
    } else {
      print("Box is not open");
    }
  }
}
