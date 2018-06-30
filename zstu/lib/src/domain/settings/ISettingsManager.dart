import 'dart:async';
import 'package:zstu/src/domain/settings/SettingsBase.dart';

abstract class ISettingsManager {
  Future<SettingsBase> getSettings(String type);
  Future saveSettings(SettingsBase settings);
}