class Constants {
  static const String DbName = "main.db";
  static const int DbVersion = 1;
  static const String ApiUri = "185.246.66.85";
  static const String AssetDirectory = "assets/";
  static const String FacultyAssets = "faculties/";
  static const String NavbarAssets = "nav/";
  static const int BatchSize = 50;
  static const List<String> SupportedImageExtensions = const [
    ".png",
    ".jpg",
    ".jpeg"
  ];
  static const String FacultyTableName = "Faculties";
  static const String GroupTableName = "Groups";
  static const String YearTableName = "Years";
  static const String ChairTableName = "Chairs";
  static const String TeacherTableName = "Teachers";
  static const String PairTableName = "Pairs";
  static const String SettingsTableName = "Settings";
  static final LocalizationKeyPrefixes localizationKeyPrefixes = new LocalizationKeyPrefixes._();
}

class LocalizationKeyPrefixes {
  LocalizationKeyPrefixes._();

  final String year = "Year_";
  final String setting = "Setting_";
}