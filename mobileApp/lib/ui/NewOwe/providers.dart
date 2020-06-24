import 'package:contacts_service/contacts_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:state_notifier/state_notifier.dart';

final newOweSlidingPanelControllerProvider = Provider((_) => PanelController());

final newOweSelectedContactProvider =
    StateNotifierProvider((ref) => SelectedContactNotifer());

class SelectedContactNotifer extends StateNotifier<Contact> {
  SelectedContactNotifer() : super(null);

  void setContact(Contact contact) {
    if (contact != state) state = contact;
  }

  void clear() {
    state = null;
  }
}
