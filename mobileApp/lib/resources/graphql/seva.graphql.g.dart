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
    ..image = json['image'] as String
    ..mobileNo = json['mobileNo'] as String
    ..created = fromGraphQLDateTimeToDartDateTime(json['created'] as int);
}

Map<String, dynamic> _$Seva$Query$User$Owe$UserToJson(
        Seva$Query$User$Owe$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'mobileNo': instance.mobileNo,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
    };

Seva$Query$User$Owe _$Seva$Query$User$OweFromJson(Map<String, dynamic> json) {
  return Seva$Query$User$Owe()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..amount = (json['amount'] as num)?.toDouble()
    ..state = _$enumDecodeNullable(_$OweStateEnumMap, json['state'],
        unknownValue: OweState.ARTEMIS_UNKNOWN)
    ..created = fromGraphQLDateTimeToDartDateTime(json['created'] as int)
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
      'state': _$OweStateEnumMap[instance.state],
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
      'issuedBy': instance.issuedBy?.toJson(),
      'issuedTo': instance.issuedTo?.toJson(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$OweStateEnumMap = {
  OweState.CREATED: 'CREATED',
  OweState.DECLINED: 'DECLINED',
  OweState.ACKNOWLEDGED: 'ACKNOWLEDGED',
  OweState.PAID: 'PAID',
  OweState.ARTEMIS_UNKNOWN: 'ARTEMIS_UNKNOWN',
};

Seva$Query$User _$Seva$Query$UserFromJson(Map<String, dynamic> json) {
  return Seva$Query$User()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..oweMeAmount = json['oweMeAmount'] as int
    ..iOweAmount = json['iOweAmount'] as int
    ..mobileNo = json['mobileNo'] as String
    ..created = fromGraphQLDateTimeToDartDateTime(json['created'] as int)
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
      'mobileNo': instance.mobileNo,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
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
