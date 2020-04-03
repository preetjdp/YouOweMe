import 'package:YouOweMe/resources/models/user.dart';

class Owe {
  String title;

  String owedBy;

  int amount;

  DateTime created;

  Owe({this.title, this.amount, this.created});
}
