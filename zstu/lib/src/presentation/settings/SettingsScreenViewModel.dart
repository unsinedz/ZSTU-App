import 'dart:async';
import 'package:zstu/src/App.dart';
import 'package:zstu/src/domain/settings/ApplicationSettings.dart';
import 'package:zstu/src/domain/settings/foundation/ISettingsManager.dart';
import 'package:zstu/src/presentation/common/BaseViewModel.dart';

class SettingsScreenViewModel extends BaseViewModel {
  ApplicationSettings applicationSettings;

  @override
  Future initialize() async {
    return applicationSettings =
        await new App().settings.getApplicationSettings(loadInner: true);
  }

  Future<bool> updateSettings(SettingsModifier<ApplicationSettings> modifier) {
    var settingsManager = new App().settings;
    return settingsManager.modifySettings<ApplicationSettings>(
        settingsManager.getApplicationSettings(loadInner: true), modifier);
  }

  Future reload() async {
    applicationSettings = null;
    await initialize();
  }
}
