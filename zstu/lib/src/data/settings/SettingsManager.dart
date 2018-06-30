import 'dart:async';
import 'package:zstu/src/domain/settings/ISettingsManager.dart';
import 'package:zstu/src/domain/settings/ISettingsProvider.dart';
import 'package:zstu/src/domain/settings/SettingsBase.dart';

class SettingsManager implements ISettingsManager {
  SettingsManager(this._settingsProvider);

  ISettingsProvider _settingsProvider;

  @override
  Future<SettingsBase> getSettings(String type) {
    return _settingsProvider.getSettings(type);
  }

  @override
  Future saveSettings(SettingsBase settings) {
    return _settingsProvider.saveSettings(settings);
  }
}
