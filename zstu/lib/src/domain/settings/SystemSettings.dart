import 'package:zstu/src/domain/settings/SettingsBase.dart';

class SystemSettings extends SettingsBase {
  bool get isDeviceBlocked => getSetting("isDeviceBlocked");
  set isDeviceBlocked(bool isDeviceBlocked) =>
      setSetting("isDeviceBlocked", isDeviceBlocked);

  @override
  String get type => "System";
}
