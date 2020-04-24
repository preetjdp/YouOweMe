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
  String get shortName => this.name.split(" ").map((e) => e[0]).toList().join();
}

extension MeUtils2 on Seva$Query$User$Owe$User {
  String get shortName => this.name.split(" ").map((e) => e[0]).toList().join();
}

extension ContactUtils on Contact {
  String get shortName =>
      this.displayName.split(" ").map((e) => e[0]).toList().join();
}
