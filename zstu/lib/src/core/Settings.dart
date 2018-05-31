import '../ApplicationSettings.dart';

class Settings {
  static Settings _instance;
  factory Settings() {
    return _instance = _instance ?? new Settings._();
  }

  Settings._();

  bool get enableLogging => true;

  ApplicationSettings _application;
  ApplicationSettings get application => _application = _application ?? new ApplicationSettings();
}