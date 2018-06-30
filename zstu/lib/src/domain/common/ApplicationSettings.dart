import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:zstu/src/domain/common/serialization/ValueSerializerFactory.dart';

class ApplicationSettings extends SettingsBase {
  SystemSettings system;

  @override
  String get type => "General";
}

class SystemSettings extends SettingsBase {
  bool get isDeviceBlocked => getSetting("isDeviceBlocked");
  set isDeviceBlocked(bool isDeviceBlocked) =>
      setSetting("isDeviceBlocked", isDeviceBlocked);

  @override
  String get type => "System";
}

abstract class SettingsBase {
  final Map<String, String> _values = new LinkedHashMap<String, String>();

  String get type;

  @protected
  void setSetting<T>(String key, T value) {
    if (key == null || key.isEmpty || value == null)
      throw new ArgumentError("Null key or value.");

    _values[key] = ValueSerializerFactory.instance
        .getSerializerForType<T>()
        .serialize(value);
  }

  @protected
  T getSetting<T>(String key) {
    if (key == null || key.isEmpty) throw new ArgumentError("Key is null.");

    var rawValue = _values[key];
    if (rawValue?.isEmpty ?? true)
      return null;

    return ValueSerializerFactory.instance
        .getSerializerForType<T>()
        .deserialize(rawValue);
  }

  Map<String, String> getValues() {
    return _values;
  }
}
