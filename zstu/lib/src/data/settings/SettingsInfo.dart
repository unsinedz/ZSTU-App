import 'package:zstu/src/App.dart';
import 'package:zstu/src/data/common/IPersistableEntity.dart';
import 'package:zstu/src/domain/common/serialization/IValueSerializer.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';

class SettingsInfo implements IPersistableEntity {
  SettingsInfo.fromSettings(this._settings);
  SettingsInfo.fromMap(Map<String, dynamic> map, [String type]) {
    _settings = BaseSettings.newInstance(type);
    var settingValues = map['SettingValues'] as String;
    if (settingValues?.isNotEmpty ?? false) {
      var valueMap = _getMapSerializer().deserialize(settingValues)
          as Map<String, dynamic>;

      _settings.initialize(valueMap.cast<String, String>());
    }
  }

  BaseSettings _settings;

  IValueSerializer _getMapSerializer() {
    return new App()
        .valueSerializers
        .getSerializerForGenericType<Map<String, String>>();
  }

  String get type => _settings.type;

  String get values => _getMapSerializer().serialize(_settings.getValues());

  BaseSettings toSettings() {
    return _settings;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'Id': type,
      'SettingValues': values,
    };
  }
}
