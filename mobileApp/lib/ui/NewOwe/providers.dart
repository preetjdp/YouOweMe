import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final newOweSlidingPanelControllerProvider = Provider((_) => PanelController());

final newOweSelectedContactProvider = Provider((ref) {
  BehaviorSubject selectedContactSubject = BehaviorSubject();

  ref.onDispose(() => selectedContactSubject.close());
  return selectedContactSubject;
});
