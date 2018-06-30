import 'dart:async';
import 'package:zstu/src/data/Constants.dart';
import 'package:zstu/src/data/common/provider/GeneralStorageProvider.dart';
import 'package:zstu/src/data/settings/SettingsInfo.dart';
import 'package:zstu/src/domain/settings/ISettingsProvider.dart';
import 'package:zstu/src/domain/settings/SettingsBase.dart';

class SettingsProvider implements ISettingsProvider {
  SettingsProvider(this._baseProvider);

  GeneralStorageProvider _baseProvider;

  static String get settingsTableName => Constants.SettingsTableName;

  @override
  Future<SettingsBase> getSettings(String type) {
    return _baseProvider
        .getEntityMap(settingsTableName, type)
        .then((x) => new SettingsInfo.fromMap(x).toSettings());
  }

  @override
  Future saveSettings(SettingsBase settings) {
    return _baseProvider.insertMap(
        settingsTableName, new SettingsInfo.fromSettings(settings).toMap());
  }
}
