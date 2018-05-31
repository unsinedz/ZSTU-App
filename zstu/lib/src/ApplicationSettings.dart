import 'dart:collection';

class ApplicationSettings extends _SettingsBase {
  SystemSettings get system => getSetting("system");
  set system(SystemSettings system) => setSetting("system", system);
}

class SystemSettings extends _SettingsBase {
  bool get isDeviceBlocked => getSetting("isDeviceBlocked");
  set isDeviceBlocked(bool isDeviceBlocked) =>
      setSetting("isDeviceBlocked", isDeviceBlocked);
}

abstract class _SettingsBase {
  Map<String, dynamic> _values = new LinkedHashMap<String, dynamic>();

  void setSetting(String key, dynamic value) {
    if (key == null || key.isEmpty || value == null)
      throw new ArgumentError("Null key or value.");

    _values[key] = value;
  }

  T getSetting<T>(String key) {
    if (key == null || key.isEmpty) throw new ArgumentError("Key is null.");

    return _values[key];
  }
}
