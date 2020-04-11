// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'seva.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Seva$Query$User$Owe$User with EquatableMixin {
  Seva$Query$User$Owe$User();

  factory Seva$Query$User$Owe$User.fromJson(Map<String, dynamic> json) =>
      _$Seva$Query$User$Owe$UserFromJson(json);

  String id;

  String name;

  String image;

  @override
  List<Object> get props => [id, name, image];
  Map<String, dynamic> toJson() => _$Seva$Query$User$Owe$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Seva$Query$User$Owe with EquatableMixin {
  Seva$Query$User$Owe();

  factory Seva$Query$User$Owe.fromJson(Map<String, dynamic> json) =>
      _$Seva$Query$User$OweFromJson(json);

  String id;

  String title;

  double amount;

  Seva$Query$User$Owe$User issuedBy;

  Seva$Query$User$Owe$User issuedTo;

  @override
  List<Object> get props => [id, title, amount, issuedBy, issuedTo];
  Map<String, dynamic> toJson() => _$Seva$Query$User$OweToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Seva$Query$User with EquatableMixin {
  Seva$Query$User();

  factory Seva$Query$User.fromJson(Map<String, dynamic> json) =>
      _$Seva$Query$UserFromJson(json);

  String id;

  String name;

  String image;

  int oweMeAmount;

  int iOweAmount;

  List<Seva$Query$User$Owe> oweMe;

  List<Seva$Query$User$Owe> iOwe;

  @override
  List<Object> get props =>
      [id, name, image, oweMeAmount, iOweAmount, oweMe, iOwe];
  Map<String, dynamic> toJson() => _$Seva$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Seva$Query with EquatableMixin {
  Seva$Query();

  factory Seva$Query.fromJson(Map<String, dynamic> json) =>
      _$Seva$QueryFromJson(json);

  Seva$Query$User Me;

  @override
  List<Object> get props => [Me];
  Map<String, dynamic> toJson() => _$Seva$QueryToJson(this);
}

class SevaQuery extends GraphQLQuery<Seva$Query, JsonSerializable> {
  SevaQuery();

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: null,
        variableDefinitions: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'Me'),
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
                    name: NameNode(value: 'oweMeAmount'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'iOweAmount'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null),
                FieldNode(
                    name: NameNode(value: 'oweMe'),
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
                                selectionSet: null)
                          ]))
                    ])),
                FieldNode(
                    name: NameNode(value: 'iOwe'),
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
                                selectionSet: null)
                          ]))
                    ]))
              ]))
        ]))
  ]);

  @override
  final String operationName = 'seva';

  @override
  List<Object> get props => [document, operationName];
  @override
  Seva$Query parse(Map<String, dynamic> json) => Seva$Query.fromJson(json);
}
