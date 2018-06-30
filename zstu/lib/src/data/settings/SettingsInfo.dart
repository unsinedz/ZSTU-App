import 'package:zstu/src/App.dart';
import 'package:zstu/src/data/common/IPersistableEntity.dart';
import 'package:zstu/src/domain/common/serialization/IValueSerializer.dart';
import 'package:zstu/src/domain/settings/SettingsBase.dart';

class SettingsInfo implements IPersistableEntity {
  SettingsInfo.fromSettings(this._settings);
  SettingsInfo.fromMap(Map<String, dynamic> map) {
    _settings = SettingsBase.newInstance();
    _settings.initialize(_getMapSerializer().deserialize(map['Values']));
  }

  SettingsBase _settings;

  IValueSerializer _getMapSerializer() {
    return new App()
        .valueSerializers
        .getSerializerForType<Map<String, String>>();
  }

  String get type => _settings.type;

  String get values => _getMapSerializer().serialize(values);

  SettingsBase toSettings() {
    return _settings;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'Id': type,
      'Values': values,
    };
  }
}
