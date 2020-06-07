// GENERATED CODE - DO NOT MODIFY BY HAND

// 📦 Package imports:
import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';

// 🌎 Project imports:
import 'package:YouOweMe/resources/graphql/coercers.dart';

part 'getOwe.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class GetOwe$Query$Owe$User with EquatableMixin {
  GetOwe$Query$Owe$User();

  factory GetOwe$Query$Owe$User.fromJson(Map<String, dynamic> json) =>
      _$GetOwe$Query$Owe$UserFromJson(json);

  String id;

  String name;

  String image;

  String mobileNo;

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  DateTime created;

  @override
  List<Object> get props => [id, name, image, mobileNo, created];
  Map<String, dynamic> toJson() => _$GetOwe$Query$Owe$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetOwe$Query$Owe with EquatableMixin {
  GetOwe$Query$Owe();

  factory GetOwe$Query$Owe.fromJson(Map<String, dynamic> json) =>
      _$GetOwe$Query$OweFromJson(json);

  String id;

  String title;

  int amount;

  @JsonKey(unknownEnumValue: OweState.ARTEMIS_UNKNOWN)
  OweState state;

  @JsonKey(
      fromJson: fromGraphQLDateTimeToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  DateTime created;

  String permalink;

  GetOwe$Query$Owe$User issuedBy;

  GetOwe$Query$Owe$User issuedTo;

  @override
  List<Object> get props =>
      [id, title, amount, state, created, permalink, issuedBy, issuedTo];
  Map<String, dynamic> toJson() => _$GetOwe$Query$OweToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetOwe$Query with EquatableMixin {
  GetOwe$Query();

  factory GetOwe$Query.fromJson(Map<String, dynamic> json) =>
      _$GetOwe$QueryFromJson(json);

  GetOwe$Query$Owe getOwe;

  @override
  List<Object> get props => [getOwe];
  Map<String, dynamic> toJson() => _$GetOwe$QueryToJson(this);
}

enum OweState {
  CREATED,
  DECLINED,
  ACKNOWLEDGED,
  PAID,
  ARTEMIS_UNKNOWN,
}

@JsonSerializable(explicitToJson: true)
class GetOweArguments extends JsonSerializable with EquatableMixin {
  GetOweArguments({@required this.input});

  factory GetOweArguments.fromJson(Map<String, dynamic> json) =>
      _$GetOweArgumentsFromJson(json);

  final String input;

  @override
  List<Object> get props => [input];
  Map<String, dynamic> toJson() => _$GetOweArgumentsToJson(this);
}

class GetOweQuery extends GraphQLQuery<GetOwe$Query, GetOweArguments> {
  GetOweQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: null,
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'input')),
              type: NamedTypeNode(
                  name: NameNode(value: 'String'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'getOwe'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'id'),
                    value: VariableNode(name: NameNode(value: 'input')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'title'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'amount'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'state'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'created'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'permalink'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'issuedBy'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'id'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'image'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'mobileNo'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'created'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ])),
                FieldNode(
                    name: NameNode(value: 'issuedTo'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                          name: NameNode(value: 'id'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'name'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'image'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'mobileNo'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null),
                      FieldNode(
                          name: NameNode(value: 'created'),
                          alias: null,
                          arguments: [],
                          directives: [],
                          selectionSet: null)
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'getOwe';

  @override
  final GetOweArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  GetOwe$Query parse(Map<String, dynamic> json) => GetOwe$Query.fromJson(json);
}
