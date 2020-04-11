// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seva.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seva$Query$User$Owe$User _$Seva$Query$User$Owe$UserFromJson(
    Map<String, dynamic> json) {
  return Seva$Query$User$Owe$User()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..image = json['image'] as String;
}

Map<String, dynamic> _$Seva$Query$User$Owe$UserToJson(
        Seva$Query$User$Owe$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

Seva$Query$User$Owe _$Seva$Query$User$OweFromJson(Map<String, dynamic> json) {
  return Seva$Query$User$Owe()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..amount = (json['amount'] as num)?.toDouble()
    ..issuedBy = json['issuedBy'] == null
        ? null
        : Seva$Query$User$Owe$User.fromJson(
            json['issuedBy'] as Map<String, dynamic>)
    ..issuedTo = json['issuedTo'] == null
        ? null
        : Seva$Query$User$Owe$User.fromJson(
            json['issuedTo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Seva$Query$User$OweToJson(
        Seva$Query$User$Owe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'amount': instance.amount,
      'issuedBy': instance.issuedBy?.toJson(),
      'issuedTo': instance.issuedTo?.toJson(),
    };

Seva$Query$User _$Seva$Query$UserFromJson(Map<String, dynamic> json) {
  return Seva$Query$User()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..oweMeAmount = json['oweMeAmount'] as int
    ..iOweAmount = json['iOweAmount'] as int
    ..oweMe = (json['oweMe'] as List)
        ?.map((e) => e == null
            ? null
            : Seva$Query$User$Owe.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..iOwe = (json['iOwe'] as List)
        ?.map((e) => e == null
            ? null
            : Seva$Query$User$Owe.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$Seva$Query$UserToJson(Seva$Query$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'oweMeAmount': instance.oweMeAmount,
      'iOweAmount': instance.iOweAmount,
      'oweMe': instance.oweMe?.map((e) => e?.toJson())?.toList(),
      'iOwe': instance.iOwe?.map((e) => e?.toJson())?.toList(),
    };

Seva$Query _$Seva$QueryFromJson(Map<String, dynamic> json) {
  return Seva$Query()
    ..Me = json['Me'] == null
        ? null
        : Seva$Query$User.fromJson(json['Me'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Seva$QueryToJson(Seva$Query instance) =>
    <String, dynamic>{
      'Me': instance.Me?.toJson(),
    };
