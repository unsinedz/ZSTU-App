import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:zstu/src/domain/Constants.dart';
import 'package:zstu/src/domain/common/serialization/ValueSerializerFactory.dart';

abstract class BaseSettings {
  final Map<String, String> _values = new LinkedHashMap<String, String>();

  String get type;

  @protected
  void setTypedSetting<T>(String key, T value) {
    setSetting(key, value, T);
  }

  void setSetting(String key, dynamic value, Type valueType) {
    if (key == null || key.isEmpty || value == null)
      throw new ArgumentError("Null key or value.");

    _values[key] = ValueSerializerFactory.instance
        .getSerializerForType(valueType)
        .serialize(value);
  }

  @protected
  T getTypedSetting<T>(String key) {
    return getSetting(key, T) as T;
  }

  dynamic getSetting(String key, Type type) {
    if (key == null || key.isEmpty) throw new ArgumentError("Key is null.");

    var rawValue = _values[key];
    if (rawValue?.isEmpty ?? true) return null;

    return ValueSerializerFactory.instance
        .getSerializerForType(type)
        .deserialize(rawValue);
  }

  T getSettingOrDefault<T>(String key, [T defaultValue]) {
    return getTypedSetting(key) ?? defaultValue;
  }

  static BaseSettings newInstance([String type]) {
    return new _Settings(type);
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
  _Settings(this._type);

  String _type;

  @override
  String get type => _type;
}
