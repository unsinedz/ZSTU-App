import 'dart:async';
import 'package:zstu/src/domain/Constants.dart';
import 'package:zstu/src/data/common/provider/GeneralStorageProvider.dart';
import 'package:zstu/src/data/settings/SettingsInfo.dart';
import 'package:zstu/src/domain/settings/ISettingsProvider.dart';
import 'package:zstu/src/domain/settings/BaseSettings.dart';

class SettingsProvider implements ISettingsProvider {
  SettingsProvider(this._baseProvider);

  GeneralStorageProvider _baseProvider;

  static String get settingsTableName => Constants.SettingsTableName;

  @override
  Future<BaseSettings> getSettings(String type) {
    return _baseProvider.getEntityMap(settingsTableName, type).then(
        (x) => new SettingsInfo.fromMap(x ?? <String, dynamic>{}).toSettings());
  }

  @override
  Future saveSettings(BaseSettings settings) {
    return _baseProvider.insertMap(
        settingsTableName, new SettingsInfo.fromSettings(settings).toMap());
  }
}
