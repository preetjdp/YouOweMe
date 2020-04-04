// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'seva.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class Seva$Query$Me$OweMe$IssuedTo with EquatableMixin {
  Seva$Query$Me$OweMe$IssuedTo();

  factory Seva$Query$Me$OweMe$IssuedTo.fromJson(Map<String, dynamic> json) =>
      _$Seva$Query$Me$OweMe$IssuedToFromJson(json);

  String id;

  String name;

  String image;

  @override
  List<Object> get props => [id, name, image];
  Map<String, dynamic> toJson() => _$Seva$Query$Me$OweMe$IssuedToToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Seva$Query$Me$OweMe with EquatableMixin {
  Seva$Query$Me$OweMe();

  factory Seva$Query$Me$OweMe.fromJson(Map<String, dynamic> json) =>
      _$Seva$Query$Me$OweMeFromJson(json);

  String id;

  String title;

  double amount;

  Seva$Query$Me$OweMe$IssuedTo issuedTo;

  @override
  List<Object> get props => [id, title, amount, issuedTo];
  Map<String, dynamic> toJson() => _$Seva$Query$Me$OweMeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Seva$Query$Me$IOwe$IssuedTo with EquatableMixin {
  Seva$Query$Me$IOwe$IssuedTo();

  factory Seva$Query$Me$IOwe$IssuedTo.fromJson(Map<String, dynamic> json) =>
      _$Seva$Query$Me$IOwe$IssuedToFromJson(json);

  String id;

  String name;

  String image;

  @override
  List<Object> get props => [id, name, image];
  Map<String, dynamic> toJson() => _$Seva$Query$Me$IOwe$IssuedToToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Seva$Query$Me$IOwe with EquatableMixin {
  Seva$Query$Me$IOwe();

  factory Seva$Query$Me$IOwe.fromJson(Map<String, dynamic> json) =>
      _$Seva$Query$Me$IOweFromJson(json);

  String id;

  String title;

  double amount;

  Seva$Query$Me$IOwe$IssuedTo issuedTo;

  @override
  List<Object> get props => [id, title, amount, issuedTo];
  Map<String, dynamic> toJson() => _$Seva$Query$Me$IOweToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Seva$Query$Me with EquatableMixin {
  Seva$Query$Me();

  factory Seva$Query$Me.fromJson(Map<String, dynamic> json) =>
      _$Seva$Query$MeFromJson(json);

  String id;

  String name;

  String image;

  int oweMeAmount;

  int iOweAmount;

  List<Seva$Query$Me$OweMe> oweMe;

  List<Seva$Query$Me$IOwe> iOwe;

  @override
  List<Object> get props =>
      [id, name, image, oweMeAmount, iOweAmount, oweMe, iOwe];
  Map<String, dynamic> toJson() => _$Seva$Query$MeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Seva$Query with EquatableMixin {
  Seva$Query();

  factory Seva$Query.fromJson(Map<String, dynamic> json) =>
      _$Seva$QueryFromJson(json);

  Seva$Query$Me Me;

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
