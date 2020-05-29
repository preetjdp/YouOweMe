import 'package:YouOweMe/resources/helpers.dart';
import 'package:flutter/animation.dart';
import 'package:basics/basics.dart';
import './graphql/seva.dart';
import 'package:contacts_service/contacts_service.dart';

extension ListUtils<T> on Iterable<T> {
  num sumBy(num f(T element)) {
    num sum = 0;
    for (var item in this) {
      sum += f(item);
    }
    return sum;
  }
}

extension MeUtils on Seva$Query$User {
  String get shortName =>
      this.name.split(" ").take(2).map((e) => e[0]).toList().join();
}

extension OweUtils on List<Seva$Query$User$Owe> {
  List<Seva$Query$User$Owe> get stateCreated =>
      this.where((element) => element.state == OweState.CREATED).toList();

  List<Seva$Query$User$Owe> fromStates(List<OweState> states) =>
      this.where((element) => states.contains(element.state)).toList();

  List<Seva$Query$User$Owe> get statePaid =>
      this.where((element) => element.state == OweState.PAID).toList();

  List<Seva$Query$User$Owe> get stateAcknowledged =>
      this.where((element) => element.state == OweState.ACKNOWLEDGED).toList();
}

extension DateUtils on DateTime {
  String get simpler {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    const dayNames = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];

    DateTime date = this;
    return "${dayNames[date.weekday]}, ${monthNames[date.month - 1]} the ${date.day}${getDayOfMonthSuffix(date.day)}";
  }
}

extension MeUtils2 on Seva$Query$User$Owe$User {
  String get shortName =>
      this.name.split(" ").take(2).map((e) => e[0]).toList().join();
}

extension ContactUtils on Contact {
  String get shortName =>
      this.displayName.split(" ").take(2).map((e) => e[0]).toList().join();
}

extension AnimationUtils on AnimationController {
  void yomAnimateTo(double target, {Duration duration = Duration.zero}) {
    this.animateTo(target, curve: Curves.easeOutQuart, duration: duration);
  }
}
