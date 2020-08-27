import 'package:YouOweMe/resources/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

final magnifierSettingProvider =
    StateNotifierProvider((ref) => MagnifierSetting(ref));

class MagnifierSetting extends StateNotifier<bool> {
  Preference<bool> value;
  MagnifierSetting(ProviderReference ref) : super(false) {
    ref.read(streamingSharedPrefsProvider.future).then((_value) {
      this.value = _value.getBool("show_magnifier", defaultValue: false);
      state = value.getValue();
    });
  }

  void toggle() {
    state = !state;
    value.setValue(state);
  }
}