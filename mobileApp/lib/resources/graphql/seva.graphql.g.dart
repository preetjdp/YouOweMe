// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seva.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seva$Query$Me$OweMe$IssuedTo _$Seva$Query$Me$OweMe$IssuedToFromJson(
    Map<String, dynamic> json) {
  return Seva$Query$Me$OweMe$IssuedTo()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..image = json['image'] as String;
}

Map<String, dynamic> _$Seva$Query$Me$OweMe$IssuedToToJson(
        Seva$Query$Me$OweMe$IssuedTo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

Seva$Query$Me$OweMe _$Seva$Query$Me$OweMeFromJson(Map<String, dynamic> json) {
  return Seva$Query$Me$OweMe()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..amount = (json['amount'] as num)?.toDouble()
    ..issuedTo = json['issuedTo'] == null
        ? null
        : Seva$Query$Me$OweMe$IssuedTo.fromJson(
            json['issuedTo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Seva$Query$Me$OweMeToJson(
        Seva$Query$Me$OweMe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'amount': instance.amount,
      'issuedTo': instance.issuedTo?.toJson(),
    };

Seva$Query$Me$IOwe$IssuedTo _$Seva$Query$Me$IOwe$IssuedToFromJson(
    Map<String, dynamic> json) {
  return Seva$Query$Me$IOwe$IssuedTo()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..image = json['image'] as String;
}

Map<String, dynamic> _$Seva$Query$Me$IOwe$IssuedToToJson(
        Seva$Query$Me$IOwe$IssuedTo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

Seva$Query$Me$IOwe _$Seva$Query$Me$IOweFromJson(Map<String, dynamic> json) {
  return Seva$Query$Me$IOwe()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..amount = (json['amount'] as num)?.toDouble()
    ..issuedTo = json['issuedTo'] == null
        ? null
        : Seva$Query$Me$IOwe$IssuedTo.fromJson(
            json['issuedTo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Seva$Query$Me$IOweToJson(Seva$Query$Me$IOwe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'amount': instance.amount,
      'issuedTo': instance.issuedTo?.toJson(),
    };

Seva$Query$Me _$Seva$Query$MeFromJson(Map<String, dynamic> json) {
  return Seva$Query$Me()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..oweMeAmount = json['oweMeAmount'] as int
    ..iOweAmount = json['iOweAmount'] as int
    ..oweMe = (json['oweMe'] as List)
        ?.map((e) => e == null
            ? null
            : Seva$Query$Me$OweMe.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..iOwe = (json['iOwe'] as List)
        ?.map((e) => e == null
            ? null
            : Seva$Query$Me$IOwe.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$Seva$Query$MeToJson(Seva$Query$Me instance) =>
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
        : Seva$Query$Me.fromJson(json['Me'] as Map<String, dynamic>);
}

Map<String, dynamic> _$Seva$QueryToJson(Seva$Query instance) =>
    <String, dynamic>{
      'Me': instance.Me?.toJson(),
    };
