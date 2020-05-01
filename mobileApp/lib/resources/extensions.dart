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

  List<Seva$Query$User$Owe> get statePaid =>
      this.where((element) => element.state == OweState.PAID).toList();

  List<Seva$Query$User$Owe> get stateAcknowledged =>
      this.where((element) => element.state == OweState.ACKNOWLEDGED).toList();
}

extension MeUtils2 on Seva$Query$User$Owe$User {
  String get shortName =>
      this.name.split(" ").take(2).map((e) => e[0]).toList().join();
}

extension ContactUtils on Contact {
  String get shortName =>
      this.displayName.split(" ").take(2).map((e) => e[0]).toList().join();
}
