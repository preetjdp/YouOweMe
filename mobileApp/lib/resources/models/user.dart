import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  //String uid;
  @HiveField(0)
  String name;

  @HiveField(1)
  int amountPeopleOweMe;

  //Eventually make this Timestamp
  @HiveField(2)
  DateTime created;

  User({this.name, this.amountPeopleOweMe, this.created});
}
