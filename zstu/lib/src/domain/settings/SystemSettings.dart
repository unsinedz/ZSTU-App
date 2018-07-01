import 'package:zstu/src/domain/settings/BaseSettings.dart';

class SystemSettings extends BaseSettings {
  bool get isDeviceBlocked => getSetting("isDeviceBlocked");
  set isDeviceBlocked(bool isDeviceBlocked) =>
      setSetting("isDeviceBlocked", isDeviceBlocked);

  static const String Type = "System";

  @override
  String get type => SystemSettings.Type;
}
