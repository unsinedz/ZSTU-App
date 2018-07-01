import 'dart:async';
import 'package:zstu/src/domain/settings/ApplicationSettings.dart';
import 'package:zstu/src/domain/settings/ISettingsManager.dart';
import 'package:zstu/src/domain/settings/ISettingsProvider.dart';
import 'package:zstu/src/domain/settings/BaseSettings.dart';
import 'package:zstu/src/domain/settings/SystemSettings.dart';

class SettingsManager implements ISettingsManager {
  SettingsManager(this._settingsProvider);

  ISettingsProvider _settingsProvider;

  @override
  Future<BaseSettings> getSettings(String type) {
    return _settingsProvider.getSettings(type);
  }

  Future<Map<String, String>> _getSettingValues(String type) {
    return getSettings(type).then((x) => x.getValues());
  }

  @override
  Future saveSettings(BaseSettings settings) {
    return _settingsProvider.saveSettings(settings);
  }

  @override
  Future<ApplicationSettings> getApplicationSettings() async {
    var applicationSettings = new ApplicationSettings();
    applicationSettings
        .initialize(await _getSettingValues(applicationSettings.type));
    applicationSettings.system = new SystemSettings();
    applicationSettings.system
        .initialize(await _getSettingValues(applicationSettings.system.type));

    return applicationSettings;
  }

  @override
  Future saveApplicationSettings(ApplicationSettings settings) async {
    if (settings == null) throw new ArgumentError('No settings are specified.');

    await _settingsProvider.saveSettings(settings.system);
    await _settingsProvider.saveSettings(settings);
  }
}
