// 🐦 Flutter imports:
import 'package:YouOweMe/resources/constants.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:contacts_service/contacts_service.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/Abstractions/yomTheme.dart';
import 'package:YouOweMe/resources/helpers.dart';
import './graphql/seva.dart';

extension MeUtils on Seva$Query$User {
  /// Get the `User`'s short name. Two Lettered.
  String get shortName =>
      this.name.split(" ").take(2).map((e) => e[0]).toList().join();
}

extension MeUtils2 on Seva$Query$User$Owe$User {
  String get shortName =>
      this.name.split(" ").take(2).map((e) => e[0]).toList().join();
}

extension YomContext on BuildContext {
  /// This returns the `YomDesign` which can be used
  /// anywhere for symmetric styles.
  YomDesign get yomDesign => YomDesign();
}

extension OweUtils on List<Seva$Query$User$Owe> {
  /// Get all the `Owe`'s which have just been CREATED.
  List<Seva$Query$User$Owe> get stateCreated =>
      this.where((element) => element.state == OweState.CREATED).toList();

  /// Get all the `Owe`'s which have just been PAID.
  List<Seva$Query$User$Owe> get statePaid =>
      this.where((element) => element.state == OweState.PAID).toList();

  /// Get all the `Owe`'s which have just been ACKNOWLEDGED.
  List<Seva$Query$User$Owe> get stateAcknowledged =>
      this.where((element) => element.state == OweState.ACKNOWLEDGED).toList();

  /// Get all the `Owe`'s by pasing the States.
  List<Seva$Query$User$Owe> fromStates(List<OweState> states) =>
      this.where((element) => states.contains(element.state)).toList();

  /// Get the total expenses from the List of `Owe`'s.
  int get total =>
      this.map((e) => e.amount).reduce((value, element) => value + element);
}

extension DateUtils on DateTime {
  /// Get a simpler human readable version of the date.
  String get simpler {
    DateTime date = this;
    return "${dayNames[date.weekday]}, ${monthNames[date.month - 1]} the ${date.day}${getDayOfMonthSuffix(date.day)}";
  }
}

extension ContactUtils on Contact {
  /// Get the Contact User's short name.
  String get shortName =>
      this.displayName.split(" ").take(2).map((e) => e[0]).toList().join();
}

extension ItemUtils on Item {
  String get serializedValue => serializePhoneNumber(this.value);
}
