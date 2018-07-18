import 'dart:async';
import 'package:zstu/src/domain/settings/ApplicationSettings.dart';
import 'package:zstu/src/domain/settings/foundation/EditableSetting.dart';
import 'package:zstu/src/domain/settings/foundation/IHasEditableSettings.dart';
import 'package:zstu/src/domain/settings/foundation/ISettingsManager.dart';
import 'package:zstu/src/domain/settings/foundation/ISettingsProvider.dart';
import 'package:zstu/src/domain/settings/foundation/BaseSettings.dart';
import 'package:zstu/src/domain/settings/SystemSettings.dart';

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
      FutureOr<T> valueProvider, SettingsModifier<T> modifier) async {
    if (valueProvider == null) throw new ArgumentError('Value provider is null.');
    if (modifier == null) throw new ArgumentError('Modifier is null.');

    T settings;
    if (valueProvider is Future<T>)
      settings = await valueProvider;
    else
      settings = valueProvider;

    if (settings == null) throw new StateError('Settings instance is null.');

    var modificationResult = modifier(settings);
    if (modificationResult) saveSettings(settings);

    return modificationResult;
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

  @override
  Future<List<EditableSetting>> getEditableSettings() async {
    var result = <EditableSetting>[];
    var editableSettingContainers = <IHasEditableSettings>[
      await getApplicationSettings(),
    ];
    editableSettingContainers
        .forEach((x) => result.addAll(x.getEditableSettings()));
    return result;
  }
}
