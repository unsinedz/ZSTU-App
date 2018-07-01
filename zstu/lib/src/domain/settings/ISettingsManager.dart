import 'dart:async';
import 'package:zstu/src/domain/settings/ApplicationSettings.dart';
import 'package:zstu/src/domain/settings/BaseSettings.dart';

abstract class ISettingsManager {
  Future<BaseSettings> getSettings(String type);
  Future saveSettings(BaseSettings settings);
  Future<ApplicationSettings> getApplicationSettings();
  Future saveApplicationSettings(ApplicationSettings settings);
}