import 'package:hive/hive.dart';

import 'package:YouOweMe/resources/models/user.dart';

part 'owe.g.dart';

@HiveType(typeId: 1)
class Owe {
  @HiveField(0)
  String title;

  @HiveField(1)
  String owedBy;

  @HiveField(2)
  int amount;

  //Eventually make this Timestamp
  @HiveField(3)
  DateTime created;

  Owe({this.title, this.amount, this.created});
}
