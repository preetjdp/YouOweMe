import 'package:hive/hive.dart';

import 'package:YouOweMe/resources/models/user.dart';

part 'owe.g.dart';

@HiveType(typeId: 1)
class Owe {
  @HiveField(0)
  String title;

  @HiveField(1)
  User owedBy;

  //Eventually make this Timestamp
  @HiveField(2)
  DateTime created;

  Owe({this.title, this.owedBy, this.created});
}
