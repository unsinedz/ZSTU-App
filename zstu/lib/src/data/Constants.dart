class Constants {
  static const String DB_NAME = "main.db";
  static const int DB_VERSION = 1;
  static const String API_URI = "185.246.66.85";
  static const String ASSET_DIRECTORY = "assets/";
  static const String FACULTY_ASSETS = "faculties/";
  static const String NAVBAR_ASSETS = "nav/";
  static const int BATCH_SIZE = 50;
  static const List<String> SUPPORTED_IMAGE_EXTENSIONS = const [
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
}

class LocalizationKeys {
  static const Year = "Year_";
}