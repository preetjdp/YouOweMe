// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seva.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seva$Query$User _$Seva$Query$UserFromJson(Map<String, dynamic> json) {
  return Seva$Query$User()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..oweMeAmount = json['oweMeAmount'] as int
    ..iOweAmount = json['iOweAmount'] as int;
}

Map<String, dynamic> _$Seva$Query$UserToJson(Seva$Query$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'oweMeAmount': instance.oweMeAmount,
      'iOweAmount': instance.iOweAmount,
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
