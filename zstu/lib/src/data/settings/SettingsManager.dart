import 'dart:async';
import 'package:zstu/src/domain/settings/ApplicationSettings.dart';
import 'package:zstu/src/domain/settings/NotificationSettings.dart';
import 'package:zstu/src/domain/settings/foundation/ISettingListItem.dart';
import 'package:zstu/src/domain/settings/foundation/ISettingsManager.dart';
import 'package:zstu/src/domain/settings/foundation/ISettingsProvider.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/domain/settings/SystemSettings.dart';
import 'package:zstu/src/domain/settings/foundation/SettingListItemsStorage.dart';

class SettingsManager implements ISettingsManager {
  SettingsManager(this._settingsProvider);

  ISettingsProvider _settingsProvider;

  @override
  Future<T> getSettings<T extends BaseSettings>(String type) {
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
  Future<bool> modifySettings<T extends BaseSettings>(
      Future<T> valueProvider, SettingsModifier<T> modifier) async {
    if (valueProvider == null)
      throw new ArgumentError('Value provider is null.');

    if (modifier == null) throw new ArgumentError('Modifier is null.');

    T settings;
    settings = await valueProvider;
    if (settings == null) throw new StateError('Settings instance is null.');

    var modificationResult = modifier(settings);
    if (modificationResult) saveSettings(settings);

    return modificationResult;
  }

  @override
  Future<ApplicationSettings> getApplicationSettings(
      {bool loadInner = false}) async {
    var applicationSettings = new ApplicationSettings();
    applicationSettings
        .initialize(await _getSettingValues(applicationSettings.type));
    if (loadInner) await _fillInnerSettings(applicationSettings);

    return applicationSettings;
  }

  Future _fillInnerSettings(ApplicationSettings applicationSettings) async {
    if (applicationSettings == null)
      throw new ArgumentError('Settings are null.');

    applicationSettings.system = new SystemSettings();
    applicationSettings.notifications = new NotificationSettings();
    var settingValues = await Future.wait([
      _getSettingValues(applicationSettings.system.type),
      _getSettingValues(applicationSettings.notifications.type),
    ]);
    applicationSettings.system.initialize(settingValues[0]);
    applicationSettings.notifications.initialize(settingValues[1]);
  }

  @override
  Future saveApplicationSettings(ApplicationSettings settings) {
    if (settings == null) throw new ArgumentError('No settings are specified.');

    return Future.wait([
      _settingsProvider.saveSettings(settings),
      _saveInnerSettings(settings),
    ]);
  }

  Future _saveInnerSettings(ApplicationSettings applicationSettings) {
    if (applicationSettings == null)
      throw new ArgumentError('Settings are null.');

    return Future.wait([
      _settingsProvider.saveSettings(applicationSettings.system),
      _settingsProvider.saveSettings(applicationSettings.notifications),
    ]);
  }

  @override
  Future<List<ISettingListItem>> getSettingListItems() {
    return new Future.value(SettingListItemsStorage.instance.getItems());
  }
}
