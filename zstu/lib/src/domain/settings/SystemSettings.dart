import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';

class SystemSettings extends BaseSettings {
  bool get isDeviceBlocked => getSettingOrDefault("isDeviceBlocked", false);
  set isDeviceBlocked(bool isDeviceBlocked) =>
      setSetting<bool>("isDeviceBlocked", isDeviceBlocked);

  static const String Type = "System";

  @override
  String get type => SystemSettings.Type;
}
