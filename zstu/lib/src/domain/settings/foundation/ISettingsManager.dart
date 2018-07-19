import 'dart:async';
import 'package:zstu/src/domain/settings/ApplicationSettings.dart';
import 'package:zstu/src/domain/settings/foundation/ISettingListItem.dart';
import 'BaseSettings.dart';

typedef bool SettingsModifier<T extends BaseSettings>(T settings);

abstract class ISettingsManager {
  Future<T> getSettings<T extends BaseSettings>(String type);
  Future saveSettings(BaseSettings settings);
  Future<bool> modifySettings<T extends BaseSettings>(
      FutureOr<T> settingsLoader, SettingsModifier<T> modifier);
  Future<ApplicationSettings> getApplicationSettings({bool loadInner = false});
  Future saveApplicationSettings(ApplicationSettings settings);
  Future<List<ISettingListItem>> getSettingListItems();
}
