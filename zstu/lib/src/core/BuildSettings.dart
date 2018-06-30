class BuildSettings {
  static BuildSettings _instance;
  static BuildSettings get instance =>
      _instance = _instance ?? new BuildSettings();

  bool get enableLogging => true;
}
