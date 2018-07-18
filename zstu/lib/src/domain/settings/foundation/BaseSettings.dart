import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:zstu/src/domain/Constants.dart';
import 'package:zstu/src/domain/common/serialization/ValueSerializerFactory.dart';

abstract class BaseSettings {
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

  T getSetting<T>(String key) {
    if (key == null || key.isEmpty) throw new ArgumentError("Key is null.");

    var rawValue = _values[key];
    if (rawValue?.isEmpty ?? true) return null;

    return ValueSerializerFactory.instance
        .getSerializerForType<T>()
        .deserialize(rawValue);
  }

  T getSettingOrDefault<T>(String key, [T defaultValue]) {
    return getSetting(key) ?? defaultValue;
  }

  static BaseSettings newInstance() {
    return new _Settings();
  }

  void initialize(Map<String, String> values) {
    if (values == null) throw new ArgumentError("Values are null.");

    _values.clear();
    _values.addAll(values);
  }

  Map<String, String> getValues() {
    return _values;
  }

  static String makeSettingKey(String name, {String type}) {
    return '${Constants.localizationKeyPrefixes.setting}' +
        (type?.isEmpty ?? true ? '' : '${type}_') +
        name;
  }
}

class _Settings extends BaseSettings {
  @override
  String get type => null;
}
