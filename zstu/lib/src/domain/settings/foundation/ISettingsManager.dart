import 'dart:async';
import 'package:zstu/src/domain/settings/ApplicationSettings.dart';
import 'BaseSettings.dart';
import 'EditableSetting.dart';

typedef bool SettingsModifier<T extends BaseSettings>(T settings);

abstract class ISettingsManager {
  Future<T> getSettings<T extends BaseSettings>(String type);
  Future saveSettings(BaseSettings settings);
  Future<bool> modifySettings<T extends BaseSettings>(
      FutureOr<T> settingsLoader, SettingsModifier<T> modifier);
  Future<ApplicationSettings> getApplicationSettings();
  Future saveApplicationSettings(ApplicationSettings settings);
  Future<List<EditableSetting>> getEditableSettings();
}
