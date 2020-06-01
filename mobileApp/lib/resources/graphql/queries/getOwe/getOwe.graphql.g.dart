// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getOwe.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOwe$Query$Owe$User _$GetOwe$Query$Owe$UserFromJson(
    Map<String, dynamic> json) {
  return GetOwe$Query$Owe$User()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..mobileNo = json['mobileNo'] as String
    ..created = fromGraphQLDateTimeToDartDateTime(json['created'] as int);
}

Map<String, dynamic> _$GetOwe$Query$Owe$UserToJson(
        GetOwe$Query$Owe$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'mobileNo': instance.mobileNo,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
    };

GetOwe$Query$Owe _$GetOwe$Query$OweFromJson(Map<String, dynamic> json) {
  return GetOwe$Query$Owe()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..amount = json['amount'] as int
    ..state = _$enumDecodeNullable(_$OweStateEnumMap, json['state'],
        unknownValue: OweState.ARTEMIS_UNKNOWN)
    ..created = fromGraphQLDateTimeToDartDateTime(json['created'] as int)
    ..permalink = json['permalink'] as String
    ..issuedBy = json['issuedBy'] == null
        ? null
        : GetOwe$Query$Owe$User.fromJson(
            json['issuedBy'] as Map<String, dynamic>)
    ..issuedTo = json['issuedTo'] == null
        ? null
        : GetOwe$Query$Owe$User.fromJson(
            json['issuedTo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetOwe$Query$OweToJson(GetOwe$Query$Owe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'amount': instance.amount,
      'state': _$OweStateEnumMap[instance.state],
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
      'permalink': instance.permalink,
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

GetOwe$Query _$GetOwe$QueryFromJson(Map<String, dynamic> json) {
  return GetOwe$Query()
    ..getOwe = json['getOwe'] == null
        ? null
        : GetOwe$Query$Owe.fromJson(json['getOwe'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetOwe$QueryToJson(GetOwe$Query instance) =>
    <String, dynamic>{
      'getOwe': instance.getOwe?.toJson(),
    };

GetOweArguments _$GetOweArgumentsFromJson(Map<String, dynamic> json) {
  return GetOweArguments(
    input: json['input'] as String,
  );
}

Map<String, dynamic> _$GetOweArgumentsToJson(GetOweArguments instance) =>
    <String, dynamic>{
      'input': instance.input,
    };
