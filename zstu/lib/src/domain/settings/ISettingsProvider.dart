import 'dart:async';
import 'package:zstu/src/domain/settings/BaseSettings.dart';

abstract class ISettingsProvider {
  Future<BaseSettings> getSettings(String type);
  Future saveSettings(BaseSettings settings);
}