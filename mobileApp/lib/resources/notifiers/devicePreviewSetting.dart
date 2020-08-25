import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:YouOweMe/resources/providers.dart';

final devicePreviewSettingProvider =
    StateNotifierProvider((ref) => DevicePreviewSetting(ref));

class DevicePreviewSetting extends StateNotifier<bool> {
  Preference<bool> value;
  DevicePreviewSetting(ProviderReference ref) : super(false) {
    ref.read(streamingSharedPrefsProvider.future).then((_value) {
      this.value = _value.getBool("show_device_preview", defaultValue: true);
      state = value.getValue();
    });
  }

  void toggle() {
    state = !state;
    value.setValue(state);
  }
}
