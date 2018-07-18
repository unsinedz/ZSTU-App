import 'dart:async';
import 'BaseSettings.dart';

abstract class ISettingsProvider {
  Future<BaseSettings> getSettings(String type);
  Future saveSettings(BaseSettings settings);
}