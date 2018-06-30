class Settings {
  static Settings _instance;
  factory Settings() {
    return _instance = _instance ?? new Settings._();
  }

  Settings._();

  bool get enableLogging => true;
}